import 'package:crud_items/features/items/data_sources/database_interface.dart';
import 'package:crud_items/features/items/models/failure/failure.dart';
import 'package:crud_items/features/items/models/item/item_model.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

@Singleton(as: DataBaseInterface)
class DataBaseRepository implements DataBaseInterface {
  static Database? _db;

  final _itemsTable = 'item_table';

  final _id = 'id';
  final _name = 'name';
  final _dateAdded = 'dateAdded';
  final _price = 'price';
  final _descriptions = 'descriptions';

  @override
  Future<Database> get db async {
    return _db ??= await initDb();
  }

  @override
  Future<Database> initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = dir.path + 'item.db';
    final _db = await openDatabase(path, version: 1, onCreate: _createDb);
    return _db;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $_itemsTable($_id INTEGER PRIMARY KEY, $_name TEXT,$_dateAdded TEXT, $_price DOUBLE, $_descriptions TEXT)',
    );
  }

  @override
  Future<Either<Failure, List<Map<String, dynamic>>>> getItemMapList() async {
    try {
      final db = await this.db;
      final List<Map<String, dynamic>> result = await db.query(_itemsTable);
      return right(result);
    } on Exception catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ItemModel>> getItem(String id) async {
    try {
      final resultList = await getItemList();

      return resultList.fold(
        (l) => left(Failure(msg: l.msg)),
        (r) {
          final result =
              r.singleWhere((element) => element.id.toString() == id);
          return right(result);
        },
      );
    } on Exception catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ItemModel>>> getItemList({
    bool sortAtoZ = true,
    String? filter,
  }) async {
    try {
      final itemMapList = await getItemMapList();

      final itemList = <ItemModel>[];
      final filterdList = <ItemModel>[];

      itemMapList.fold(
        (l) {
          return left(Failure(msg: l.msg));
        },
        (r) {
          for (final element in r) {
            final item = ItemModel.fromJson(element);

            itemList.add(item);
          }
        },
      );

      if (sortAtoZ) {
        itemList.sort((a, b) {
          int result = a.name.toLowerCase().compareTo(b.name.toLowerCase());

          return result;
        });
      } else {
        itemList.sort((a, b) {
          int result = b.name.toLowerCase().compareTo(a.name.toLowerCase());

          return result;
        });
      }

      if (filter != null) {
        for (final element in itemList) {
          if (element.name.toLowerCase().contains(filter.toLowerCase())) {
            filterdList.add(element);
          }
        }

        return right(filterdList);
      }

      return right(itemList);
    } on Exception catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  /// for insert items
  @override
  Future<Either<Failure, int>> insertItem(ItemModel item) async {
    try {
      final db = await this.db;
      final result = await db.insert(
        _itemsTable,
        item.toJson(),
        nullColumnHack: 'null',
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );

      return right(result);
    } on Exception catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  /// for updating items
  @override
  Future<Either<Failure, int>> updateItem(ItemModel item) async {
    try {
      final db = await this.db;
      final result = await db.update(
        _itemsTable,
        item.toJson(),
        where: '$_id =?',
        whereArgs: [item.id],
      );
      return right(result);
    } on Exception catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  /// for deleting items
  @override
  Future<Either<Failure, int>> deleteItem(int id) async {
    try {
      final db = await this.db;
      final result =
          await db.delete(_itemsTable, where: '$_id = ?', whereArgs: [id]);
      return right(result);
    } on Exception catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> dropTable() async {
    try {
      final db = await this.db;
      await db.execute('DROP TABLE IF EXISTS $_itemsTable');
      await db.execute(
        'CREATE TABLE $_itemsTable($_id INTEGER PRIMARY KEY, $_name TEXT,$_dateAdded TEXT, $_price TEXT, $_descriptions TEXT)',
      );

      return right(0);
    } on Exception catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }
}

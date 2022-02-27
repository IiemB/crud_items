import 'package:crud_items/features/items/models/failure/failure.dart';
import 'package:crud_items/features/items/models/item/item_model.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';

abstract class DataBaseInterface {
  Future<Database> get db;

  Future<Database> initDb();

  Future<Either<Failure, List<Map<String, dynamic>>>> getItemMapList();

  Future<Either<Failure, ItemModel>> getItem(String id);

  Future<Either<Failure, List<ItemModel>>> getItemList({
    bool sortAtoZ = true,
    String? filter,
  });

  Future<Either<Failure, int>> insertItem(ItemModel item);

  Future<Either<Failure, int>> updateItem(ItemModel item);

  Future<Either<Failure, int>> deleteItem(int id);

  Future<Either<Failure, int>> dropTable();
}

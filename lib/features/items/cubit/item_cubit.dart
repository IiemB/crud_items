import 'package:bloc/bloc.dart';
import 'package:crud_items/features/items/data_sources/database_interface.dart';
import 'package:crud_items/features/items/models/item/item_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'item_state.dart';
part 'item_cubit.freezed.dart';

@injectable
class ItemCubit extends Cubit<ItemState> {
  final DataBaseInterface _dataBaseInterface;

  ItemCubit(this._dataBaseInterface) : super(const ItemState.initial());

  void getItemList({
    bool sortAtoZ = true,
    String? filter,
  }) async {
    final result = await _dataBaseInterface.getItemList(
      sortAtoZ: sortAtoZ,
      filter: filter,
    );

    result.fold(
      (l) => emit(ItemState.error(l.msg)),
      (r) => emit(ItemState.loaded(r)),
    );
  }

  void addItem(ItemModel itemModel) async {
    final result = await _dataBaseInterface.insertItem(itemModel);

    result.fold(
      (l) => emit(ItemState.error(l.msg)),
      (r) => emit(const ItemState.success('Item added')),
    );

    getItemList();
  }

  void editItem(ItemModel itemModel) async {
    final result = await _dataBaseInterface.updateItem(itemModel);

    result.fold(
      (l) => emit(ItemState.error(l.msg)),
      (r) => emit(const ItemState.success('Item added')),
    );

    getItemList();
  }

  void deleteItem(int id) async {
    final result = await _dataBaseInterface.deleteItem(id);

    result.fold(
      (l) => emit(ItemState.error(l.msg)),
      (r) => emit(const ItemState.success('Item deleted')),
    );

    getItemList();
  }
}

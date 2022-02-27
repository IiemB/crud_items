part of 'item_cubit.dart';

@freezed
class ItemState with _$ItemState {
  const factory ItemState.initial() = ItemStateInitial;
  const factory ItemState.loading(String msg) = ItemStateLoading;
  const factory ItemState.loaded(List<ItemModel> items) = ItemStateLoaded;
  const factory ItemState.success(String msg) = ItemStateSuccess;
  const factory ItemState.error(String msg) = ItemStateError;
}

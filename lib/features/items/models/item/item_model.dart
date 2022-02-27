import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  factory ItemModel({
    required int id,
    required String name,
    required String dateAdded,
    required double price,
    required String descriptions,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> data) =>
      _$ItemModelFromJson(data);
}

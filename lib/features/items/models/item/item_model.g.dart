// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ItemModel _$$_ItemModelFromJson(Map<String, dynamic> json) => _$_ItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
      dateAdded: json['dateAdded'] as String,
      price: (json['price'] as num).toDouble(),
      descriptions: json['descriptions'] as String,
    );

Map<String, dynamic> _$$_ItemModelToJson(_$_ItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dateAdded': instance.dateAdded,
      'price': instance.price,
      'descriptions': instance.descriptions,
    };

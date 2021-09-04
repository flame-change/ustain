// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazineCategory _$MagazineCategoryFromJson(Map<String, dynamic> json) {
  return MagazineCategory(
    mid: json['mid'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    snapshotImage: json['snapshotImage'] as String?,
  );
}

Map<String, dynamic> _$MagazineCategoryToJson(MagazineCategory instance) =>
    <String, dynamic>{
      'mid': instance.mid,
      'title': instance.title,
      'description': instance.description,
      'snapshotImage': instance.snapshotImage,
    };

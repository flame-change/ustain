// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazineDetail _$MagazineDetailFromJson(Map<String, dynamic> json) {
  return MagazineDetail(
    (json['categories'] as List<dynamic>?)
        ?.map((e) => _$enumDecode(_$MagazineCategoryEnumMap, e))
        .toList(),
    json['bannerImage'] as String?,
    json['id'] as int?,
    json['content'] as String?,
    json['title'] as String?,
    json['hit'] as int?,
    json['createdAt'] as String?,
    json['updatedAt'] as String?,
    json['commentsBanned'] as bool?,
    json['likeUserCount'] as int?,
    json['isLike'] as bool?,
    json['totalComments'] as int?,
    json['isScrapped'] as bool?,
  );
}

Map<String, dynamic> _$MagazineDetailToJson(MagazineDetail instance) =>
    <String, dynamic>{
      'categories': instance.categories
          ?.map((e) => _$MagazineCategoryEnumMap[e])
          .toList(),
      'bannerImage': instance.bannerImage,
      'id': instance.id,
      'content': instance.content,
      'title': instance.title,
      'hit': instance.hit,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'commentsBanned': instance.commentsBanned,
      'likeUserCount': instance.likeUserCount,
      'isLike': instance.isLike,
      'totalComments': instance.totalComments,
      'isScrapped': instance.isScrapped,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MagazineCategoryEnumMap = {
  MagazineCategory.all: 'all',
  MagazineCategory.vegetarian: 'vegetarian',
  MagazineCategory.animals: 'animals',
  MagazineCategory.ecosystem: 'ecosystem',
  MagazineCategory.people: 'people',
};

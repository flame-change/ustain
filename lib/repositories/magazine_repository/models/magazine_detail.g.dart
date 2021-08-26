// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazineDetail _$MagazineDetailFromJson(Map<String, dynamic> json) {
  return MagazineDetail(
    categories: (json['categories'] as List<dynamic>?)
        ?.map((e) => _$enumDecode(_$MagazineCategoryEnumMap, e))
        .toList(),
    bannerImage: json['bannerImage'] as String?,
    id: json['id'] as int?,
    content: json['content'] as String?,
    title: json['title'] as String?,
    hit: json['hit'] as int?,
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    commentsBanned: json['commentsBanned'] as bool?,
    likeUserCount: json['likeUserCount'] as int?,
    totalComments: json['totalComments'] as int?,
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
      'totalComments': instance.totalComments,
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

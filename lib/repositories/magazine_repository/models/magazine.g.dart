// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Magazine _$MagazineFromJson(Map<String, dynamic> json) {
  return Magazine(
    json['id'] as int?,
    json['title'] as String?,
    json['bannerImage'] as String?,
    (json['category'] as List<dynamic>?)
        ?.map((e) => MagazineCategory.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['isLike'] as bool?,
    json['content'] as String?,
  );
}

Map<String, dynamic> _$MagazineToJson(Magazine instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isLike': instance.isLike,
      'category': instance.category,
      'bannerImage': instance.bannerImage,
      'content': instance.content,
    };

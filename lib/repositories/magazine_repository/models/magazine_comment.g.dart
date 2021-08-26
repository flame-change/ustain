// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazineComment _$MagazineCommentFromJson(Map<String, dynamic> json) {
  return MagazineComment(
    json['id'] as int,
    json['content'] as String,
    json['magazines'] as int,
    json['user'] as String,
    json['name'] as String,
    (json['reply'] as List<dynamic>?)
        ?.map((e) => MagazineComment.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['createdAt'] as String,
    json['updatedAt'] as String?,
    json['parent'] as int?,
  );
}

Map<String, dynamic> _$MagazineCommentToJson(MagazineComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'magazines': instance.magazines,
      'user': instance.user,
      'name': instance.name,
      'reply': instance.reply,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'parent': instance.parent,
    };

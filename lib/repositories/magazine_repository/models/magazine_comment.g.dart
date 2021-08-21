// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazineComment _$MagazineCommentFromJson(Map<String, dynamic> json) {
  return MagazineComment(
    json['id'] as int?,
    json['content'] as String?,
    json['magazines'] as int?,
    json['user'] as int?,
    json['name'] as String?,
    json['reply'] as int?,
    json['createdAt'] as String?,
    json['updatedAt'] as String?,
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
    };

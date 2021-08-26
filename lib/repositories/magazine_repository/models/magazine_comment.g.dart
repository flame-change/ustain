// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazineComment _$MagazineCommentFromJson(Map<String, dynamic> json) {
  return MagazineComment(
    id: json['id'] as int?,
    content: json['content'] as String?,
    magazines: json['magazines'] as int?,
    user: json['user'] as String?,
    name: json['name'] as String?,
    reply: (json['reply'] as List<dynamic>?)
        ?.map((e) => MagazineComment.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdAt: json['createdAt'] as String?,
    updatedAt: json['updatedAt'] as String?,
    parent: json['parent'] as int?,
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

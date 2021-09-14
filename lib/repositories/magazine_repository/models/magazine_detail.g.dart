// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magazine_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MagazineDetail _$MagazineDetailFromJson(Map<String, dynamic> json) {
  return MagazineDetail(
    categories: (json['categories'] as List<dynamic>?)
        ?.map((e) => e as String)
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
    products: (json['products'] as List<dynamic>?)
        ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$MagazineDetailToJson(MagazineDetail instance) =>
    <String, dynamic>{
      'categories': instance.categories,
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
      'products': instance.products,
    };

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'magazine_category.dart';

part 'magazine_detail.g.dart';

@JsonSerializable()
class MagazineDetail extends Equatable {
  const MagazineDetail({
      this.categories,
      this.bannerImage,
      this.id,
      this.content,
      this.title,
      this.hit,
      this.createdAt,
      this.updatedAt,
      this.commentsBanned,
      this.likeUserCount,
      this.totalComments,
  });

  final List<String>? categories;
  final String? bannerImage;
  final int? id;
  final String? content;
  final String? title;
  final int? hit;
  final String? createdAt;
  final String? updatedAt;
  final bool? commentsBanned;
  final int? likeUserCount;
  final int? totalComments;

  factory MagazineDetail.fromJson(Map<String, dynamic> json) =>
      _$MagazineDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MagazineDetailToJson(this);

  @override
  List<Object?> get props => [
        categories,
        bannerImage,
        id,
        content,
        title,
        hit,
        createdAt,
        updatedAt,
        commentsBanned,
        likeUserCount,
        totalComments,
      ];

  MagazineDetail copyWith(
      {List<String>? categories,
      String? bannerImage,
      int? id,
      String? content,
      String? title,
      int? hit,
      String? createdAt,
      String? updatedAt,
      bool? commentsBanned,
      int? likeUserCount,
      int? totalComments
      }) {
    return MagazineDetail(
      categories: categories ?? this.categories,
      bannerImage: bannerImage ?? this.bannerImage,
      id: id ?? this.id,
      content: content ?? this.content,
      title: title ?? this.title,
      hit: hit ?? this.hit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      commentsBanned: commentsBanned ?? this.commentsBanned,
      likeUserCount: likeUserCount ?? this.likeUserCount,
      totalComments: totalComments ?? this.totalComments,
    );
  }
}

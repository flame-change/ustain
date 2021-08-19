import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'magazine.dart';

part 'magazine_detail.g.dart';

@JsonSerializable()
class MagazineDetail extends Equatable {
  const MagazineDetail(this.categories,
      this.bannerImage,
      this.id,
      this.content,
      this.title,
      this.hit,
      this.createdAt,
      this.updatedAt,
      this.commentsBanned,
      this.likeUserCount,
      this.isLike,
      this.totalComments,
      this.isScrapped);

  final List<MagazineCategory>? categories;
  final String? bannerImage;
  final int? id;
  final String? content;
  final String? title;
  final int? hit;
  final String? createdAt;
  final String? updatedAt;
  final bool? commentsBanned;
  final int? likeUserCount;
  final bool? isLike;
  final int? totalComments;
  final bool? isScrapped;

  factory MagazineDetail.fromJson(Map<String, dynamic> json) =>
      _$MagazineDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MagazineDetailToJson(this);

  @override
  List<Object?> get props =>
      [
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
        isLike,
        totalComments,
        isScrapped
      ];
}
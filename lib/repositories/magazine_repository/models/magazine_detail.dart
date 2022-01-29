import 'package:aroundus_app/repositories/product_repository/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'magazine_detail.g.dart';

@JsonSerializable()
class MagazineDetail extends Equatable {
  const MagazineDetail({
    this.categories,
    this.bannerImage,
    this.id,
    this.magazineUrl,
    this.title,
    this.subtitle,
    this.hit,
    this.createdAt,
    this.updatedAt,
    this.commentsBanned,
    this.likeUserCount,
    this.totalComments,
    this.products,
  });

  final List<String>? categories;
  final String? bannerImage;
  final int? id;
  final String? magazineUrl;
  final String? title;
  final String? subtitle;
  final int? hit;
  final String? createdAt;
  final String? updatedAt;
  final bool? commentsBanned;
  final int? likeUserCount;
  final int? totalComments;
  final List<Map>? products;

  factory MagazineDetail.fromJson(Map<String, dynamic> json) =>
      _$MagazineDetailFromJson(json);

  Map<String, dynamic> toJson() => _$MagazineDetailToJson(this);

  @override
  List<Object?> get props => [
        categories,
        bannerImage,
        id,
        magazineUrl,
        title,
        hit,
        createdAt,
        updatedAt,
        commentsBanned,
        likeUserCount,
        totalComments,
        products,
      ];

  MagazineDetail copyWith(
      {List<String>? categories,
      String? bannerImage,
      int? id,
      String? magazineUrl,
      String? title,
      int? hit,
      String? createdAt,
      String? updatedAt,
      bool? commentsBanned,
      int? likeUserCount,
      int? totalComments,
      List<Map>? products}) {
    return MagazineDetail(
      categories: categories ?? this.categories,
      bannerImage: bannerImage ?? this.bannerImage,
      id: id ?? this.id,
      magazineUrl: magazineUrl ?? this.magazineUrl,
      title: title ?? this.title,
      hit: hit ?? this.hit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      commentsBanned: commentsBanned ?? this.commentsBanned,
      likeUserCount: likeUserCount ?? this.likeUserCount,
      totalComments: totalComments ?? this.totalComments,
      products: products ?? this.products,
    );
  }
}

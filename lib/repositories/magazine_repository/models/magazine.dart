import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'magazine_category.dart';

part 'magazine.g.dart';

@JsonSerializable()
class Magazine extends Equatable {
  const Magazine(this.id, this.title, this.subtitle, this.bannerImage,
      this.categories, this.magazineUrl);

  final int? id;
  final String? title;
  final String? subtitle;
  final List<String>? categories;
  final String? bannerImage;
  final String? magazineUrl;

  factory Magazine.fromJson(Map<String, dynamic> json) =>
      _$MagazineFromJson(json);
  Map<String, dynamic> toJson() => _$MagazineToJson(this);

  @override
  List<Object?> get props =>
      [id, title, subtitle, categories, bannerImage, magazineUrl];
}

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'magazine.g.dart';

@JsonSerializable()
class Magazine extends Equatable {
  const Magazine(
      this.id, this.title, this.bannerImage, this.category, this.isLike, this.content);

  final int? id;
  final String? title;
  final bool? isLike;
  final List<String>? category;
  final String? bannerImage;
  final String? content;

  factory Magazine.fromJson(Map<String, dynamic> json) => _$MagazineFromJson(json);
  Map<String, dynamic> toJson() => _$MagazineToJson(this);

  @override
  List<Object?> get props => [id, title, isLike, category, bannerImage, content];
}

enum MagazineCategory { all, vegetarian, animals, ecosystem, people }

extension MagazineCategoryToString on MagazineCategory {
  String get name {
    return ["전체보기","비건", "동물보호", "환경보호", "인권보호"][this.index];
  }

  String get toValue {
    return ["", "vegetarian", "animals", "ecosystem", "people"][this.index];
  }
}
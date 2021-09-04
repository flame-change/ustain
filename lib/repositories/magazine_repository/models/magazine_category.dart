import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'magazine_category.g.dart';

@JsonSerializable()
class MagazineCategory extends Equatable {
  const MagazineCategory(
      {this.mid, this.title, this.description, this.snapshotImage});

  final String? mid;
  final String? title;
  final String? description;
  final String? snapshotImage;

  factory MagazineCategory.fromJson(Map<String, dynamic> json) =>
      _$MagazineCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$MagazineCategoryToJson(this);

  @override
  List<Object?> get props => [mid, title, description, snapshotImage];

}

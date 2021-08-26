import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'magazine_comment.g.dart';

@JsonSerializable()
class MagazineComment extends Equatable {
  const MagazineComment({this.id, this.content, this.magazines, this.user,
    this.name, this.reply, this.createdAt, this.updatedAt, this.parent});

  final int? id;
  final String? content;
  final int? magazines;
  final String? user;
  final String? name;
  final List<MagazineComment>? reply;
  final String? createdAt;
  final String? updatedAt;
  final int? parent;

  factory MagazineComment.fromJson(Map<String, dynamic> json) =>
      _$MagazineCommentFromJson(json);

  Map<String, dynamic> toJson() => _$MagazineCommentToJson(this);

  @override
  List<Object?> get props =>
      [id, content, magazines, user, name, reply, createdAt, updatedAt, parent];

  MagazineComment copyWith({int? id,
    String? content,
    int? magazines,
    String? user,
    String? name,
    List<MagazineComment>? reply,
    String? createdAt,
    String? updatedAt,
    int? parent}) {
    return MagazineComment(
        id: id ?? this.id,
        content: content?? this.content,
        magazines: magazines?? this.magazines,
        user: user ?? this.user,
        name: name ?? this.name,
        reply: reply ?? this.reply,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt?? this.updatedAt,
        parent: parent ?? this.parent
    );
  }
}

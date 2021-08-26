import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {this.groups,
      this.phone,
      this.email,
      this.name,
      this.profileArticle,
      this.sexChoices,
      this.birthday,
      this.categories});

  final String? groups;
  final String? phone;
  final String? email;
  final String? name;
  final String? profileArticle;
  final String? sexChoices;
  final String? birthday; // 자료형 확인
  final List<dynamic>? categories;

  @override
  List<Object?> get props => [
        groups,
        phone,
        email,
        name,
        profileArticle,
        sexChoices,
        birthday,
        categories
      ];

  static const empty = User();
}

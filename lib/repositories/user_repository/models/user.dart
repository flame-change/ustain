import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({ this.email,
    this.phone,
    this.name,
    this.profileArticle,
    this.birthday,
    this.sexChoices,
    this.categories});

  final String? phone;
  final String? email;
  final String? name;
  final String? profileArticle;
  final String? sexChoices;
  final String? birthday; // 자료형 확인
  final List<dynamic>? categories;

  @override
  List<Object> get props =>
      [
        // phone,
        // email,
        // name!,
        // profileArticle!,
        // sexChoices!,
        // birthday!,
        // categories!
      ];

  static const empty = User();
}

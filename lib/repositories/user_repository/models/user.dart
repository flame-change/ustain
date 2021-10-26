import 'package:aroundus_app/repositories/store_repository/models/collection.dart';
import 'package:aroundus_app/repositories/store_repository/models/menu.dart';
import 'package:equatable/equatable.dart';
import 'package:aroundus_app/repositories/magazine_repository/models/models.dart';

class User extends Equatable {
  const User({
    this.groups,
    this.phone,
    this.email,
    this.name,
    this.profileArticle,
    this.sexChoices,
    this.birthday,
    this.selectedCategories,
    // this.categories,
    // this.collections,
    // this.cartCount,
  });

  final String? groups;
  final String? phone;
  final String? email;
  final String? name;
  final String? profileArticle;
  final String? sexChoices;
  final String? birthday; // 자료형 확인
  final List<dynamic>? selectedCategories;
  // final List<MagazineCategory>? categories;
  // final List<Menu>? collections;
  // final int? cartCount;

  @override
  List<Object?> get props => [
        groups,
        phone,
        email,
        name,
        profileArticle,
        sexChoices,
        birthday,
        selectedCategories,
        // categories,
        // collections,
        // cartCount,
      ];

  User copyWith({
    String? groups,
    String? phone,
    String? email,
    String? name,
    String? profileArticle,
    String? sexChoices,
    String? birthday,
    List<dynamic>? selectedCategories,
    // List<MagazineCategory>? categories,
    // List<Menu>? collections,
    int? cartCount,
  }) {
    return User(
      groups: groups ?? this.groups,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      name: name ?? this.name,
      profileArticle: profileArticle ?? this.profileArticle,
      sexChoices: sexChoices ?? this.sexChoices,
      birthday: birthday ?? this.birthday,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      // categories: categories ?? this.categories,
      // collections: collections ?? this.collections,
      // cartCount: cartCount ?? this.cartCount,
    );
  }

  static const empty = User();

  // String categoryTransfer(String word) {
  //   String transfer = "";
  //
  //   this.categories!.forEach((category) {
  //     if (category.mid == word && RegExp(r'[a-zA-Z]$').hasMatch(word)) {
  //       transfer = category.title!;
  //     }
  //   });
  //
  //   return transfer == "" ? word : transfer;
  // }
}

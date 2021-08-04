import 'package:aroundus_app/repositories/user_repository/models/user.dart';
import 'package:aroundus_app/support/networks/dio_client.dart';

class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  User? _user;

  Future<User?> getUser() async {
    if (_user != null) return _user;
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User("const Uuid().v4()"),
    );
  }
}

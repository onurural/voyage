import 'package:voyage/models/user.dart';

abstract class UserRepository {
  Future<User> getUserCredential({required String userId});
}
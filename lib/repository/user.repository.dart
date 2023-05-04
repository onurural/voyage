import 'package:voyage/bloc/user/user.event.dart';
import 'package:voyage/models/interested-category.dart';
import 'package:voyage/models/interested-city.dart';
import 'package:voyage/models/user.dart';

abstract class UserRepository {
  Future<User> getUserCredential({required String userId});
}
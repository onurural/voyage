
abstract class AuthRepository {
  Future<void> login({required String email, required String password});
  Future<void> signup({required String email, required String password});
  Future<void> saveUserToMongoDB({required String email, required String userId, required String userName});
}
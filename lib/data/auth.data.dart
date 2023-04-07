import 'package:firebase_auth/firebase_auth.dart';
import 'package:voyage/repository/auth.repository.dart';

class AuthData implements AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  
  @override
  Future<void> login({required String email, required String password}) async {
    try {
       await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        throw Exception('this password is too weak');
      } else if(e.code == 'email-already-in-use') {
        throw Exception('this email is already in use');
      }
    } 
    catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signup({required String email, required String password}) async {
    try {
       await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        throw Exception('this password is too weak');
      } else if(e.code == 'email-already-in-use') {
        throw Exception('this email is already in use');
      }
    } 
    catch (e) {
      throw Exception(e.toString());
    }
  }

}
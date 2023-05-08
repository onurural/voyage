import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:voyage/repository/auth.repository.dart';
import 'package:http/http.dart' as http;
import 'package:voyage/utility/constants.dart';


class AuthData implements AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  
  
  @override
  Future<UserCredential> login({required String email, required String password}) async {
    var credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return credential;
    
  }

  @override
  Future<UserCredential> signup({required String email, required String password}) async {
    var credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return credential;
  }

  String? getCurrentUserId()  {
    var userId = _firebaseAuth.currentUser?.uid;
    return userId;
  }
  
  @override
  Future<void> saveUserToMongoDB({required String email, required String userId, required String userName}) async {
        try {
        var url = Uri.https(apiURL, userEndpoint);
        await http.post(url, body: {
          'email': email,
          'userId': userId, 
          'userName': userName
        });
      } catch (e) {
        debugPrint(e.toString());
      }
  }
  

}
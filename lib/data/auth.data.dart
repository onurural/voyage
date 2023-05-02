import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:voyage/repository/auth.repository.dart';
import 'package:http/http.dart' as http;
import 'package:voyage/models/user.dart' as User;


class AuthData implements AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  static const apiURL = 'service1-dot-voyage-368821.lm.r.appspot.com';
  static const endpoint = '/user';
  
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
        var url = Uri.https(apiURL, endpoint);
        await http.post(url, body: {
          'email': email,
          'userId': userId, 
          'userName': userName
        });
      } catch (e) {
        //print(e.toString());
      }
  }
  
  @override
  Future<User.User> getUserCredential({required String userId}) async {
    try {
      var url = Uri.https(apiURL, endpoint, {'userId': userId});
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> decodedUser = json.decode(response.body) as Map<String, dynamic>;
           return User.User.fromJson(decodedUser);
        }
      }
      throw HttpException('Unexpected status code: ${response.statusCode}');
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
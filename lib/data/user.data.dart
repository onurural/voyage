
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:voyage/models/user.dart';
import 'package:voyage/repository/user.repository.dart';
import 'package:http/http.dart' as http;
import 'package:voyage/utility/constants.dart';


class UserData implements UserRepository {


  static const queryParameter = 'userId';

    @override
  Future<User> getUserCredential({required String userId}) async {
    try {
      var url = Uri.https(apiURL, userEndpoint, {queryParameter: userId});
      final response = await http.get(url);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> decodedUser = json.decode(response.body) as Map<String, dynamic>;
          return User.fromJson(decodedUser);
        }
      }
      throw HttpException('Unexpected status code: ${response.statusCode}');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
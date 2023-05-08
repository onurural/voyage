
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:voyage/models/interested-category.dart';
import 'package:http/http.dart' as http;
import 'package:voyage/repository/interested-category.repository.dart';
import 'package:voyage/utility/constants.dart';

class InterestedCategoryData implements InterestedCategoryRepository {


  static const queryParameter = 'userId';
  

  @override
  Future<List<InterestedCategory>> fetchInterestedCategories({required String userId}) async {
    var endpoint = userEndpoint + interestedCategoriesEndpoint;
    try {
      var url = Uri.https(apiURL, endpoint, {queryParameter: userId});
      final response = await http.get(url);
      if (response.statusCode == 200) {
          if (response.body.isNotEmpty) {
            List<dynamic> data = json.decode(response.body);
            List<InterestedCategory> interestedCategories = data.map((json) => InterestedCategory.fromJson(json)).toList();
            return interestedCategories;
          }
      }
      throw HttpException('Unexpected status code: ${response.statusCode}');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
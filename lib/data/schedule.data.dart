import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:voyage/models/user-schedules.dart';
import 'package:voyage/repository/schedule.repository.dart';
import 'package:http/http.dart' as http;
import 'package:voyage/models/schedule.dart';
import 'package:voyage/utility/constants.dart';


class ScheduleData implements ScheduleRepository {
  @override
  Future<bool> postSchedule({required Schedule schedule}) async {
    try {
      var url = Uri.https(apiURL, scheduleEndpoint);
      var jsonSchedule=jsonEncode(schedule);
      final response = await http.post(url, body: jsonSchedule,headers: {"Content-Type":"application/json"});
      var statusCode=response.statusCode;

      return response.statusCode == 201;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<List<UserSchedule>> fetchSchedule({required String userId}) async {
    try {
      var url = Uri.https(apiURL, scheduleEndpoint, {'userId': userId});
      final response = await http.get(url);
      if (response.body.isNotEmpty) {

          List<dynamic> data = json.decode(response.body);

          List<UserSchedule> placesToTravel = data.map((json) => UserSchedule.fromJson(json)).toList();


            return placesToTravel;
        }
        throw HttpException('Unexpected status code : ${response.statusCode}');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
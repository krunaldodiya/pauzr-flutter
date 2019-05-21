import 'dart:async';

import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/resources/client.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  Future getAuthUser() async {
    return sendRequest(Api.me);
  }

  Future getEarnedPoints() async {
    return sendRequest(Api.getEarnedPoints);
  }

  Future getSavedMinutes() async {
    return sendRequest(Api.getSavedMinutes);
  }

  Future getRankings(String period) async {
    return sendRequest(Api.getRankings, {
      "period": period,
    });
  }

  Future requestOtp(String mobile) async {
    return sendRequest(Api.requestOtp, {
      "mobile": mobile,
    });
  }

  Future verifyOtp(String mobile, int otp) async {
    return sendRequest(Api.verifyOtp, {
      "mobile": mobile,
      "otp": otp.toString(),
    });
  }

  Future setTimer(int duration) async {
    return sendRequest(Api.setTimer, {
      "duration": duration,
    });
  }

  Future updateProfile(User user) async {
    return sendRequest(Api.updateProfile, {
      "id": user.id.toString(),
      "name": user.name,
      "email": user.email,
      "dob": user.dob,
      "gender": user.gender,
      "location_id": user.location.id.toString(),
      "profession_id": user.profession.id.toString(),
    });
  }

  Future getLocations() async {
    return sendRequest(Api.getLocations);
  }

  Future getProfessions() async {
    return sendRequest(Api.getProfessions);
  }

  Future uploadAvatar(FormData image) async {
    return sendRequest(Api.uploadAvatar, {
      "image": image,
    });
  }
}

class Api {
  static String me = "$baseUrl/api/users/me";
  static String requestOtp = "$baseUrl/api/otp/request-otp";
  static String verifyOtp = "$baseUrl/api/otp/verify-otp";
  static String getLocations = "$baseUrl/api/home/locations";
  static String getProfessions = "$baseUrl/api/home/professions";
  static String updateProfile = "$baseUrl/api/users/update";
  static String uploadAvatar = "$baseUrl/api/users/avatar/upload";
  static String getEarnedPoints = "$baseUrl/api/timer/points";
  static String getSavedMinutes = "$baseUrl/api/timer/minutes";
  static String getRankings = "$baseUrl/api/timer/rankings";
  static String setTimer = "$baseUrl/api/timer/set";
}

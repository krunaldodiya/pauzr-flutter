import 'dart:async';

import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/user.dart';
import 'package:pauzr/src/resources/client.dart';
import 'package:dio/dio.dart';

class ApiProvider {
  Future getAuthUser() async {
    return sendRequest(Api.me);
  }

  Future getGroups() async {
    return sendRequest(Api.getGroups);
  }

  Future getWalletHistory() async {
    return sendRequest(Api.getWalletHistory);
  }

  Future getTimerHistory() async {
    return sendRequest(Api.getTimerHistory);
  }

  Future getRankings(String period, [int groupId]) async {
    return sendRequest(Api.getRankings, {
      "period": period,
      "groupId": groupId,
    });
  }

  Future requestOtp(String mobile) async {
    return sendRequest(Api.requestOtp, {
      "mobile": mobile,
    });
  }

  Future verifyOtp(String mobile, int otp, String fcmToken) async {
    return sendRequest(Api.verifyOtp, {
      "mobile": mobile,
      "otp": otp,
      "fcm_token": fcmToken,
    });
  }

  Future setTimer(int duration) async {
    return sendRequest(Api.setTimer, {
      "duration": duration,
    });
  }

  Future createGroup(String name, String description, String photo) async {
    return sendRequest(Api.createGroup, {
      "name": name,
      "description": description,
      "photo": photo,
    });
  }

  Future editGroup(
    int groupId,
    String name,
    String description,
    String photo,
  ) async {
    return sendRequest(Api.editGroup, {
      "groupId": groupId,
      "name": name,
      "description": description,
      "photo": photo,
    });
  }

  Future addParticipants(int groupId, List participants) async {
    return sendRequest(Api.addParticipants, {
      "groupId": groupId,
      "participants": participants,
    });
  }

  Future removeParticipants(int groupId, int userId) async {
    return sendRequest(Api.removeParticipants, {
      "groupId": groupId,
      "userId": userId,
    });
  }

  Future exitGroup(int groupId, int userId) async {
    return sendRequest(Api.exitGroup, {
      "groupId": groupId,
      "userId": userId,
    });
  }

  Future deleteGroup(int groupId, int userId) async {
    return sendRequest(Api.deleteGroup, {
      "groupId": groupId,
      "userId": userId,
    });
  }

  Future updateProfile(User user) async {
    return sendRequest(Api.updateProfile, {
      "id": user.id,
      "name": user.name,
      "email": user.email,
      "dob": user.dob,
      "gender": user.gender,
      "location_id": user.location.id,
    });
  }

  Future getLocations() async {
    return sendRequest(Api.getLocations);
  }

  Future getProfessions() async {
    return sendRequest(Api.getProfessions);
  }

  Future uploadAvatar(FormData image) async {
    return sendRequest(Api.uploadAvatar, image);
  }

  Future uploadGroupImage(FormData image) async {
    return sendRequest(Api.uploadGroupImage, image);
  }

  Future syncContacts(contacts) async {
    return sendRequest(Api.syncContacts, {
      "contacts": contacts,
    });
  }

  Future notifyError(error) async {
    return sendRequest(Api.notifyError, {
      "error": error,
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
  static String getWalletHistory = "$baseUrl/api/timer/points";
  static String getTimerHistory = "$baseUrl/api/timer/minutes";
  static String getRankings = "$baseUrl/api/timer/rankings";
  static String setTimer = "$baseUrl/api/timer/set";
  static String createGroup = "$baseUrl/api/groups/create";
  static String editGroup = "$baseUrl/api/groups/edit";
  static String exitGroup = "$baseUrl/api/groups/exit";
  static String deleteGroup = "$baseUrl/api/groups/delete";
  static String addParticipants = "$baseUrl/api/groups/add-participants";
  static String removeParticipants = "$baseUrl/api/groups/remove-participants";
  static String getGroups = "$baseUrl/api/groups/get";
  static String uploadGroupImage = "$baseUrl/api/groups/image/upload";
  static String syncContacts = "$baseUrl/api/groups/sync-contacts";
  static String notifyError = "$baseUrl/api/error/notify";
}

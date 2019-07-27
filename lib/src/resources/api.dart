import 'dart:async';

import 'package:dio/dio.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/country.dart';
import 'package:pauzr/src/resources/client.dart';

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

  Future getRankings(String period, String location, [int groupId]) async {
    return sendRequest(Api.getRankings, {
      "period": period,
      "location": location,
      "groupId": groupId,
    });
  }

  Future getWinners(String period) async {
    return sendRequest(Api.getWinners, {
      "period": period,
    });
  }

  Future getLotteryWinners() async {
    return sendRequest(Api.getLotteryWinners);
  }

  Future getLotteryHistory() async {
    return sendRequest(Api.getLotteryHistory);
  }

  Future requestOtp(String mobile, Country country) async {
    return sendRequest(Api.requestOtp, {
      "mobile": mobile,
      "country": {
        "id": country.id,
        "name": country.name,
        "shortname": country.shortname,
        "phonecode": country.phonecode,
      },
    });
  }

  Future verifyOtp(
    String mobile,
    Country country,
    int otp,
    String fcmToken,
  ) async {
    return sendRequest(Api.verifyOtp, {
      "mobile": mobile,
      "country": {
        "id": country.id,
        "name": country.name,
        "shortname": country.shortname,
        "phonecode": country.phonecode,
      },
      "otp": otp,
      "fcm_token": fcmToken,
    });
  }

  Future setTimer(int duration) async {
    return sendRequest(Api.setTimer, {
      "duration": duration,
    });
  }

  Future getQuotes() async {
    return sendRequest(Api.getQuotes);
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

  Future updateProfile(Map data) async {
    return sendRequest(Api.updateProfile, data);
  }

  Future getCities() async {
    return sendRequest(Api.getCities);
  }

  Future getLotteries(int selectedLotteryIndex) async {
    return sendRequest(Api.getLotteries, {
      "selectedLotteryIndex": selectedLotteryIndex,
    });
  }

  Future getCountries() async {
    return sendRequest(Api.getCountries);
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
  static String getCities = "$baseUrl/api/home/cities";
  static String getLotteries = "$baseUrl/api/lotteries/get";
  static String getLotteryWinners = "$baseUrl/api/lotteries/winners";
  static String getLotteryHistory = "$baseUrl/api/lotteries/history";
  static String getCountries = "$baseUrl/api/home/countries";
  static String getProfessions = "$baseUrl/api/home/professions";
  static String updateProfile = "$baseUrl/api/users/update";
  static String uploadAvatar = "$baseUrl/api/users/avatar/upload";
  static String getWalletHistory = "$baseUrl/api/timer/points";
  static String getTimerHistory = "$baseUrl/api/timer/minutes";
  static String getRankings = "$baseUrl/api/timer/rankings";
  static String getWinners = "$baseUrl/api/timer/winners";
  static String setTimer = "$baseUrl/api/timer/set";
  static String getQuotes = "$baseUrl/api/home/quotes";
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

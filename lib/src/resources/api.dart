import 'dart:async';

import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/models/country.dart';
import 'package:pauzr/src/resources/client.dart';

class ApiProvider {
  Future getAuthUser() async {
    return sendRequest(Api.me);
  }

  Future getGuestUser(int userId) async {
    return sendRequest(Api.getGuestUser, {
      "user_id": userId,
    });
  }

  Future toggleFavorite(int postId) async {
    return sendRequest(Api.toggleFavorite, {
      "post_id": postId,
    });
  }

  Future redeemPoints(int postId) async {
    return sendRequest(Api.redeemPoints, {
      "post_id": postId,
    });
  }

  Future getAdsKeywords() async {
    return sendRequest(Api.getAdsKeywords);
  }

  Future getUserNotifications() async {
    return sendRequest(Api.getUserNotifications);
  }

  Future markAsRead(String notificationId) async {
    return sendRequest(Api.markAsRead, {
      "notification_id": notificationId,
    });
  }

  Future followUser(int followingId, int guestId) async {
    return sendRequest(Api.followUser, {
      "following_id": followingId,
      "guest_id": guestId,
    });
  }

  Future unfollowUser(int followingId, int guestId) async {
    return sendRequest(Api.unfollowUser, {
      "following_id": followingId,
      "guest_id": guestId,
    });
  }

  Future setAdImpression(String type) async {
    return sendRequest(Api.setAdImpression, {
      "type": type,
    });
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

  Future getLotteryWinners(int page) async {
    return sendRequest(Api.getLotteryWinners, {"page": page});
  }

  Future getPosts(int page, int userId) async {
    return sendRequest(Api.getPosts, {"page": page, 'user_id': userId});
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
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

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
      "version": packageInfo.version,
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

  Future getCategories() async {
    return sendRequest(Api.categories);
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

  Future withdrawAmount(int amount) async {
    return sendRequest(Api.withdrawAmount, {
      "amount": amount,
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

  Future createPost(String description, String photo) async {
    return sendRequest(Api.createPost, {
      "description": description,
      "photo": photo,
    });
  }

  Future getPostDetail(int postId) async {
    return sendRequest(Api.getPostDetail, {
      "post_id": postId,
    });
  }

  Future deletePost(int postId) async {
    return sendRequest(Api.deletePost, {
      "post_id": postId,
    });
  }

  Future editPost(
    int postId,
    String description,
    String photo,
  ) async {
    return sendRequest(Api.editPost, {
      "postId": postId,
      "description": description,
      "photo": photo,
    });
  }

  Future uploadPostImage(FormData image) async {
    return sendRequest(Api.uploadPostImage, image);
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
  static String categories = "$baseUrl/api/categories/all";
  static String me = "$baseUrl/api/users/me";
  static String followUser = "$baseUrl/api/users/follow";
  static String unfollowUser = "$baseUrl/api/users/unfollow";
  static String getGuestUser = "$baseUrl/api/users/guest";
  static String getUserNotifications = "$baseUrl/api/users/notifications";
  static String markAsRead = "$baseUrl/api/users/notifications/read";
  static String getAdsKeywords = "$baseUrl/api/home/keywords";
  static String setAdImpression = "$baseUrl/api/ads/impression";
  static String getPosts = "$baseUrl/api/posts/list";
  static String requestOtp = "$baseUrl/api/otp/request-otp";
  static String verifyOtp = "$baseUrl/api/otp/verify-otp";
  static String getCities = "$baseUrl/api/home/cities";
  static String getLotteries = "$baseUrl/api/lotteries/get";
  static String withdrawAmount = "$baseUrl/api/lotteries/withdraw";
  static String getLotteryWinners = "$baseUrl/api/lotteries/winners";
  static String getLotteryHistory = "$baseUrl/api/lotteries/history";
  static String getCountries = "$baseUrl/api/home/countries";
  static String getProfessions = "$baseUrl/api/home/professions";
  static String updateProfile = "$baseUrl/api/users/update";
  static String uploadAvatar = "$baseUrl/api/users/avatar/upload";
  static String getPostDetail = "$baseUrl/api/posts/detail";
  static String createPost = "$baseUrl/api/posts/create";
  static String deletePost = "$baseUrl/api/posts/delete";
  static String editPost = "$baseUrl/api/posts/edit";
  static String toggleFavorite = "$baseUrl/api/posts/like";
  static String redeemPoints = "$baseUrl/api/posts/redeem";
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
  static String uploadPostImage = "$baseUrl/api/posts/image/upload";
  static String syncContacts = "$baseUrl/api/groups/sync-contacts";
  static String notifyError = "$baseUrl/api/error/notify";
}

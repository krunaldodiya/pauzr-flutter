import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/resources/api.dart';

class OtpBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error;
  String mobile;
  int clientOtp;
  int serverOtp;

  get isValidMobile {
    return mobile != null && error == null;
  }

  get isValidOtp {
    return clientOtp != null && error == null;
  }

  onChangeMobile(String input) {
    mobile = input.length > 0 ? input : null;
    error = null;

    notifyListeners();
  }

  onChangeClientOtp(String otp) {
    clientOtp = otp.length > 0 ? int.parse(otp) : null;
    error = null;

    notifyListeners();
  }

  requestOtp() async {
    loading = true;

    try {
      final Response response = await _apiProvider.requestOtp(mobile);
      final results = response.data;

      serverOtp = results['otp'];
    } catch (e) {
      error = e.response.data;
    }

    loading = false;
    loaded = true;

    notifyListeners();
  }

  verifyOtp(UserBloc userBloc) async {
    loading = true;

    try {
      final Response response = await _apiProvider.verifyOtp(mobile, serverOtp);
      final results = response.data;

      await userBloc.setAuthToken(results['access_token']);
      await userBloc.setAuthUser(results['user']);
    } catch (e) {
      error = e.response.data;
    }

    loading = false;
    loaded = true;

    notifyListeners();
  }
}

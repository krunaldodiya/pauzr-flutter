import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pauzr/src/models/country.dart';
import 'package:pauzr/src/providers/user.dart';
import 'package:pauzr/src/resources/api.dart';

class OtpBloc extends ChangeNotifier {
  final ApiProvider _apiProvider = ApiProvider();

  bool loading;
  bool loaded;
  Map error = const {};
  String mobile;
  int clientOtp;
  int serverOtp;
  Country country;

  get isValidMobile {
    return mobile != null && error == null;
  }

  get isValidOtp {
    return clientOtp != null && error == null;
  }

  setState({
    bool loading,
    bool loaded,
    Map error,
    String mobile,
    int clientOtp,
    int serverOtp,
    Country country,
  }) {
    this.loading = loading ?? this.loading;
    this.loaded = loaded ?? this.loaded;
    this.error = identical(error, {}) ? this.error : error;
    this.mobile = mobile ?? this.mobile;
    this.clientOtp = clientOtp ?? this.clientOtp;
    this.serverOtp = serverOtp ?? this.serverOtp;
    this.country = country ?? this.country;

    notifyListeners();
  }

  onChangeMobile(String input) {
    setState(mobile: input.length > 0 ? input : null, error: null);
  }

  onChangeClientOtp(String otp) {
    setState(clientOtp: otp.length > 0 ? int.parse(otp) : null, error: null);
  }

  onChangeCountry(Country country) {
    setState(country: country, error: null);
  }

  requestOtp() async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.requestOtp(mobile, country);
      final results = response.data;

      setState(serverOtp: results['otp'], loading: false, loaded: true);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }

  verifyOtp(UserBloc userBloc, String fcmToken) async {
    setState(loading: true, loaded: false);

    try {
      final Response response = await _apiProvider.verifyOtp(
        mobile,
        country,
        clientOtp,
        fcmToken,
      );

      final results = response.data;

      await userBloc.setAuthToken(results['access_token']);
      await userBloc.setUser(results['user']);

      setState(loading: false, loaded: true);
    } catch (error) {
      setState(error: error.response.data, loading: false, loaded: true);
    }
  }
}

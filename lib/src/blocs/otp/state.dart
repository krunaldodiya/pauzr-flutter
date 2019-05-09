import 'package:meta/meta.dart';

@immutable
class OtpState {
  final bool loading;
  final bool loaded;
  final Map error;
  final String mobile;
  final int clientOtp;
  final int serverOtp;

  OtpState({
    @required this.loading,
    @required this.loaded,
    @required this.error,
    @required this.mobile,
    @required this.clientOtp,
    @required this.serverOtp,
  });

  factory OtpState.initial() {
    return OtpState(
      loading: false,
      loaded: false,
      error: null,
      mobile: null,
      clientOtp: null,
      serverOtp: null,
    );
  }

  OtpState copyWith({
    bool loading,
    bool loaded,
    Map error,
    String mobile,
    int clientOtp,
    int serverOtp,
  }) {
    return OtpState(
      loading: loading ?? this.loading,
      loaded: loaded ?? this.loaded,
      error: error ?? this.error,
      mobile: mobile ?? this.mobile,
      clientOtp: clientOtp ?? this.clientOtp,
      serverOtp: serverOtp ?? this.serverOtp,
    );
  }
}

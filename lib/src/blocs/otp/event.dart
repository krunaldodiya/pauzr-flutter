abstract class OtpEvent {}

class ChangeMobile extends OtpEvent {
  String mobile;

  ChangeMobile({this.mobile});
}

class ChangeOtp extends OtpEvent {
  int clientOtp;

  ChangeOtp({this.clientOtp});
}

class RequestOtp extends OtpEvent {
  Function callback;

  RequestOtp({this.callback});
}

class VerifyOtp extends OtpEvent {
  Function callback;

  VerifyOtp({this.callback});
}

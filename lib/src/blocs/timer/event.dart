abstract class TimerEvent {}

class SetTimer extends TimerEvent {
  int seconds;
  Function callback;

  SetTimer({this.seconds, this.callback});
}

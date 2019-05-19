abstract class TimerEvent {}

class SetTimer extends TimerEvent {
  int duration;
  Function callback;

  SetTimer({this.duration, this.callback});
}

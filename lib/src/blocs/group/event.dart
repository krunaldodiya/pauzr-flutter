abstract class GroupEvent {}

class CreateGroup extends GroupEvent {
  String name;
  Function callback;

  CreateGroup({this.name, this.callback});
}

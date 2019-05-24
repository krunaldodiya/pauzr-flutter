abstract class GroupEvent {}

class CreateGroup extends GroupEvent {
  String name;
  String photo;
  Function callback;

  CreateGroup({this.name, this.photo, this.callback});
}

class AddParticipants extends GroupEvent {
  int groupId;
  List participants;
  Function callback;

  AddParticipants({this.groupId, this.participants, this.callback});
}

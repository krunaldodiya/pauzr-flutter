abstract class GroupEvent {}

class CreateGroup extends GroupEvent {
  String name;
  Function callback;

  CreateGroup({this.name, this.callback});
}

class AddParticipants extends GroupEvent {
  String groupId;
  List participants;
  Function callback;

  AddParticipants({this.groupId, this.participants, this.callback});
}

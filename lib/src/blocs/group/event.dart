abstract class GroupEvent {}

class CreateGroup extends GroupEvent {
  String name;
  String description;
  String photo;
  Function callback;

  CreateGroup({
    this.name,
    this.description,
    this.photo,
    this.callback,
  });
}

class EditGroup extends GroupEvent {
  int groupId;
  String name;
  String description;
  String photo;
  Function callback;

  EditGroup({
    this.groupId,
    this.name,
    this.description,
    this.photo,
    this.callback,
  });
}

class ExitGroup extends GroupEvent {
  int groupId;
  Function callback;

  ExitGroup({this.groupId, this.callback});
}

class AddParticipants extends GroupEvent {
  int groupId;
  List participants;
  Function callback;

  AddParticipants({this.groupId, this.participants, this.callback});
}

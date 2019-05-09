import 'package:pauzr/src/models/user.dart';

abstract class InitialScreenEvent {}

class SetAuthUser extends InitialScreenEvent {
  final User user;

  SetAuthUser({this.user});
}

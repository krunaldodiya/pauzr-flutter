import 'package:pauzr/src/helpers/launch_url.dart';
import 'package:pauzr/src/helpers/vars.dart';
import 'package:pauzr/src/providers/user.dart';

inviteUser(Map contact, UserBloc userBloc) async {
  String mobile = contact['mobile'];
  String text =
      "Join me on PauzR, an application that rewards you with free products, just for not using the phone. Download using this link and get 5 points as a kick-start. Join this human revolution! Link: $webUrl/invite/${userBloc.user.id}/$mobile";

  await launchURL(
    "whatsapp://send?phone=${contact['mobileWithCountryCode']}&text=$text",
  );
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

Future sendRequest(api, [body, method = "POST"]) async {
  final Dio dio = Dio();
  final headers = await getHeaders();

  try {
    return dio.request(
      Uri.encodeFull(api),
      data: body,
      options: Options(
        method: method,
        headers: headers,
        responseType: ResponseType.json,
      ),
    );
  } catch (e) {
    print(e);
  }
}

getHeaders() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String token = pref.getString("authToken");

  return {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer $token",
  };
}

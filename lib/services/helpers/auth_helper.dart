import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/models/response/auth/login_res_model.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  static Future<bool> login(LoginModel loginModel) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      // var url = Uri.https(Config.apiUrl, Config.loginUrl);
      var uri = Uri.http(Config.mobileUrl,Config.loginUrl);
      var response = await client.post(
        // url,
        uri,
        headers: requestHeaders,
        body: jsonEncode(loginModel),
      );
      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        String token = loginResponseModelFromJson(response.body).userToken;
        String userId = loginResponseModelFromJson(response.body).id;
        String profile = loginResponseModelFromJson(response.body).profile;
        //saving in device memory
        await prefs.setString("token", token);
        await prefs.setString("userId", userId);
        await prefs.setString("profile", profile);
        await prefs.setBool("loggedIn", true);
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err.toString());
      return false;
    }
  }
}

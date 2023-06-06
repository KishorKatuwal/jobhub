import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/models/request/auth/profile_update_model.dart';
import 'package:jobhub/models/request/auth/signup_model.dart';
import 'package:jobhub/models/response/auth/login_res_model.dart';
import 'package:jobhub/models/response/auth/profile_model.dart';
import 'package:jobhub/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = https.Client();

  //login method
  static Future<bool> login(LoginModel loginModel) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl,Config.loginUrl);
      var response = await client.post(
        url,
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

  //sign up method
  static Future<bool> signUp(SignupModel signupModel) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8'
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl,Config.signupUrl);
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(signupModel),
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        print("reached here  3 ${response.statusCode}");
        return false;
      }
    } catch (err) {
      print(err.toString());
      return false;
    }
  }


  //update profile
  static Future<bool> updateProfile(ProfileUpdateReq profileModel) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      print(token);
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearer $token',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl,Config.profileUrl);
      var response = await client.put(
        url,
        headers: requestHeaders,
        body: jsonEncode(profileModel),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print(err.toString());
      return false;
    }
  }


  //update profile
  static Future<ProfileRes> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearer $token',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl,Config.profileUrl);
      var response = await client.get(
        url,
        headers: requestHeaders,
      );
      if (response.statusCode == 200) {
        var profile = profileResFromJson(response.body);
        return profile;
      } else {
        throw Exception("Failed to get the profile");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }








//last line
}

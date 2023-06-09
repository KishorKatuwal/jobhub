import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/chat/create_chat.dart';
import '../../models/response/chat/get_chat.dart';
import '../../models/response/chat/initial_message.dart';
import '../config.dart';

class ChatHelper {
  static var client = https.Client();



  //Apply for a JOB
  static Future<List<dynamic>> apply(CreateChat model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearer $token',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl, Config.chatsUrl);
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson())
      );
      if (response.statusCode == 200) {
        var first = initialChatFromJson(response.body).id;
        return [true, first];
      } else {
        return [false];
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }





//getting conversations
  static Future<List<GetChats>> getConversations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearer $token',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl, Config.chatsUrl);
      var response = await client.get(
          url,
          headers: requestHeaders
      );
      if (response.statusCode == 200) {
        var chats = getChatsFromJson(response.body);
        return chats;
      } else {
        print(response.statusCode);
        throw Exception("Failed to get conversations");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }







//last
}

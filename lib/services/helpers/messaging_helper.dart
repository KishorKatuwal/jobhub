import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/messaging/send_message.dart';
import '../../models/response/messaging/messaging_res.dart';
import '../config.dart';

class MessagingHelper {
  static var client = https.Client();

  //send Message
  static Future<List<dynamic>> sendMessage(SendMessage model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearer $token',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl, Config.messageUrl);
      var response = await client.post(url,
          headers: requestHeaders, body: jsonEncode(model.toJson()));
      print(response.statusCode);
      print(response.statusCode);
      print(response.statusCode);
      if (response.statusCode == 200) {
        ReceivedMessage message =
            ReceivedMessage.fromJson(jsonDecode(response.body));
        Map<String, dynamic> responseMap = jsonDecode(response.body);
        return [true, message, responseMap];
      } else {
        print(response.statusCode);
        return [false];
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

//get Messages
  static Future<List<ReceivedMessage>> getMessages(
      String chatId, int offset) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearer $token',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl, "${Config.messageUrl}/$chatId", {"page": offset.toString()});
      var response = await client.get(
        url,
        headers: requestHeaders,
      );
      if (response.statusCode == 200) {
        var messages = receivedMessageFromJson(response.body);
        return messages;
      } else {
        print(response.statusCode);
        // return false;
        throw Exception("Failed to load messages");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }


//last
}

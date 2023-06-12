import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:jobhub/models/request/bookmarks/req_model.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/request/bookmarks/bookmark_sending_model.dart';
import '../config.dart';

class BookMarkHelper {
  static var client = https.Client();

  //create bookmark
  static Future<List<dynamic>> addBookmark(BookmarkSendingModel model) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearer $token',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl, Config.bookmarkUrl);
      var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson()),
      );
      if (response.statusCode == 201) {
        String bookmarkId = bookmarkReqResModelFromJson(response.body).id;
        return [true, bookmarkId];
      } else {
        print(response.statusCode);
        return [false];
        //throw Exception("Failed to get the profile");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }


  //delete bookmark
  static Future<bool> deleteBookmark(String jobId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearer $token',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl, "${Config.bookmarkUrl}/$jobId");
      var response = await client.delete(
        url,
        headers: requestHeaders,
      );
      if (response.statusCode == 200) {
        print("Successfully deleted bookmark");
        return true;
      } else {
        print(response.statusCode);
        return false;
        //throw Exception("Failed to get the profile");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }


  //Getting bookmark
  static Future<List<AllBookmark>> getBookmarks() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'token': 'Bearer $token',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl, Config.bookmarkUrl);
      var response = await client.get(
        url,
        headers: requestHeaders,
      );
      if (response.statusCode == 200) {
        var bookmarks = allBookmarkFromJson(response.body);
        return bookmarks;
      } else {
        print(response.statusCode);
        throw Exception("Failed to get the bookmarks");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }







}

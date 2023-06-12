import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:jobhub/services/helpers/chat_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/response/chat/get_chat.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  List<String> _online = [];
  bool _typing = false;
  bool get typing => _typing;

  set typingStatus(bool newState){
    _typing = newState;
    notifyListeners();
  }

  List<String> get online => _online;

  set onlineUsers(List<String> newList) {
    _online = newList;
    notifyListeners();
  }

  String? userId;

  getChats() {
    chats = ChatHelper.getConversations();
  }

  getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  String msgTime(String timestamp) {
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(timestamp);
    if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day == messageTime.day) {
      return DateFormat.Hm().format(messageTime);
    } else if (now.year == messageTime.year &&
        now.month == messageTime.month &&
        now.day - messageTime.day == 1) {
      return "Yesterday";
    } else {
      return DateFormat.yMd().format(messageTime);
    }
  }
}

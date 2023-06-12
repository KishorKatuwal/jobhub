import 'dart:convert';

List<ReceivedMessage> receivedMessageFromJson(String str) => List<ReceivedMessage>.from(json.decode(str).map((x) => ReceivedMessage.fromJson(x)));


class ReceivedMessage {
  final String id;
  final Sender sender;
  final String content;
  final Chat chat;
  final List<dynamic> readBy;
  final int v;

  ReceivedMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.chat,
    required this.readBy,
    required this.v,
  });

  factory ReceivedMessage.fromJson(Map<String, dynamic> json) => ReceivedMessage(
    id: json["_id"],
    sender: Sender.fromJson(json["sender"]),
    content: json["content"],
    chat: Chat.fromJson(json["chat"]),
    readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
    v: json["__v"],
  );

}

class Chat {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<Sender> users;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String latestMessages;

  Chat({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.latestMessages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
    id: json["_id"],
    chatName: json["chatName"],
    isGroupChat: json["isGroupChat"],
    users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
    latestMessages: json["latestMessages"]??"hi",
  );

}

class Sender {
  final String id;
  final String username;
  final String email;
  final String profile;

  Sender({
    required this.id,
    required this.username,
    required this.email,
    required this.profile,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["_id"],
    username: json["username"],
    email: json["email"],
    profile: json["profile"],
  );

}

import 'dart:convert';

BookmarkSendingModel bookmarkSendingModelFromJson(String str) =>
    BookmarkSendingModel.fromJson(json.decode(str));

String bookmarkSendingModelToJson(BookmarkSendingModel data) =>
    json.encode(data.toJson());

class BookmarkSendingModel {
  final String job;

  BookmarkSendingModel({
    required this.job,
  });

  factory BookmarkSendingModel.fromJson(Map<String, dynamic> json) =>
      BookmarkSendingModel(
        job: json["job"],
      );

  Map<String, dynamic> toJson() => {
        "job": job,
      };
}

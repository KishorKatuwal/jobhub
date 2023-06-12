import 'dart:convert';

BookmarkReqResModel bookmarkReqResModelFromJson(String str) =>
    BookmarkReqResModel.fromJson(json.decode(str));


class BookmarkReqResModel {
  final String id;

  BookmarkReqResModel({
    required this.id,
  });

  factory BookmarkReqResModel.fromJson(Map<String, dynamic> json) =>
      BookmarkReqResModel(
        id: json["_id"],
      );

}

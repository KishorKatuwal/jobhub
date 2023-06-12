import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import '../models/request/bookmarks/bookmark_sending_model.dart';
import '../services/helpers/book_helper.dart';

class BookMarkNotifier extends ChangeNotifier {
  List<String> _jobs = [];
  Future<List<AllBookmark>>? bookmarks;

  List<String> get jobs => _jobs;

  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  Future<void> addJob(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_jobs != null) {
      _jobs.insert(0, jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> removeJob(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_jobs != null) {
      _jobs.remove(jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> loadJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList('jobId');
    if (jobs != null) {
      _jobs = jobs;
    }
  }

  addBookmark(BookmarkSendingModel model, String jobId) {
    BookMarkHelper.addBookmark(model).then((response) {
      if (response[0]) {
        addJob(jobId);
        Get.snackbar(
            "Bookmark Successfully Added", "Please Check your bookmarks",
            colorText: Color(kLight.value),
            backgroundColor: Color(kLightBlue.value),
            icon: const Icon(Icons.bookmark_added));
      } else if (!response[0]) {
        Get.snackbar("Adding Bookmark failed", "Please try again!",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  deleteBookmark(String jobId) {
    BookMarkHelper.deleteBookmark(jobId).then((response) {
      if (response) {
        removeJob(jobId);
        Get.snackbar(
            "Bookmark Successfully Deleted", "Please Check your bookmarks",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.bookmark_remove_outlined));
      } else if (!response) {
        Get.snackbar("Deleting Bookmark failed", "Please try again!",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  getBookmarks() {
    bookmarks = BookMarkHelper.getBookmarks();
  }

//last
}

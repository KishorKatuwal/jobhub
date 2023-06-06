import 'package:http/http.dart' as https;
import 'package:jobhub/models/response/jobs/get_job.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

class JobsHelper {
  static var client = https.Client();


  //Get Jobs
  static Future<List<JobsResponse>> getJobs() async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl,Config.jobs);
      var response = await client.get(
        url,
        headers: requestHeaders,
      );
      if (response.statusCode == 200) {
        var jobsList = jobsResponseFromJson(response.body);
        return jobsList;
      } else {
        throw Exception("Failed to get the jobs");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }


  //get recent jobs
  static Future<JobsResponse> getRecentJobs() async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl,Config.jobs);
      var response = await client.get(
        url,
        headers: requestHeaders,
      );
      if (response.statusCode == 200) {
        var jobsList = jobsResponseFromJson(response.body);
        var recent = jobsList.first;
        return recent;
      } else {
        throw Exception("Failed to get the recent jobs");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  //get single job through id
  static Future<GetJobRes> getSingleJob(String jobId) async {
    try {
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      // var url = Uri.http(Config.apiUrl, Config.loginUrl);
      var url = Uri.http(Config.apiUrl, "${Config.jobs}/$jobId");
      var response = await client.get(
        url,
        headers: requestHeaders,
      );
      if (response.statusCode == 200) {
        var singleJob = getJobResFromJson(response.body);
        return singleJob;
      } else {
        throw Exception("Failed to get the single job through id");
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }





//last
}

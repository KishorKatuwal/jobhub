import 'package:flutter/foundation.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';

import '../models/response/jobs/get_job.dart';


class JobsNotifier extends ChangeNotifier {

  late Future<List<JobsResponse>> jobList;
  late Future<JobsResponse> recentJob;
  late Future<GetJobRes> singleJob;

  getJobs(){
    jobList = JobsHelper.getJobs();
  }

  getRecentJobs(){
    recentJob = JobsHelper.getRecentJobs();
  }

  getSingleJob(String jobId){
    singleJob = JobsHelper.getSingleJob(jobId);
  }


 
}

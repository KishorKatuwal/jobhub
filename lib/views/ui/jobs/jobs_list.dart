import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/views/ui/jobs/widgets/job_tile.dart';
import 'package:provider/provider.dart';

import '../../common/app_bar.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    var jobList = Provider.of<JobsNotifier>(context).jobList;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          text: "Available Jobs",
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(CupertinoIcons.arrow_left),
          ),
        ),
      ),
      body: FutureBuilder(
          future: jobList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("Error ${snapshot.error}");
            } else {
              final jobData = snapshot.data;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                    itemCount: jobData!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final jobs = jobData[index];
                      return VerticalTileWidget(
                        jobs: jobs,
                      );
                    }),
              );
            }
          }),
    );
  }
}

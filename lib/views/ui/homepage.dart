import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/heading_widget.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/search.dart';
import 'package:jobhub/views/common/vertical_shimmer.dart';
import 'package:jobhub/views/common/vertical_tile.dart';
import 'package:jobhub/views/ui/jobs/job_page.dart';
import 'package:jobhub/views/ui/jobs/jobs_list.dart';
import 'package:jobhub/views/ui/jobs/widgets/horizontal_shimmer.dart';
import 'package:jobhub/views/ui/jobs/widgets/horizontal_tile.dart';
import 'package:jobhub/views/ui/search/searchpage.dart';
import 'package:provider/provider.dart';

import '../../constants/app_constants.dart';
import '../../controllers/jobs_provider.dart';
import '../common/drawer/drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          actions: [
            Padding(
              padding: EdgeInsets.all(
                12.h,
              ),
              child: const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage("assets/images/user.png"),
              ),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(12.h),
            child: const DrawerWidget(),
          ),
        ),
      ),
      body: Consumer<JobsNotifier>(builder: (context, jobNotifier, child) {
        jobNotifier.getJobs();
        jobNotifier.getRecentJobs();
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpacer(size: 10),
                  Text(
                    "Search\nFind & Apply",
                    style: appstyle(
                      40,
                      Color(kDark.value),
                      FontWeight.bold,
                    ),
                  ),
                  const HeightSpacer(size: 40),
                  SearchWidget(
                    onTap: () {
                      Get.to(() => const SearchPage());
                    },
                  ),
                  const HeightSpacer(size: 30),
                  HeadingWidget(
                    text: 'Popular Jobs',
                    onTap: () {
                      Get.to(() => const JobListPage());
                    },
                  ),
                  const HeightSpacer(size: 15),
                  SizedBox(
                    height: height * 0.28,
                    child: FutureBuilder(
                        future: jobNotifier.jobList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: HorizontalShimmer(),
                            );
                          } else if (snapshot.hasError) {
                            return Text("Error ${snapshot.error}");
                          } else {
                            final jobData = snapshot.data;
                            return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: jobData!.length,
                                itemBuilder: (context, index) {
                                  final jobs = jobData[index];
                                  return JobHorizontalTile(
                                    onTap: () {
                                      Get.to(
                                        () => JobPage(
                                          title: jobs.company,
                                          id: jobs.id,
                                        ),
                                      );
                                    },
                                    jobs: jobs,
                                  );
                                });
                          }
                        }),
                  ),
                  const HeightSpacer(size: 20),
                  HeadingWidget(
                    text: 'Recently Posted',
                    onTap: () {},
                  ),
                  const HeightSpacer(size: 20),
                  FutureBuilder(
                      future: jobNotifier.recentJob,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: VerticalShimmer(),
                          );
                        } else if (snapshot.hasError) {
                          return Text("Error ${snapshot.error}");
                        } else {
                          final job = snapshot.data;
                          return VerticalTile(
                            onTap: () {
                              Get.to(() =>
                                  JobPage(title: job!.company, id: job.id));
                            },
                            job: job,
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

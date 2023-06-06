import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/views/common/width_spacer.dart';
import 'package:jobhub/views/ui/jobs/job_page.dart';

import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';

class VerticalTileWidget extends StatelessWidget {
  final JobsResponse jobs;

  const VerticalTileWidget({super.key, required this.jobs});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: GestureDetector(
        onTap: () {
          Get.to(()=> JobPage(title: jobs.company, id: jobs.id));
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
            horizontal: 20.w,
          ),
          height: height * 0.15,
          width: width,
          color: Color(kLightGrey.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(jobs.imageUrl),
                        radius: 30,
                      ),
                      const WidthSpacer(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: jobs.company,
                            style: appstyle(
                              20,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: width * 0.5,
                            child: ReusableText(
                              text: jobs.title,
                              style: appstyle(
                                20,
                                Color(kDarkGrey.value),
                                FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 18,
                    child: Icon(
                      Ionicons.chevron_forward,
                      color: Color(kOrange.value),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 65.w),
              child: Row(
                children: [
                  ReusableText(
                    text: jobs.salary,
                    style: appstyle(
                      22,
                      Color(kDark.value),
                      FontWeight.w600,
                    ),
                  ),

                  ReusableText(
                    text: "/${jobs.period}",
                    style: appstyle(
                      20,
                      Color(kDarkGrey.value),
                      FontWeight.w600,
                    ),
                  ),

                ],
              )
                ,),
            ],
          ),
        ),
      ),
    );
  }
}

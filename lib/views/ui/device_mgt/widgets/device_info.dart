import 'package:flutter/material.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/height_spacer.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/app_style.dart';
import '../../../common/reusable_text.dart';

class DevicesInfo extends StatelessWidget {
  final String location;
  final String device;
  final String platform;
  final String date;
  final String ipAddress;

  const DevicesInfo({
    Key? key,
    required this.location,
    required this.device,
    required this.platform,
    required this.date,
    required this.ipAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReusableText(
          text: platform,
          style: appstyle(
            22,
            Color(kDark.value),
            FontWeight.bold,
          ),
        ),
        ReusableText(
          text: device,
          style: appstyle(
            22,
            Color(kDark.value),
            FontWeight.bold,
          ),
        ),
        const HeightSpacer(size: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ReusableText(
                  text: date,
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w400,
                  ),
                ),
                ReusableText(
                  text: ipAddress,
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w400,
                  ),
                ),
              ],
            ),
            CustomOutlineBtn(
              text: "Sign Out",
              height: height*0.05,
              width: width*0.3,
              color: Color(
                kOrange.value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

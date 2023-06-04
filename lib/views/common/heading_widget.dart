import 'package:flutter/material.dart';
import 'package:jobhub/views/common/exports.dart';

class HeadingWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const HeadingWidget({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ReusableText(
          text: text,
          style: appstyle(20, Color(kDark.value), FontWeight.w600),
        ),
        GestureDetector(
          onTap: onTap,
          child: ReusableText(
            text: "View All",
            style: appstyle(18, Color(kOrange.value), FontWeight.w500),
          ),
        ),
      ],
    );
  }
}

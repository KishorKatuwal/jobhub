import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../constants/app_constants.dart';
import '../../../common/app_style.dart';

class MessagingTextField extends StatelessWidget {
  final TextEditingController messageController;
  final Widget suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;

  const MessagingTextField(
      {Key? key,
      required this.messageController,
      required this.suffixIcon,
      this.onChanged,
      this.onEditingComplete,
      this.onTapOutside,
      this.onSubmitted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Color(kDarkGrey.value),
      controller: messageController,
      keyboardType: TextInputType.multiline,
      style: appstyle(
        16,
        Color(kDarkGrey.value),
        FontWeight.w500,
      ),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(6.h),
        filled: true,
        fillColor: Color(kLight.value),
        suffixIcon: suffixIcon,
        hintText: "Type a message here",
        hintStyle: appstyle(
          14,
          Color(kDarkGrey.value),
          FontWeight.normal,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.h),
          ),
          borderSide: BorderSide(
            color: Color(kDarkGrey.value),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.h),
          ),
          borderSide: BorderSide(
            color: Color(kDarkGrey.value),
          ),
        ),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
      onSubmitted: onSubmitted,
    );
  }
}

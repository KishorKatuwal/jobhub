import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/auth/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/reusable_text.dart';
import '../../auth/login.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kLightBlue.value),
        child: Column(
          children: [
            Image.asset("assets/images/page3.png"),
            const HeightSpacer(size: 20),
            ReusableText(
              text: "Welcome To PornHub",
              style: appstyle(30, Color(kLight.value), FontWeight.w600),
            ),
            const HeightSpacer(size: 15),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30.w,
              ),
              child: Text(
                "We will help you find your dream job to your skillset, location and preferences to build your career.",
                textAlign: TextAlign.center,
                style: appstyle(14, Color(kLight.value), FontWeight.normal),
              ),
            ),
            const HeightSpacer(size: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOutlineBtn(
                  onTap: () async {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('entrypoint', true);
                    Get.to(() => const LoginPage());
                  },
                  text: 'Login',
                  color: Color(kLight.value),
                  height: height * 0.06,
                  width: width * 0.4,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const RegistrationPage());
                   },
                  child: Container(
                    height: height * 0.06,
                    width: width * 0.4,
                    color: Color(kLight.value),
                    child: Center(
                      child: ReusableText(
                        text: "Sign Up",
                        style: appstyle(
                            16, Color(kLightBlue.value), FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const HeightSpacer(size: 30),
            ReusableText(
              text: "Continue as Guest",
              style: appstyle(
                16,
                Color(kLight.value),
                FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

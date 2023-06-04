import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../../controllers/login_provider.dart';
import '../../../controllers/signup_provider.dart';
import '../../common/app_bar.dart';
import '../../common/app_style.dart';
import '../../common/custom_btn.dart';
import '../../common/custom_textfield.dart';
import '../../common/height_spacer.dart';
import '../../common/reusable_text.dart';
import 'login.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<SignUpNotifier>(builder: (context, signupNotifier, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            text: "Sign Up",
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(CupertinoIcons.arrow_left),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const HeightSpacer(size: 50),
              ReusableText(
                text: "Hello, Welcome!",
                style: appstyle(
                  30,
                  Color(kDark.value),
                  FontWeight.w600,
                ),
              ),
              ReusableText(
                text: "Fill the details to sign up to your account",
                style: appstyle(
                  16,
                  Color(kDarkGrey.value),
                  FontWeight.w600,
                ),
              ),
              const HeightSpacer(size: 50),
              CustomTextField(
                controller: name,
                hintText: "Full Name",
                keyboardType: TextInputType.text,
                validator: (name) {
                  if (name!.isEmpty) {
                    return "Please enter your name!";
                  } else {
                    return null;
                  }
                },
              ),
              const HeightSpacer(size: 20),
              CustomTextField(
                controller: email,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
                validator: (email) {
                  if (email!.isEmpty || email!.contains("@")) {
                    return "Please enter a valid email address";
                  } else {
                    return null;
                  }
                },
              ),
              const HeightSpacer(size: 20),
              CustomTextField(
                controller: password,
                obscureText: signupNotifier.isObsecure,
                hintText: "Password",
                keyboardType: TextInputType.text,
                validator: (password) {
                  if (signupNotifier.passwordValidator(password ?? '')) {
                    return "Please enter a valid password!!";
                  }
                  return null;
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    signupNotifier.isObsecure = !signupNotifier.isObsecure;
                  },
                  child: Icon(
                    signupNotifier.isObsecure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: Color(kDark.value),
                  ),
                ),
              ),
              const HeightSpacer(
                size: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginPage());
                  },
                  child: ReusableText(
                    text: "Login",
                    style: appstyle(
                      14,
                      Color(kDark.value),
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const HeightSpacer(size: 50),
              CustomButton(
                text: "Sign Up",
                onTap: () {
                  loginNotifier.firstTime = !loginNotifier.firstTime;
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}

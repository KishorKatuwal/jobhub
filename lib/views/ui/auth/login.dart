import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/login_model.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/auth/signup.dart';
import 'package:provider/provider.dart';

import '../mainscreen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
      loginNotifier.getPrefs();
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: CustomAppBar(
            text: "Login",
            child: loginNotifier.loggedIn && loginNotifier.entrypoint
                ? GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.arrow_left),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: loginNotifier.loginFormKey,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const HeightSpacer(size: 50),
                ReusableText(
                  text: "Welcome Back",
                  style: appstyle(
                    30,
                    Color(kDark.value),
                    FontWeight.w600,
                  ),
                ),
                ReusableText(
                  text: "Fill the details to login to your account",
                  style: appstyle(
                    16,
                    Color(kDarkGrey.value),
                    FontWeight.w600,
                  ),
                ),
                const HeightSpacer(size: 50),
                CustomTextField(
                  controller: email,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) {
                    if (email!.isEmpty || !email!.contains("@")) {
                      return "Please enter a valid email address";
                    } else {
                      return null;
                    }
                  },
                ),
                const HeightSpacer(size: 20),
                CustomTextField(
                  controller: password,
                  obscureText: loginNotifier.isObscureText,
                  hintText: "Password",
                  keyboardType: TextInputType.text,
                  validator: (password) {
                    if (password!.isEmpty || password!.length < 6) {
                      return "Please enter a valid password";
                    } else {
                      return null;
                    }
                  },
                  suffixIcon: GestureDetector(
                    onTap: () {
                      loginNotifier.isObscureText = !loginNotifier.isObscureText;
                    },
                    child: Icon(
                      loginNotifier.isObscureText
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
                      Get.to(() => const RegistrationPage());
                    },
                    child: ReusableText(
                      text: "Register",
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
                  text: "Login",
                  onTap: () {
                    if (loginNotifier.validateAndSave()) {
                      LoginModel model = LoginModel(
                        email: email.text,
                        password: password.text,
                      );
                      loginNotifier.userLogin(model);
                    }else{
                      Get.snackbar("login Failed", "Please Check your credentials",
                        colorText: Color(kLight.value),
                        backgroundColor: Colors.red,
                        icon: const Icon(Icons.add_alert),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

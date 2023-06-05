import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/exports.dart';
import 'package:jobhub/models/request/auth/profile_update_model.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:provider/provider.dart';

import '../../../constants/app_constants.dart';
import '../../common/app_style.dart';
import '../../common/reusable_text.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  TextEditingController phone = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController skill0 = TextEditingController();
  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();

  @override
  void dispose() {
    phone.dispose();
    location.dispose();
    skill0.dispose();
    skill1.dispose();
    skill2.dispose();
    skill3.dispose();
    skill4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LoginNotifier>(builder: (context, loginNotifier, child) {
        return Form(
          key: loginNotifier.profileFormKey,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 60.h,
            ),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReusableText(
                    text: "Personal Details",
                    style: appstyle(
                      35,
                      Color(kDark.value),
                      FontWeight.bold,
                    ),
                  ),
                  Consumer<ImageUploader>(
                      builder: (context, imageUploader, child) {
                    return imageUploader.imageUrl.isEmpty
                        ? GestureDetector(
                            onTap: () {
                              imageUploader.pickImage();
                            },
                            child: CircleAvatar(
                              backgroundColor: Color(kLightBlue.value),
                              // backgroundImage: ,
                              child: const Center(
                                child: Icon(Icons.photo_filter_rounded),
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              imageUploader.imageUrl.clear();
                              setState(() {});
                            },
                            child: CircleAvatar(
                              backgroundColor: Color(kLightBlue.value),
                              backgroundImage: FileImage(
                                File(
                                  imageUploader.imageUrl[0],
                                ),
                              ),
                            ),
                          );
                  }),
                ],
              ),
              const HeightSpacer(size: 20),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: location,
                      hintText: "Location",
                      keyboardType: TextInputType.text,
                      validator: (location) {
                        if (location!.isEmpty) {
                          return "Please enter a valid Location";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      controller: phone,
                      hintText: "Phone Number",
                      keyboardType: TextInputType.phone,
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return "Please enter a valid Phone Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    ReusableText(
                      text: "Professional Skills",
                      style: appstyle(
                        35,
                        Color(kDark.value),
                        FontWeight.bold,
                      ),
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      controller: skill0,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return "Please enter a valid Phone Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      controller: skill1,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return "Please enter a valid Phone Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      controller: skill2,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return "Please enter a valid Phone Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      controller: skill3,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return "Please enter a valid Phone Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 10),
                    CustomTextField(
                      controller: skill4,
                      hintText: "Professional Skills",
                      keyboardType: TextInputType.text,
                      validator: (phone) {
                        if (phone!.isEmpty) {
                          return "Please enter a valid Phone Number";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const HeightSpacer(size: 20),
                    Consumer<ImageUploader>(
                        builder: (context, imageUploader, child) {
                      return CustomButton(
                        text: "Update Profile",
                        onTap: () {
                          if (imageUploader.imageUrl.isEmpty) {
                            Get.snackbar(
                              "Image Missing",
                              "Please upload an image to proceed",
                              colorText: Color(kLight.value),
                              backgroundColor: Colors.red,
                              icon: const Icon(Icons.add_alert),
                            );
                          } else {
                            if (loginNotifier.profileValidation()) {
                              print("reached here 2");
                              ProfileUpdateReq model = ProfileUpdateReq(
                                location: location.text,
                                phone: phone.text,
                                profile: imageUploader.imageUrl.toString(),
                                skills: [
                                  skill0.text,
                                  skill1.text,
                                  skill2.text,
                                  skill3.text,
                                  skill4.text,
                                ],
                              );
                              //calling method for uploading profile
                              print("2+2");
                              loginNotifier.updateProfile(model);
                              print("2-2");
                            } else {
                              print("reached here 1");
                              Get.snackbar(
                                "Profile Update Failed",
                                "Please Check your credentials",
                                colorText: Color(kLight.value),
                                backgroundColor: Colors.red,
                                icon: const Icon(Icons.add_alert),
                              );
                            }
                          }
                        },
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

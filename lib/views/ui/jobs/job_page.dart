import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:jobhub/controllers/bookmark_provider.dart';
import 'package:jobhub/models/request/chat/create_chat.dart';
import 'package:jobhub/models/request/messaging/send_message.dart';
import 'package:jobhub/services/helpers/chat_helper.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/custom_outline_btn.dart';
import 'package:jobhub/views/common/exports.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/ui/mainscreen.dart';
import 'package:provider/provider.dart';

import '../../../controllers/jobs_provider.dart';
import '../../../models/request/bookmarks/bookmark_sending_model.dart';
import '../../../services/helpers/messaging_helper.dart';

class JobPage extends StatefulWidget {
  final String title;
  final String id;

  const JobPage({
    super.key,
    required this.title,
    required this.id,
  });

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(builder: (context, jobNotifier, child) {
      jobNotifier.getSingleJob(widget.id);
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.h),
          child: CustomAppBar(
            text: widget.title,
            actions: [
              Consumer<BookMarkNotifier>(
                  builder: (context, bookmarkNotifier, child) {
                bookmarkNotifier.loadJobs();
                print(bookmarkNotifier.jobs);
                return GestureDetector(
                  onTap: () {
                    if (bookmarkNotifier.jobs.contains(widget.id)) {
                      //delete bookmark
                      bookmarkNotifier.deleteBookmark(widget.id);
                    } else {
                      BookmarkSendingModel model = BookmarkSendingModel(
                        job: widget.id,
                      );
                      bookmarkNotifier.addBookmark(model, widget.id);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: !bookmarkNotifier.jobs.contains(widget.id)
                        ? const Icon(Fontisto.bookmark)
                        : const Icon(Fontisto.bookmark_alt),
                  ),
                );
              })
            ],
            child: GestureDetector(
              onTap: () => Get.back(),
              child: const Icon(CupertinoIcons.arrow_left),
            ),
          ),
        ),
        body: FutureBuilder(
            future: jobNotifier.singleJob,
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
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const HeightSpacer(size: 30),
                          Container(
                            width: width,
                            height: height * 0.27,
                            color: Color(kLightGrey.value),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(jobData!.imageUrl),
                                ),
                                const HeightSpacer(size: 10),
                                ReusableText(
                                  text: jobData!.title,
                                  style: appstyle(
                                    22,
                                    Color(kDark.value),
                                    FontWeight.w600,
                                  ),
                                ),
                                const HeightSpacer(size: 5),
                                ReusableText(
                                  text: jobData!.location,
                                  style: appstyle(
                                    16,
                                    Color(kDarkGrey.value),
                                    FontWeight.normal,
                                  ),
                                ),
                                const HeightSpacer(size: 15),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomOutlineBtn(
                                        text: "Full-time",
                                        color: Color(kOrange.value),
                                        color2: Color(kLight.value),
                                        width: width * 0.26,
                                        height: height * 0.04,
                                      ),
                                      Row(
                                        children: [
                                          ReusableText(
                                            text: "10",
                                            style: appstyle(
                                              22,
                                              Color(kDark.value),
                                              FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width * 0.2,
                                            child: ReusableText(
                                              text: "/${jobData.period}",
                                              style: appstyle(
                                                22,
                                                Color(kDarkGrey.value),
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          ReusableText(
                            text: "Description",
                            style: appstyle(
                              22,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          Text(
                            jobData!.description,
                            textAlign: TextAlign.justify,
                            maxLines: 8,
                            style: appstyle(
                              16,
                              Color(kDarkGrey.value),
                              FontWeight.normal,
                            ),
                          ),
                          const HeightSpacer(
                            size: 20,
                          ),
                          ReusableText(
                            text: "Requirements",
                            style: appstyle(
                              22,
                              Color(kDark.value),
                              FontWeight.w600,
                            ),
                          ),
                          const HeightSpacer(size: 10),
                          SizedBox(
                            height: height * 0.6,
                            child: ListView.builder(
                                itemCount: jobData!.requirements.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final req = jobData!.requirements[index];
                                  String bullet = "\u2022";
                                  return Text(
                                    "$bullet $req\n",
                                    style: appstyle(16, Color(kDarkGrey.value),
                                        FontWeight.normal),
                                    textAlign: TextAlign.justify,
                                  );
                                }),
                          ),
                          const HeightSpacer(size: 20),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: CustomOutlineBtn(
                            onTap: () {
                              print("tapped");
                              CreateChat model =
                                  CreateChat(userId: jobData.agentId);

                              ChatHelper.apply(model).then((response) {
                                if (response[0]) {
                                  SendMessage model = SendMessage(
                                      content:
                                          "Hello, I'm interested in ${jobData.title} job in ${jobData.location}",
                                      chatId: response[1],
                                      receiver: jobData.agentId);
                                  print(model.content);
                                  print(model.chatId);
                                  print(model.receiver);
                                  MessagingHelper.sendMessage(model).whenComplete((){
                                    Get.to(()=>const MainScreen());
                                 });
                                }
                              });
                            },
                            text: "Apply Now",
                            color2: Color(kOrange.value),
                            width: width,
                            height: height * 0.06,
                            color: Color(kLight.value),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      );
    });
  }
}

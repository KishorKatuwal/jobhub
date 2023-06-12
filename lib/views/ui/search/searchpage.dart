import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';
import 'package:jobhub/views/ui/jobs/widgets/job_tile.dart';
import 'package:jobhub/views/ui/search/widgets/custom_field.dart';

import '../../../constants/app_constants.dart';
import '../../common/app_style.dart';
import '../../common/reusable_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kOrange.value),
        iconTheme: IconThemeData(
          color: Color(kLight.value),
        ),
        title: CustomField(
          hintText: 'Search for a Job',
          controller: search,
          onEditingComplete: () {
            setState(() {});
          },
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: const Icon(AntDesign.search1),
          ),
        ),
        elevation: 0,
      ),
      body: search.text.isNotEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: FutureBuilder<List<JobsResponse>>(
                  future: JobsHelper.searchJobs(search.text),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error ${snapshot.error}");
                    } else if (snapshot.data!.isEmpty) {
                      return const SearchLoading(
                          text: "Searched jos not Found");
                    } else {
                      final jobs = snapshot.data;
                      return ListView.builder(
                          itemCount: jobs!.length,
                          itemBuilder: (context, index) {
                            return VerticalTileWidget(jobs: jobs[index]);
                          });
                    }
                  }),
            )
          : const SearchLoading(
              text: "Start Searching for jobs",
            ),
    );
  }
}

class SearchLoading extends StatelessWidget {
  final String text;

  const SearchLoading({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/optimized_search.png"),
          ReusableText(
            text: text,
            style: appstyle(
              24,
              Color(kDark.value),
              FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

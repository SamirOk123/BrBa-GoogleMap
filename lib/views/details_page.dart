import 'package:breaking_bad/constants.dart';
import 'package:breaking_bad/widgets/essential_data.dart';
import 'package:breaking_bad/widgets/sub_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatelessWidget {
  final dynamic data;
  final int index;
  const DetailsPage({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'tag$index',
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: kShadow,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                      image: DecorationImage(
                          image: NetworkImage(
                            data.img,
                          ),
                          fit: BoxFit.cover),
                    ),
                    width: double.infinity,
                    height: 70.h,
                  ),
                ),
                Positioned(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 5.h,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  left: 2.h,
                  top: 2.h,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            EssentialData(
              value: data.name,
              header: 'Name',
            ),
            EssentialData(header: 'Nickname', value: data.nickname),
            EssentialData(
              header: 'Date Of Birth',
              value: data.birthday == 'Unknown'
                  ? 'Unknown'
                  : DateFormat("dd-MMM-yyyy").format(
                      DateFormat('dd-MM-yyyy').parse(data.birthday),
                    ),
            ),
            EssentialData(header: 'Portrayed', value: data.portrayed),
            EssentialData(header: 'Status', value: data.status),
            SubSection(
              details: data.category,
              header: 'Category',
            ),
            SubSection(
              header: 'Occupation',
              details: data.occupation.join(', '),
            ),
            SubSection(
              header: 'Appearance',
              details: 'Season ' + data.appearance.join(', '),
            ),
            SubSection(
              header: 'Better Call Saul Appearance',
              details: data.betterCallSaulAppearance.length == 0
                  ? 'Not Appeared'
                  : 'Season ' + data.betterCallSaulAppearance.join(', '),
            ),
          ],
        ),
      ),
    );
  }
}

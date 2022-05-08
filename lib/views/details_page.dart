import 'package:breaking_bad/constants.dart';
import 'package:breaking_bad/widgets/essential_data.dart';
import 'package:breaking_bad/widgets/sub_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatefulWidget {
  final dynamic data;
  final int? index;
  const DetailsPage({Key? key, required this.data, this.index})
      : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'tag${widget.index}',
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: kShadow,
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.data.img,
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
                value: widget.data.name,
                header: 'Name',
              ),
              EssentialData(header: 'Nickname', value: widget.data.nickname),
              EssentialData(
                header: 'Date Of Birth',
                value: widget.data.birthday == 'Unknown'
                    ? 'Unknown'
                    : DateFormat("dd-MMM-yyyy").format(
                        DateFormat('dd-MM-yyyy').parse(widget.data.birthday),
                      ),
              ),
              EssentialData(header: 'Portrayed', value: widget.data.portrayed),
              EssentialData(header: 'Status', value: widget.data.status),
              SubSection(
                details: widget.data.category,
                header: 'Category',
              ),
              SubSection(
                header: 'Occupation',
                details: widget.data.occupation
                    .map((season) => season)
                    .toString()
                    .replaceAll(RegExp(r"\p{P}", unicode: true), ""),
              ),
              SubSection(
                  header: 'Appearance',
                  details: widget.data.appearance
                      .map((season) => '${'Season '}$season ')
                      .toString()
                      .replaceAll(RegExp(r"\p{P}", unicode: true), "")),
              SubSection(
                header: 'Better Call Saul Appearance',
                details: widget.data.betterCallSaulAppearance.length == 0
                    ? 'Not Appeared'
                    : widget.data.betterCallSaulAppearance
                        .map((season) => '${'Season '}$season ')
                        .toString()
                        .replaceAll(RegExp(r"\p{P}", unicode: true), ""),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

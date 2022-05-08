import 'package:breaking_bad/constants.dart';
import 'package:breaking_bad/models/character_model.dart';
import 'package:breaking_bad/views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CharactersCard extends StatelessWidget {
  const CharactersCard({
    Key? key,
    required this.characters,
    required this.index,
  }) : super(key: key);

  final List<Character> characters;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, left: 10.h, right: 10.h),
      child: InkWell(
        onTap: () => Get.to(
          () => DetailsPage(
            data: characters[index],
            index: index,
          ),
        ),
        child: Column(
          children: [
            Hero(
              tag: 'tag$index',
              child: Container(
                width: 70.h,
                height: 50.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(characters[index].img),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey.withOpacity(0.4),
                  boxShadow: kShadow,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Name: ${characters[index].name}',
                style: GoogleFonts.merriweather(
                    color: kGreen,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              characters[index].birthday == 'Unknown'
                  ? 'Birthday: Unknown'
                  : 'Birthday: ' +
                      DateFormat("dd-MMM-yyyy").format(
                        DateFormat('dd-MM-yyyy')
                            .parse(characters[index].birthday),
                      ),
              style: GoogleFonts.merriweather(
                  color: kGreen, fontSize: 10.sp, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

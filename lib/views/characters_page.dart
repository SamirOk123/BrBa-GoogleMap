import 'package:breaking_bad/constants.dart';
import 'package:breaking_bad/models/character_model.dart';
import 'package:breaking_bad/views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  //LIST TO STORE CHARACTERS
  List<Character> characters = [];
  //VARIABLE TO REPRESENT OFFSET
  int currentLoaded = 0;
  //REFRESH CONTROLLER
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  //VARIABLE TO STORE TOTAL CHARACTERS COUNT
  late int totalCharacters;

//DISPOSING REFRESH CONTROLLER
  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }

//METHOD TO GET CHARACTERS INFO
  Future<bool> getCharacters({bool isRefresh = false}) async {
    if (isRefresh) {
      currentLoaded = 0;
    } else {
      if (currentLoaded > totalCharacters) {
        refreshController.loadNoData();
        return false;
      }
    }
    final Uri uri = Uri.parse(
        'https://breakingbadapi.com/api/characters?limit=10&offset=$currentLoaded');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = characterFromJson(response.body);

      if (isRefresh) {
        characters = result;
      } else {
        characters.addAll(result);
      }

      totalCharacters = characters.length;
      currentLoaded = currentLoaded + 10;
      setState(() {});
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 5.h,
            ),
            Image.asset(
              'assets/images/brba.png',
              width: 100.w,
              height: 13.h,
            ),
            Expanded(
              child: SmartRefresher(
                controller: refreshController,
                onRefresh: () async {
                  final result = await getCharacters(isRefresh: true);
                  if (result) {
                    refreshController.refreshCompleted();
                  } else {
                    refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  final result = await getCharacters();
                  if (result) {
                    refreshController.loadComplete();
                  } else {
                    refreshController.loadFailed();
                  }
                },
                enablePullUp: true,
                child: ListView.builder(
                  itemCount: characters.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.only(top: 5.h, left: 10.h, right: 10.h),
                      child: InkWell(
                        onTap: () => Get.to(
                          DetailsPage(data: characters[index],index: index,),
                        ),
                        child: Column(
                          children: [
                            Hero(tag: 'tag$index',
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
                              ),
                            ),
                            Text(
                              characters[index].birthday == 'Unknown'
                                  ? 'Birthday: Unknown'
                                  : 'Birthday: ' +
                                      DateFormat("dd-MMM-yyyy").format(
                                        DateFormat('dd-MM-yyyy').parse(
                                            characters[index].birthday),
                                      ),
                              style: GoogleFonts.merriweather(
                                  color: kGreen,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

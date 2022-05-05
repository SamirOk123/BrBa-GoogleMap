import 'dart:math';
import 'package:breaking_bad/models/character_model.dart';
import 'package:breaking_bad/services/api_services.dart';
import 'package:breaking_bad/views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  List<Character>? characters;
  int currentPage = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: currentPage, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/brba.png',
                  width: 100.w,
                  height: 13.h,
                ),
              ),
              FutureBuilder(
                future: ApiServices().getCharacters(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    characters = snapshot.data as List<Character>?;
                    return Expanded(
                      child: PageView.builder(
                        itemCount: characters!.length,
                        physics: const ClampingScrollPhysics(),
                        controller: _pageController,
                        itemBuilder: (context, index) {
                          return carouselView(index);
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Something went wrong!'),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget carouselView(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.0;
        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value * 0.038).clamp(-1, 1);
          print("value $value index $index");
        }
        return Transform.rotate(
          angle: pi * value,
          child: carouselCard(characters, index),
        );
      },
    );
  }

  Widget carouselCard(List<Character>? characters, int index) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Hero(
              tag: 'hero',
              child: GestureDetector(
                onTap: () {
                  Get.to(() => const DetailsPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        image: NetworkImage(characters![index].img),
                        fit: BoxFit.cover),
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Colors.black26)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            characters[index].name,
            style: const TextStyle(
                color: Colors.black45,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            characters[index].birthday == 'Unknown'
                ? 'Unknown'
                : DateFormat("dd-MMM-yyyy").format(
                    DateFormat('dd-MM-yyyy').parse(characters[index].birthday),
                  ),
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

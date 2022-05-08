import 'package:breaking_bad/constants.dart';
import 'package:breaking_bad/controllers/characters_controller.dart';
import 'package:breaking_bad/views/details_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(
      {Key? key,
      required CharactersController charactersController,
      required this.index})
      : _charactersController = charactersController,
        super(key: key);

  final CharactersController _charactersController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        DetailsPage(data: _charactersController.characters[index]),
      ),
      child: Column(
        children: [
          Hero(
            tag: 'newTag',
            child: Container(
              width: 70.h,
              height: 50.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      NetworkImage(_charactersController.characters[index].img),
                  fit: BoxFit.cover,
                ),
                color: Colors.grey.withOpacity(0.4),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black26)
                ],
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Name: ${_charactersController.characters[index].name}',
              style: kCharacterScreenTextStyle,
            ),
          ),
          Text(
            _charactersController.characters[index].birthday == 'Unknown'
                ? 'Birthday: Unknown'
                : 'Birthday: ' +
                    DateFormat("dd-MMM-yyyy").format(
                      DateFormat('dd-MM-yyyy').parse(
                          _charactersController.characters[index].birthday),
                    ),
            style: kCharacterScreenTextStyle,
          ),
        ],
      ),
    );
  }
}

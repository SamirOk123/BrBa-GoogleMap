import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:breaking_bad/constants.dart';
import 'package:breaking_bad/controllers/functions_controller.dart';
import 'package:breaking_bad/models/character_model.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CharactersController extends GetxController {
  //LIST TO STORE CHARACTERS
  List<Character> characters = [];
  //VARIABLE TO REPRESENT OFFSET
  int currentLoaded = 0;
  //REFRESH CONTROLLER
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  //VARIABLE TO STORE TOTAL CHARACTERS COUNT
  int totalCharacters = 0;
  //DEPENDENCY INJECTION
  final FunctionsController functionsController =
      Get.put(FunctionsController());

  //METHOD TO FETCH CHARACTERS INFO
  Future<bool> getCharacters(
      {bool isRefresh = false, required BuildContext context}) async {
    if (isRefresh) {
      currentLoaded = 0;
    } else {
      if (currentLoaded > totalCharacters) {
        refreshController.loadNoData();
        return false;
      }
    }
    try {
      final Uri uri = Uri.parse('$kUrl$currentLoaded');
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
        update();
        return true;
      }
    } on SocketException catch (e) {
      functionsController.showSnackBar(
          context, 'Please check your internet connection');
      debugPrint(e.toString());
    }
    return false;
  }

//DISPOSING REFRESH CONTROLLER
  @override
  void dispose() {
    super.dispose();
    refreshController.dispose();
  }
}

import 'package:breaking_bad/models/character_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CharactersController extends GetxController {
  //LIST TO STORE CHARACTERS
  List<Character> characters = [];
  //VARIABLE TO REPRESENT OFFSET
  RxInt currentLoaded = 0.obs;
  //VARIABLE TO STORE TOTAL CHARACTERS COUNT
  late int totalCharacters;

  //REFRESH CONTROLLER
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  //METHOD TO GET CHARACTERS INFO
  Future<bool> getCharacters({bool isRefresh = false}) async {
    if (isRefresh) {
      currentLoaded.value = 0;
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
      update();
      return true;
    }
    return false;
  }

//DISPOSING REFRESH CONTROLLER
  @override
  void dispose() {
    refreshController.dispose();
    super.dispose();
  }
}

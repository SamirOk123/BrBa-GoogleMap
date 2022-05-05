import 'package:breaking_bad/models/character_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  //Method to fetch characters info
  Future<List<Character>?> getCharacters() async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://breakingbadapi.com/api/characters?limit=10&offset=0');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return characterFromJson(json);
    }
  }
}

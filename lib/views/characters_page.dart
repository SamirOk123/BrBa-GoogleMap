import 'package:breaking_bad/models/character_model.dart';
import 'package:breaking_bad/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: 'Breaking Bad',
                ),
                Tab(
                  text: 'Google Map',
                ),
              ],
            ),
            title: const Text('Breaking Bad & Google Map'),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
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
                          return CharactersCard(
                            characters: characters,
                            index: index,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Center(
                child: Text('Google Map'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

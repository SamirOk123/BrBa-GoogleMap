import 'package:breaking_bad/controllers/characters_controller.dart';
import 'package:breaking_bad/widgets/character_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CharactersPage extends StatelessWidget {
  CharactersPage({Key? key}) : super(key: key);

  //DEPENDENCY INJECTION
  final CharactersController charactersController =
      Get.put(CharactersController());

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
              GetBuilder<CharactersController>(
                builder: (controller) {
                  return SmartRefresher(
                    controller: charactersController.refreshController,
                    onRefresh: () async {
                      final result = await charactersController.getCharacters(
                          isRefresh: true, context: context);
                      if (result) {
                        charactersController.refreshController
                            .refreshCompleted();
                      } else {
                        charactersController.refreshController.refreshFailed();
                      }
                    },
                    onLoading: () async {
                      final result = await charactersController.getCharacters(
                          context: context);
                      if (result) {
                        charactersController.refreshController.loadComplete();
                      } else {
                        charactersController.refreshController.loadFailed();
                      }
                    },
                    enablePullUp: true,
                    child: ListView.builder(
                      itemCount: charactersController.characters.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CharactersCard(
                          characters: charactersController.characters,
                          index: index,
                        );
                      },
                    ),
                  );
                },
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

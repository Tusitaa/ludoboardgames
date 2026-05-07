import 'package:flutter/material.dart';
import 'package:ludoboardgames/data/game_publisher_repository.dart';
import 'package:ludoboardgames/model/game_publisher.dart';
import 'package:ludoboardgames/ui/components/ludo_top_app_bar.dart';

class BoardgamesScreen extends StatefulWidget {
  const BoardgamesScreen({super.key});

  @override
  State<BoardgamesScreen> createState() => _BoardgamesScreenState();
}

class _BoardgamesScreenState extends State<BoardgamesScreen> {
  late List<GamePublisher> gamePublisher;

  @override
  void initState() {
    super.initState();
    gamePublisher = getAllGamesPublishers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LudoTopAppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 96,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final publisher = gamePublisher[index];
                    return Chip(label: Text(publisher.name));
                  }, // _ = não usa
                  separatorBuilder: (_, _) => const SizedBox(width: 16),
                  itemCount: gamePublisher.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

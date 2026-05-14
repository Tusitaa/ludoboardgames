import 'package:ludoboardgames/model/game_publisher.dart';

class BoardGame {
  final String title;
  final List<GamePublisher> gamesPublisher;
  const BoardGame({required this.title, required this.gamesPublisher});
}

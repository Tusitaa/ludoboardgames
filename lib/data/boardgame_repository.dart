import 'package:ludoboardgames/data/game_publisher_repository.dart';
import 'package:ludoboardgames/model/boardgame.dart';
import 'package:ludoboardgames/model/game_publisher.dart';

List<BoardGame> getAllBoardGames() {
  return [
    BoardGame(title: "Azul", gamesPublisher: [asmodee]),
    BoardGame(title: "Ticket To Ride", gamesPublisher: [asmodee]),
    BoardGame(title: "Quem Foi?", gamesPublisher: [paperGames]),
  ];
}

List<BoardGame> getBoardGamesBy(GamePublisher gamePublisher) {
  return getAllBoardGames()
      .where((boardGame) => boardGame.gamesPublisher.contains(gamePublisher))
      .toList();
}

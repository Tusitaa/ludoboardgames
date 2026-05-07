import 'package:ludoboardgames/model/game_publisher.dart';

const asmodee = GamePublisher(name: "Asmodee");
const devir = GamePublisher(name: "Devir");
const calamity = GamePublisher(name: "Calamity");
const conclave = GamePublisher(name: "Conclave");
const paperGames = GamePublisher(name: "PaperGames");
const meepleBR = GamePublisher(name: "MeepleBR");
const jellyMonster = GamePublisher(name: "Jelly Monster");
const acrossTheBoard = GamePublisher(name: "Across the Board");
const grok = GamePublisher(name: "Grok");
const mosaico = GamePublisher(name: "Mosaico");
const buro = GamePublisher(name: "Buro");

// Função para retornar a lista
List<GamePublisher> getAllGamesPublishers() {
  return const [
    asmodee,
    devir,
    calamity,
    conclave,
    paperGames,
    meepleBR,
    jellyMonster,
    acrossTheBoard,
    grok,
    mosaico,
    buro,
  ];
}

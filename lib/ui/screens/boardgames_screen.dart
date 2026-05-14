import 'package:flutter/material.dart';
import 'package:ludoboardgames/data/boardgame_repository.dart';
import 'package:ludoboardgames/data/game_publisher_repository.dart';
import 'package:ludoboardgames/model/boardgame.dart';
import 'package:ludoboardgames/model/game_publisher.dart';
import 'package:ludoboardgames/ui/components/boardgame_list_card.dart';
import 'package:ludoboardgames/ui/components/game_publisher_card.dart';
import 'package:ludoboardgames/ui/components/ludo_top_app_bar.dart';

class BoardgamesScreen extends StatefulWidget {
  const BoardgamesScreen({super.key});

  @override
  State<BoardgamesScreen> createState() => _BoardgamesScreenState();
}

class _BoardgamesScreenState extends State<BoardgamesScreen> {
  GamePublisher? selectedPublisher;
  bool? isGridView = false;

  List<GamePublisher> get gamesPublisherState => getAllGamesPublishers();

  List<BoardGame> get allBoardGames => getAllBoardGames();

  List<BoardGame> get boardGamesListState => selectedPublisher == null
      ? allBoardGames
      : getBoardGamesBy(selectedPublisher!);

  void _filterByPublisher(GamePublisher publisher) {
    setState(() {
      if (selectedPublisher == publisher) {
        selectedPublisher = null;
        return;
      }

      selectedPublisher = publisher;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isGridSelected = isGridView ?? false;

    return Scaffold(
      appBar: LudoTopAppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
            tooltip: 'Notificacoes',
          ),
        ],
      ),
      body: Container(
        color: colors.surfaceContainerLowest,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                _FeaturedBanner(
                  highlightedPublisher: selectedPublisher?.name ?? 'Todas',
                  totalGames: boardGamesListState.length,
                ),
                const SizedBox(height: 24),
                Text(
                  'Editoras',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: gamesPublisherState.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 16),
                    itemBuilder: (context, index) {
                      final publisher = gamesPublisherState[index];

                      return GamePublisherCard(
                        gamePublisher: publisher,
                        isSelected: selectedPublisher == publisher,
                        onClick: _filterByPublisher,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Catalogo',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            selectedPublisher == null
                                ? '${boardGamesListState.length} jogos disponiveis'
                                : '${boardGamesListState.length} jogos da ${selectedPublisher!.name}',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    SegmentedButton<bool>(
                      segments: const [
                        ButtonSegment<bool>(
                          value: false,
                          icon: Icon(Icons.view_list_rounded),
                          tooltip: 'Lista',
                        ),
                        ButtonSegment<bool>(
                          value: true,
                          icon: Icon(Icons.grid_view_rounded),
                          tooltip: 'Grade',
                        ),
                      ],
                      selected: {isGridSelected},
                      onSelectionChanged: (selection) {
                        setState(() {
                          isGridView = selection.first;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: boardGamesListState.isEmpty
                        ? const Center(
                            key: ValueKey('empty'),
                            child: Text('Nenhum jogo encontrado'),
                          )
                        : isGridSelected
                        ? GridView.builder(
                            key: const ValueKey('grid'),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 0.88,
                                ),
                            itemCount: boardGamesListState.length,
                            itemBuilder: (context, index) {
                              final game = boardGamesListState[index];
                              return BoardGameCardList(
                                boardGame: game,
                                isGrid: true,
                              );
                            },
                          )
                        : ListView.builder(
                            key: const ValueKey('list'),
                            itemCount: boardGamesListState.length,
                            itemBuilder: (context, index) {
                              final game = boardGamesListState[index];
                              return BoardGameCardList(boardGame: game);
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedBanner extends StatelessWidget {
  final String highlightedPublisher;
  final int totalGames;

  const _FeaturedBanner({
    required this.highlightedPublisher,
    required this.totalGames,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [colors.primary, colors.tertiary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Descubra seu proximo jogo',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Filtro atual: $highlightedPublisher',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$totalGames titulos prontos para explorar.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: colors.onPrimary.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colors.onPrimary.withValues(alpha: 0.22),
              ),
            ),
            child: Icon(
              Icons.casino_rounded,
              size: 36,
              color: colors.onPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

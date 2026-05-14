import 'package:flutter/material.dart';
import 'package:ludoboardgames/model/boardgame.dart';

class BoardGameCardList extends StatelessWidget {
  final BoardGame boardGame;
  final bool isGrid;

  const BoardGameCardList({
    super.key,
    required this.boardGame,
    this.isGrid = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final publishers = boardGame.gamesPublisher.map((e) => e.name).join(', ');

    return Padding(
      padding: EdgeInsets.only(
        bottom: isGrid ? 0 : 8,
      ),
      child: Card(
        color: colors.surface,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(
            color: colors.outlineVariant,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: isGrid
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _GameCover(title: boardGame.title),
                      const SizedBox(height: 12),
                      Text(
                        boardGame.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        publishers,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      _GameCover(
                        title: boardGame.title,
                        size: 72,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              boardGame.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              publishers,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: colors.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: colors.onSurfaceVariant,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class _GameCover extends StatelessWidget {
  final String title;
  final double size;

  const _GameCover({
    required this.title,
    this.size = 96,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final initials = title
        .split(' ')
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            colors.primary,
            colors.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          color: colors.onPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

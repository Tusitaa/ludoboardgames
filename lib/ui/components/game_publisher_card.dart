import 'package:flutter/material.dart';
import 'package:ludoboardgames/model/game_publisher.dart';

class GamePublisherCard extends StatelessWidget {
  final GamePublisher gamePublisher;
  final void Function(GamePublisher)? onClick;
  final bool isSelected;

  const GamePublisherCard({
    super.key,
    required this.gamePublisher,
    this.onClick,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onClick != null ? () => onClick!(gamePublisher) : null,
      child: SizedBox(
        width: 100,
        height: 100,
        child: Card(
          color: isSelected ? colors.primaryContainer : colors.surface,
          shape: const CircleBorder(),
          elevation: isSelected ? 6 : 2,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                gamePublisher.name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isSelected
                      ? colors.onPrimaryContainer
                      : colors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

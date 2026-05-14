import 'package:equatable/equatable.dart';

class GamePublisher extends Equatable {
  final String name;

  const GamePublisher({required this.name});

  @override
  List<Object?> get props => [name];
}

/// Provides the [GameState] class.
import 'package:json_annotation/json_annotation.dart';

part 'game_state.g.dart';

/// Which hand the player uses.
enum DominantHand {
  /// Left handed.
  left,

  /// Right handed.
  right,
}

/// The state of the game.
@JsonSerializable()
class GameState {
  /// Create an instance.
  GameState({this.dominantHand = DominantHand.right});

  /// Create an instance from a JSON object.
  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);

  /// Which hand the player uses.
  DominantHand dominantHand;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$GameStateToJson(this);
}

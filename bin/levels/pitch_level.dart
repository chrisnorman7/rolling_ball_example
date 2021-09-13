/// Provides the [PitchLevel].
import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart';
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';

import '../commands.dart';
import '../custom_game.dart';
import '../json/game_state.dart';
import '../menus/main_menu.dart';
import '../pitch.dart';

/// A level for playing on a pitch.
class PitchLevel extends Level {
  PitchLevel({required CustomGame game, required this.pitch})
      : paused = false,
        coordinates = Point(pitch.width / 2, 0),
        lastMoved = 0,
        super(game, ambiances: [Ambiance(sound: pitch.crowdSound)]) {
    registerCommand(leaveMatchCommandName, Command(onStart: () {
      paused = true;
      game.replaceLevel(MainMenu(game: game), ambianceFadeTime: 1.0);
    }));
  }

  /// The pitch that is attached to this level.
  final Pitch pitch;

  /// Whether or not this match is paused.
  bool paused;

  /// The current coordinates of the player.
  Point<double> coordinates;

  /// When the last move was performed.
  int lastMoved;

  /// Start moving.
  void move(double direction) {
    final x = coordinates.x + direction;
    if (x < 0 || x > pitch.width) {
      return;
    }
    coordinates = Point(x, coordinates.y);
    (game as CustomGame).soundManager.context.position =
        Double3(coordinates.x, coordinates.y, 0);
    game.interfaceSounds.playSound(pitch.footstepSound);
  }

  /// Check for controller activity.
  void onTick(int timeDelta) {
    final g = game as CustomGame;
    if ((g.time - lastMoved) < g.state.playerSpeed) {
      return;
    }
    lastMoved = game.time;
    for (final controller in g.gameControllers.values) {
      final double movementAxis;
      if (g.state.dominantHand == DominantHand.right) {
        movementAxis = controller.getAxisSmall(GameControllerAxis.leftX);
      } else {
        movementAxis = controller.getAxisSmall(GameControllerAxis.rightX);
      }
      if (movementAxis != 0.0) {
        move(movementAxis);
      }
    }
  }
}

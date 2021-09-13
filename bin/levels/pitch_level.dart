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
        playerCoordinates = Point(pitch.width / 2, 0),
        ballCoordinates = Point(pitch.width / 2, pitch.length.toDouble()),
        ballSpeed = 2.0,
        ballDirection = 180,
        lastMoved = 0,
        super(game, ambiances: [Ambiance(sound: pitch.crowdSound)]) {
    registerCommand(
        leaveMatchCommandName,
        Command(
            onStart: () => game.replaceLevel(MainMenu(game: game),
                ambianceFadeTime: 1.0)));
    game.ballSoundChannel.position =
        SoundPosition3d(x: ballCoordinates.x, y: ballCoordinates.y);
  }

  /// The pitch that is attached to this level.
  final Pitch pitch;

  /// Whether or not this match is paused.
  bool paused;

  /// The current coordinates of the player.
  Point<double> playerCoordinates;

  /// The coordinates of the ball.
  Point<double> ballCoordinates;

  /// The sound the ball makes.
  PlaySound? ballSound;

  /// How far the ball should move every second.
  double ballSpeed;

  /// The direction the ball is moving in.
  double ballDirection;

  /// When the last move was performed.
  int lastMoved;

  @override
  void onPush() {
    super.onPush();
    ballSound = (game as CustomGame).ballSoundChannel.playSound(
        (game as CustomGame).soundManager.miscSounds.ballSound,
        keepAlive: true,
        looping: true);
  }

  @override
  void onPop(double? ambianceFadeLength) {
    super.onPop(ambianceFadeLength);
    ballSound?.destroy();
    ballSound = null;
  }

  /// Start moving.
  void move(double direction) {
    final x = playerCoordinates.x + direction;
    if (x < 0 || x > pitch.width) {
      return;
    }
    playerCoordinates = Point(x, playerCoordinates.y);
    (game as CustomGame).soundManager.context.position =
        Double3(playerCoordinates.x, playerCoordinates.y, 0);
    game.interfaceSounds.playSound(pitch.footstepSound);
  }

  /// Check for controller activity.
  void onTick(int timeDelta) {
    final g = game as CustomGame;
    // Move the ball.
    ballCoordinates = coordinatesInDirection(
        ballCoordinates, ballDirection, (timeDelta / 1000) * ballSpeed);
    g.ballSoundChannel.position =
        SoundPosition3d(x: ballCoordinates.x, y: ballCoordinates.y);
    // Move the player.
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

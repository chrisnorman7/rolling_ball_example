/// Provides the [CustomGame] class.
import 'package:dart_sdl/dart_sdl.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'json/game_state.dart';

/// A custom game with a sound manager.
class CustomGame extends Game {
  CustomGame(this.soundManager, this.state) : super('Rolling Ball Example');

  /// The sound manager to use.
  final SoundManager soundManager;

  /// The current game state.
  final GameState state;

  /// Start listening for sounds before calling super.
  @override
  Future<void> run(Sdl sdl, {int framesPerSecond = 60}) async {
    sounds.listen(soundManager.handleEvent);
    await super.run(sdl, framesPerSecond: framesPerSecond);
  }
}

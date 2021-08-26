/// Provides the [CustomGame] class.
import 'package:dart_sdl/dart_sdl.dart';
import 'package:ziggurat/ziggurat.dart';

import 'sound_manager.dart';

/// A custom game with a sound manager.
class CustomGame extends Game {
  CustomGame(this.soundManager) : super('Rolling Ball Example');

  /// The sound manager to use.
  final SoundManager soundManager;

  /// Start listening for sounds before calling super.
  @override
  Future<void> run(Sdl sdl, {int framesPerSecond = 60}) async {
    sounds.stream.listen(soundManager.handleEvent);
    await super.run(sdl, framesPerSecond: framesPerSecond);
  }
}

/// Provides the [CustomGame] class.
import 'package:dart_sdl/dart_sdl.dart';
import 'package:ziggurat/ziggurat.dart';

import 'custom_sound_manager.dart';
import 'json/game_state.dart';
import 'levels/pitch_level.dart';

/// A custom game with a sound manager.
class CustomGame extends Game {
  CustomGame({required this.soundManager, required this.state})
      : super('Loading...') {
    pitchReverb = createReverb(ReverbPreset('Pitch Reverb'));
    ballSoundChannel =
        createSoundChannel(position: SoundPosition3d(), reverb: pitchReverb);
  }

  /// The sound manager to use.
  final CustomSoundManager soundManager;

  /// The current game state.
  final GameState state;

  /// The channel for playing the ball sound.
  late final SoundChannel ballSoundChannel;

  /// The reverb to use for pitch sounds.
  late final CreateReverb pitchReverb;

  /// Start listening for sounds before calling super.
  @override
  Future<void> run(Sdl sdl, {int framesPerSecond = 60}) async {
    sounds.listen(soundManager.handleEvent);
    await super.run(sdl, framesPerSecond: framesPerSecond);
  }

  @override
  Future<void> tick(Sdl sdl, int timeDelta) async {
    super.tick(sdl, timeDelta);
    final level = currentLevel;
    if (level is PitchLevel) {
      level.onTick(timeDelta);
    }
  }
}

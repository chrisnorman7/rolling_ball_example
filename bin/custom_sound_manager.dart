/// Provides the [CustomSoundManager] class.
import 'dart:math';

import 'package:dart_synthizer/context.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'crowd_sounds.dart';
import 'footsteps.dart';
import 'menu_sounds.dart';
import 'music.dart';

/// A sound manager which stores references to a bunch of buffer stores.
class CustomSoundManager extends SoundManager {
  /// Create an instance.
  CustomSoundManager(Random random, Context context)
      : musicSounds = MusicBufferStore(random, context.synthizer),
        menuSounds = MenuBufferStore(random, context.synthizer),
        crowdSounds = CrowdSoundsBufferStore(random, context.synthizer),
        footstepSounds = FootstepsBufferStore(random, context.synthizer),
        super(context) {
    bufferStores.addAll([musicSounds, menuSounds, crowdSounds, footstepSounds]);
  }

  /// Various music sounds.
  final MusicBufferStore musicSounds;

  /// Menu sounds.
  final MenuBufferStore menuSounds;

  /// Crowd sounds.
  final CrowdSoundsBufferStore crowdSounds;

  /// Footstep sounds.
  final FootstepsBufferStore footstepSounds;

  /// Load the attached buffer stores.
  Future<void> load() async {
    await musicSounds.load();
    await menuSounds.load();
    await crowdSounds.load();
    await footstepSounds.load();
  }
}

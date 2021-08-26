/// Provides the [Pitch class].
import 'package:ziggurat/ziggurat.dart';

/// A pitch where you can play with the rolling ball.
class Pitch {
  /// Create a pitch.
  Pitch(
      {required this.pitch,
      required this.length,
      required this.footstepSound,
      required this.crowdSound});

  /// The width of the pitch.
  final int pitch;

  /// The length of the pitch.
  final int length;

  /// The footstep sound to use.
  final SoundReference footstepSound;

  /// The sound of the crowd.
  final SoundReference crowdSound;
}

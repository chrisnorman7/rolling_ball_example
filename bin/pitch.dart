/// Provides the [Pitch class].
import 'package:ziggurat/ziggurat.dart';

/// A pitch where you can play with the rolling ball.
class Pitch {
  /// Create a pitch.
  Pitch(
      {required this.width,
      required this.length,
      required this.footstepSound,
      required this.crowdSound,
      this.crowdGain = 0.2});

  /// The width of the pitch.
  final int width;

  /// The length of the pitch.
  final int length;

  /// The footstep sound to use.
  final SoundReference footstepSound;

  /// The sound of the crowd.
  final SoundReference crowdSound;

  /// The gain of the crowd sound.
  final double crowdGain;
}

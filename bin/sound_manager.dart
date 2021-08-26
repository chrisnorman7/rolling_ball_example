/// Provides the [SoundManager] class.
import 'dart:io';

import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';

import 'custom_menu.dart';

/// A sound manager.
///
/// This class takes [SoundEvent] instances, and performs the actions they
/// imply.
class SoundManager {
  /// Create a sound manager.
  SoundManager(this.ctx, this.buffers) {
    buffers
      ..addFile(File(CustomMenuItem.moveSound))
      ..addFile(File(CustomMenuItem.activateSound))
      ..addFile(File(CustomMenuItem.cancelSound));

    interfaceSource = DirectSource(ctx);
    interfaceGenerator = BufferGenerator(ctx);
    interfaceSource.addGenerator(interfaceGenerator);
  }

  /// The Synthizer context to use.
  final Context ctx;

  /// The buffer store to use.
  final BufferStore buffers;

  /// The source for playing interface sounds.
  late final DirectSource interfaceSource;

  /// The generator for playing interface sounds.
  late final BufferGenerator interfaceGenerator;

  /// Handle an event.
  void handleEvent(SoundEvent event) {
    if (event is PlaySound) {
      interfaceGenerator
        ..setBuffer(buffers.getBuffer(event.sound.name, event.sound.type))
        ..looping = event.looping
        ..gain = event.gain;
    }
  }
}

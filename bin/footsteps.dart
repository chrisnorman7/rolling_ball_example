/// Automatically generated from footsteps.json, do not edit.
/// Footstep sounds used when moving around pitches.
import 'dart:io';
import 'dart:math';

import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

class FootstepsBufferStore extends BufferStore {
  /// Create an instance.
  FootstepsBufferStore(Random random, Synthizer synthizer,
      {this.vaultFileName = 'footsteps.dat',
      this.encryptionKey = 'Igaz0LdLCiwoNVj2GgVBZKA/qEQd6oSgtQOv8t64Tmc='})
      : super(random, synthizer);

  /// The name of the vault file to load.
  final String vaultFileName;

  /// The encryption key to use to decrypt the vault file.
  final String encryptionKey;

  /// Footsteps for walking on concrete.
  final concrete = SoundReference('concrete', SoundType.collection);

  /// Footsteps for walking on metal.
  final metal = SoundReference('metal', SoundType.collection);

  /// Footsteps for walking on wood.
  final wood = SoundReference('wood', SoundType.collection);

  /// Load the vault file.
  Future<void> load() async {
    final vaultFile =
        await VaultFile.fromFile(File(vaultFileName), encryptionKey);
    addVaultFile(vaultFile);
  }
}

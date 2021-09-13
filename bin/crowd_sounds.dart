/// Automatically generated from crowds.json, do not edit.
import 'dart:io';
import 'dart:math';

import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

class CrowdSoundsBufferStore extends BufferStore {
  /// Create an instance.
  CrowdSoundsBufferStore(Random random, Synthizer synthizer,
      {this.vaultFileName = 'crowds.dat',
      this.encryptionKey = 'NVv9Mfscpfz+nRF1qoy6M2mKyKaASr35Hf5vZGMnouo='})
      : super(random, synthizer);

  /// The name of the vault file to load.
  final String vaultFileName;

  /// The encryption key to use to decrypt the vault file.
  final String encryptionKey;

  /// People talking inside.
  final indoors = SoundReference('indoors', SoundType.file);

  /// People talking outside.
  final outdoors = SoundReference('outdoors', SoundType.file);

  /// Outdoors in nature.
  final nature = SoundReference('nature', SoundType.file);

  /// Load the vault file.
  Future<void> load() async {
    final vaultFile =
        await VaultFile.fromFile(File(vaultFileName), encryptionKey);
    addVaultFile(vaultFile);
  }
}

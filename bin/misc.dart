/// Automatically generated from misc.json, do not edit.
/// Miscellaneous sounds.
import 'dart:io';
import 'dart:math';

import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

class MiscBufferStore extends BufferStore {
  /// Create an instance.
  MiscBufferStore(Random random, Synthizer synthizer,
      {this.vaultFileName = 'misc.dat',
      this.encryptionKey = 'bsPKZKz5bAzGH5KRj9Jb4DxVshpIojYwqaR5fkl/jl0='})
      : super(random, synthizer);

  /// The name of the vault file to load.
  final String vaultFileName;

  /// The encryption key to use to decrypt the vault file.
  final String encryptionKey;

  /// The sound of the ball.
  final ballSound = SoundReference('ballSound', SoundType.file);

  /// Load the vault file.
  Future<void> load() async {
    final vaultFile =
        await VaultFile.fromFile(File(vaultFileName), encryptionKey);
    addVaultFile(vaultFile);
  }
}

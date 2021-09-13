/// Automatically generated from music.json, do not edit.
/// Various music files used by the game.
import 'dart:io';
import 'dart:math';

import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

class MusicBufferStore extends BufferStore {
  /// Create an instance.
  MusicBufferStore(Random random, Synthizer synthizer,
      {this.vaultFileName = 'music.dat',
      this.encryptionKey = 'cRNbIuqR9OBbzEN+xFQtKPkS65LgLnpxn6ymRtVuP3s='})
      : super(random, synthizer);

  /// The name of the vault file to load.
  final String vaultFileName;

  /// The encryption key to use to decrypt the vault file.
  final String encryptionKey;

  /// The music which is heard in the main menu.
  final mainTheme = SoundReference('mainTheme', SoundType.file);

  /// Load the vault file.
  Future<void> load() async {
    final vaultFile =
        await VaultFile.fromFile(File(vaultFileName), encryptionKey);
    addVaultFile(vaultFile);
  }
}

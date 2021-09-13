/// Automatically generated from menus.json, do not edit.
/// Menu sounds.
import 'dart:io';
import 'dart:math';

import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

class MenuBufferStore extends BufferStore {
  /// Create an instance.
  MenuBufferStore(Random random, Synthizer synthizer,
      {this.vaultFileName = 'menus.dat',
      this.encryptionKey = '4X2YwvErUioCg55NcurIU2s3IO06vP1ZN6A0uY7Cba0='})
      : super(random, synthizer);

  /// The name of the vault file to load.
  final String vaultFileName;

  /// The encryption key to use to decrypt the vault file.
  final String encryptionKey;

  /// The sound which is heard when activating a menu item.
  final activate = SoundReference('activate', SoundType.file);

  /// The sound which is heard when cancelling a menu.
  final cancel = SoundReference('cancel', SoundType.file);

  /// The sound which is heard when moving through a menu.
  final move = SoundReference('move', SoundType.file);

  /// Load the vault file.
  Future<void> load() async {
    final vaultFile =
        await VaultFile.fromFile(File(vaultFileName), encryptionKey);
    addVaultFile(vaultFile);
  }
}

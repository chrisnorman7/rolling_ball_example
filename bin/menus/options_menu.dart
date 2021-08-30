/// Provides the [OptionsMenu] class.
import 'package:ziggurat/ziggurat.dart';

import '../custom_menu.dart';

/// The options menu.
///
/// This menu allows the player to configure various game options.
class OptionsMenu extends CustomMenu {
  /// Create an instance.
  OptionsMenu(Game game)
      : super(game: game, title: Message(text: 'Game Options')) {
    menuItems.addAll([
      CustomMenuItem('Set Dominant Hand', Label()),
      CustomMenuItem('Return To Main Menu', CustomButton(() {
        game.popLevel();
      }))
    ]);
  }

  @override
  void cancel() {
    game
      ..popLevel()
      ..interfaceSounds.playSound(SoundReference.file(CustomMenu.cancelSound));
  }
}

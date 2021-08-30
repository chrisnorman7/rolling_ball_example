/// Provides the [OptionsMenu] class.
import 'package:ziggurat/ziggurat.dart';

import '../custom_game.dart';
import '../custom_menu.dart';
import 'set_hand_menu.dart';

/// The options menu.
///
/// This menu allows the player to configure various game options.
class OptionsMenu extends CustomMenu with CancelMixin {
  /// Create an instance.
  OptionsMenu(CustomGame game)
      : super(game: game, title: Message(text: 'Game Options')) {
    menuItems.addAll([
      CustomMenuItem('Change Dominant Hand', CustomButton(() {
        game.pushLevel(SetHandMenu(game));
      })),
      CustomMenuItem('Return To Main Menu', CustomButton(() {
        game.popLevel();
      }))
    ]);
  }
}

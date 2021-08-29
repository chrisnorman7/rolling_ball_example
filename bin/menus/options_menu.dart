/// Provides the [OptionsMenu] class.
import 'package:ziggurat/ziggurat.dart';

import '../custom_menu.dart';

/// The options menu.
///
/// This menu allows the player to configure various game options.
class OptionsMenu extends CustomMenu {
  /// Create an instance.
  OptionsMenu(Game game) : super(game: game, title: Message(text: 'Options')) {
    menuItems.addAll([CustomMenuItem('Set Dominant Hand', Label())]);
  }

  @override
  void cancel() => game.popLevel();
}

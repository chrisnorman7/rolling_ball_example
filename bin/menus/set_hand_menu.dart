/// Provides the [SetHandMenu] class.
import 'package:ziggurat/ziggurat.dart';

import '../custom_game.dart';
import '../custom_menu.dart';
import '../json/game_state.dart';

/// The menu for setting the player's dominant hand.
class SetHandMenu extends CustomMenu with CancelMixin {
  SetHandMenu(CustomGame game)
      : super(game: game, title: Message(text: 'Dominant Hand')) {
    menuItems.add(CustomMenuItem(
        game.state.dominantHand == DominantHand.right
            ? 'Left Handed'
            : 'Right Handed', CustomButton(() {
      if (game.state.dominantHand == DominantHand.right) {
        game.state.dominantHand = DominantHand.left;
      } else {
        game.state.dominantHand = DominantHand.right;
      }
      game.popLevel();
    })));
  }
}

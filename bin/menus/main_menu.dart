/// Provides the [MainMenu] class.
import 'package:ziggurat/ziggurat.dart';

import '../custom_menu.dart';

/// The main menu for the game.
class MainMenu extends CustomMenu {
  MainMenu(Game game) : super(game: game, title: Message(text: 'Main Menu')) {
    menuItems.addAll([
      CustomMenuItem('Play', Label()),
      CustomMenuItem('Quit', Button(() {
        game
          ..popLevel()
          ..registerTask(400, game.stop);
      }))
    ]);
  }
}

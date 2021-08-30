/// Provides the [MainMenu] class.
import 'package:ziggurat/ziggurat.dart';

import '../custom_game.dart';
import '../custom_menu.dart';
import 'options_menu.dart';

/// The main menu for the game.
class MainMenu extends CustomMenu {
  MainMenu(CustomGame game, SoundReference music)
      : super(
            game: game,
            title: Message(text: 'Main Menu'),
            ambiances: [Ambiance(sound: music)]) {
    menuItems.addAll([
      CustomMenuItem('Play', Label()),
      CustomMenuItem('Options', Button(() {
        final optionsMenu = OptionsMenu(game);
        game.pushLevel(optionsMenu);
      })),
      CustomMenuItem('Quit', CustomButton(() {
        game
          ..popLevel()
          ..registerTask(400, game.stop);
      }))
    ]);
  }
}

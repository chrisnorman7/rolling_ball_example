/// Provides the [MainMenu] class.
import 'dart:io';

import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import '../custom_game.dart';
import '../custom_menu.dart';
import '../levels/pitch_level.dart';
import '../pitch.dart';
import 'options_menu.dart';

/// The main menu for the game.
class MainMenu extends CustomMenu {
  MainMenu({required CustomGame game, required BufferStore buffers})
      : super(
            game: game,
            title: Message(text: 'Main Menu'),
            ambiances: [Ambiance(sound: game.mainMenuMusic)]) {
    menuItems.addAll([
      CustomMenuItem('Play', CustomButton(() async {
        game.popLevel();
        final pitch = Pitch(
            width: 20,
            length: 50,
            footstepSound:
                await buffers.addDirectory(Directory('sounds/footsteps/wood')),
            crowdSound: await buffers.addFile(
                File('sounds/crowds/531871__plyboard9__rainloop.wav')));
        game.pushLevel(PitchLevel(game: game, pitch: pitch, buffers: buffers));
      })),
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

/// Provides the [MainMenu] class.
import 'package:ziggurat/ziggurat.dart';

import '../custom_game.dart';
import '../custom_menu.dart';
import '../levels/pitch_level.dart';
import '../pitch.dart';
import 'options_menu.dart';

/// The main menu for the game.
class MainMenu extends CustomMenu {
  MainMenu({required CustomGame game})
      : super(game: game, title: Message(text: 'Main Menu'), ambiances: [
          Ambiance(sound: game.soundManager.musicSounds.mainTheme)
        ]) {
    menuItems.addAll([
      CustomMenuItem(
          'Play',
          CustomButton(() {
            final pitch = Pitch(
                width: 20,
                length: 30,
                footstepSound: game.soundManager.footstepSounds.wood,
                crowdSound: game.soundManager.crowdSounds.nature);
            game.replaceLevel(PitchLevel(game: game, pitch: pitch),
                ambianceFadeTime: 2.0);
          }, game.soundManager.menuSounds),
          game.soundManager.menuSounds),
      CustomMenuItem(
          'Options',
          CustomButton(() {
            final optionsMenu = OptionsMenu(game);
            game.pushLevel(optionsMenu);
          }, game.soundManager.menuSounds),
          game.soundManager.menuSounds),
      CustomMenuItem(
          'Quit',
          CustomButton(() {
            game
              ..popLevel()
              ..registerTask(400, game.stop);
          }, game.soundManager.menuSounds),
          game.soundManager.menuSounds)
    ]);
  }
}

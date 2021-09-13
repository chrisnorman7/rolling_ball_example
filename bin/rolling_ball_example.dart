import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart'
    show Sdl, GameControllerButton, ScanCode;
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';

import 'commands.dart';
import 'custom_game.dart';
import 'custom_sound_manager.dart';
import 'json/game_state.dart';
import 'menus/main_menu.dart';

Future<void> main() async {
  final sdl = Sdl()..init();
  final synthizer = Synthizer()..initialize();
  final ctx = synthizer.createContext();
  final random = Random();
  final soundManager = CustomSoundManager(random, ctx);
  await soundManager.load();
  final state = GameState();
  final game = CustomGame(soundManager: soundManager, state: state);
  game.triggerMap
    ..registerCommand(
        name: upCommandName,
        trigger: CommandTrigger(
            button: GameControllerButton.dpadUp,
            keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_UP)))
    ..registerCommand(
        name: downCommandName,
        trigger: CommandTrigger(
            button: GameControllerButton.dpadDown,
            keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_DOWN)))
    ..registerCommand(
        name: activateCommandName,
        trigger: CommandTrigger(
            button: GameControllerButton.dpadRight,
            keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_SPACE)))
    ..registerCommand(
        name: cancelCommandName,
        trigger: CommandTrigger(
            button: GameControllerButton.dpadLeft,
            keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_ESCAPE)))
    ..registerCommand(
        name: leaveMatchCommandName,
        trigger: CommandTrigger(
            keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_ESCAPE),
            button: GameControllerButton.start));
  final mainMenu = MainMenu(game: game);
  final now = DateTime.now().millisecondsSinceEpoch;
  game..registerTask(500, () => game.pushLevel(mainMenu), timeOffset: now);
  await game.run(sdl);
  sdl.quit();
  ctx.destroy();
  synthizer.shutdown();
}

import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart'
    show Sdl, GameControllerButton, ScanCode;
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';

import 'commands.dart';
import 'custom_game.dart';
import 'menus/main_menu.dart';
import 'sound_manager.dart';

void main() {
  final sdl = Sdl()..init();
  final synthizer = Synthizer()..initialize();
  final ctx = synthizer.createContext();
  final random = Random();
  final bufferStore = BufferStore(random, ctx.synthizer);
  final soundManager = SoundManager(ctx, bufferStore);
  final game = CustomGame(soundManager);
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
            keyboardKey: CommandKeyboardKey(ScanCode.SCANCODE_ESCAPE)));
  final mainMenu = MainMenu(game);
  game
    ..pushLevel(mainMenu)
    ..run(sdl);
}

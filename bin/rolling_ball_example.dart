import 'dart:io';
import 'dart:math';

import 'package:dart_sdl/dart_sdl.dart'
    show Sdl, GameControllerButton, ScanCode;
import 'package:dart_synthizer/dart_synthizer.dart';
import 'package:ziggurat/ziggurat.dart';
import 'package:ziggurat_sounds/ziggurat_sounds.dart';

import 'commands.dart';
import 'custom_game.dart';
import 'custom_menu.dart';
import 'json/game_state.dart';
import 'menus/main_menu.dart';

Future<void> main() async {
  final sdl = Sdl()..init();
  final synthizer = Synthizer()..initialize();
  final ctx = synthizer.createContext();
  final random = Random();
  final bufferStore = BufferStore(random, ctx.synthizer)
    ..addFile(File(CustomMenu.moveSound))
    ..addFile(File(CustomButton.activateSound))
    ..addFile(File(CustomMenu.cancelSound));
  final soundManager = SoundManager(ctx, bufferStore);
  final state = GameState();
  final game = CustomGame(
      soundManager: soundManager,
      state: state,
      mainMenuMusic: await bufferStore.addFile(File('sounds/music/main.mp3')));
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
  final mainMenu = MainMenu(game: game, buffers: bufferStore);
  final now = DateTime.now().millisecondsSinceEpoch;
  game
    ..registerTask(500, () => game.pushLevel(mainMenu), timeOffset: now)
    ..run(sdl);
}

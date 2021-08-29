/// Provides the [CustomMenu] class.
import 'package:dart_sdl/dart_sdl.dart'
    show Event, ControllerAxisEvent, GameControllerAxis;
import 'package:ziggurat/ziggurat.dart';

import 'commands.dart';

/// A custom menu.
///
/// Instances of this menu can be navigated with either stick on a games
/// controller.
class CustomMenu extends Menu {
  /// Create an instance.
  CustomMenu(
      {required Game game, required Message title, List<Ambiance>? ambiances})
      : axisLastUsed = 0,
        super(game: game, title: title, ambiances: ambiances ?? []) {
    registerCommands(
        activateCommandName: activateCommandName,
        cancelCommandName: cancelCommandName,
        downCommandName: downCommandName,
        upCommandName: upCommandName);
  }

  /// The last time an axis event was used.
  int axisLastUsed;

  /// Handle stick movement.
  @override
  void handleSdlEvent(Event event) {
    if (event is ControllerAxisEvent &&
        [
          GameControllerAxis.leftY,
          GameControllerAxis.rightY,
          GameControllerAxis.triggerLeft,
          GameControllerAxis.triggerRight
        ].contains(event.axis)) {
      const threshold = 0.3;
      const interval = 500;
      final value = event.smallValue;
      if (value == 0) {
        axisLastUsed = 0;
        return;
      }
      final now = DateTime.now().millisecondsSinceEpoch;
      if ((now - axisLastUsed) > interval && value.abs() >= threshold) {
        axisLastUsed = now;
        if (event.axis == GameControllerAxis.triggerLeft) {
          cancel();
        } else if (event.axis == GameControllerAxis.triggerRight) {
          activate();
        } else {
          if (value > 0) {
            // Stick moved back.
            down();
          } else {
            // Stick moved forward.
            up();
          }
        }
      }
    }
  }

  /// Play the activate sound if necessary.
  @override
  void activate() {
    final menuItem = currentMenuItem;
    final widget = menuItem?.widget;
    if (widget is Button) {
      sound?.destroy();
      sound = null;
      game.interfaceSounds.playSound(
          SoundReference(CustomMenuItem.activateSound, SoundType.file));
    }
    super.activate();
  }
}

/// A custom menu item, with its sound already loaded.
class CustomMenuItem extends MenuItem {
  /// Create an instance.
  CustomMenuItem(String label, Widget widget)
      : super(
            Message(
                text: label,
                sound: SoundReference.file(moveSound),
                keepAlive: true),
            widget);

  /// The default move sound.
  static const moveSound = 'sounds/menus/move.wav';

  /// The default activate sound.
  static const activateSound = 'sounds/menus/activate.wav';

  /// The default cancel sound.
  static const cancelSound = 'sounds/menus/cancel.wav';
}

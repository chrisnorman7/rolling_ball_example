/// Provides the [CustomMenu] class.
import 'package:dart_sdl/dart_sdl.dart'
    show Event, ControllerAxisEvent, GameControllerAxis;
import 'package:ziggurat/ziggurat.dart';

import 'commands.dart';
import 'custom_game.dart';
import 'menu_sounds.dart';

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
}

/// A custom menu item, with its sound already loaded.
class CustomMenuItem extends MenuItem {
  /// Create an instance.
  CustomMenuItem(String label, Widget widget, MenuBufferStore menuSounds)
      : super(Message(text: label, sound: menuSounds.move, keepAlive: true),
            widget);
}

/// A button with an activate sound.
class CustomButton extends Button {
  /// Create an instance.
  CustomButton(void Function() onActivate, MenuBufferStore menuSounds)
      : super(onActivate, sound: menuSounds.activate);
}

/// A mixin to provide a [cancel] method.
mixin CancelMixin on CustomMenu {
  @override
  void cancel() {
    game
      ..popLevel()
      ..interfaceSounds
          .playSound((game as CustomGame).soundManager.menuSounds.cancel);
  }
}

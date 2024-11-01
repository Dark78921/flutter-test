import 'package:flutter/material.dart';

// Controller class to manage animations for the Dock widget
class DockAnimationController {
  // Animation controller to control the animations' duration and lifecycle
  final AnimationController controller;

  // Animation to scale the dock items, initialized with a smooth curve
  late final Animation<double> scaleAnimation;

  // Constructor initializes the animation controller with a specified duration and curve
  DockAnimationController(TickerProvider vsync)
      : controller = AnimationController(
          duration: const Duration(milliseconds: 300), // Sets animation duration
          vsync: vsync, // Syncs animation with screen refresh rate
        ) {
    // Defines a curved scaling animation with an ease-in-out effect
    scaleAnimation = CurvedAnimation(
      parent: controller, // Uses the animation controller as the parent
      curve: Curves.easeInOut, // Applies an ease-in-out curve to the animation
    );
  }

  // Disposes of the animation controller to free up resources when done
  void dispose() {
    controller.dispose();
  }

  // Starts the animation, scaling items forward
  void forward() => controller.forward();

  // Reverses the animation, scaling items back to their original size
  void reverse() => controller.reverse();
}

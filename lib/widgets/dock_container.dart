import 'package:flutter/material.dart'; // Importing Flutter's material design library

import '../constants/dock_constants.dart'; // Importing dock constants for layout configuration

/// A widget that serves as a container for dock items, providing styling and layout.
class DockContainer extends StatelessWidget {
  /// The child widget to be displayed inside the dock container.
  final Widget child;

  /// Creates a [DockContainer] with the specified [child] widget.
  const DockContainer({
    super.key, // Key for the widget, used for preserving state
    required this.child, // The child widget is required
  });

  @override
  Widget build(BuildContext context) {
    // Builds the dock container with specific styling and layout
    return Material(
      color: Colors.transparent, // Makes the material background transparent
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DockConstants.borderRadius), // Applies rounded corners
          color: Colors.black.withOpacity(0.2), // Sets a semi-transparent black background
          border: Border.all(
            color: Colors.white.withOpacity(0.2), // Sets a semi-transparent white border
            width: 0.5, // Width of the border
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color
              blurRadius: 15, // Blur radius of the shadow
              spreadRadius: 5, // Spread radius of the shadow
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Padding inside the container
        margin: const EdgeInsets.symmetric(horizontal: 16), // Margin outside the container
        constraints: const BoxConstraints(
          minHeight: DockConstants.baseHeight + 16, // Minimum height constraint
          maxHeight: DockConstants.baseHeight + 16, // Maximum height constraint
        ),
        child: IntrinsicWidth(child: child), // Wraps the child in an IntrinsicWidth to fit its content
      ),
    );
  }
}
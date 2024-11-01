import 'package:flutter/material.dart';

import '../constants/dock_constants.dart';

// A styled container widget for the dock, providing consistent styling and layout for dock items
class DockContainer extends StatelessWidget {
  // The child widget to be displayed within the dock container
  final Widget child;

  // Constructor accepts a required child widget to be rendered inside the container
  const DockContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent, // Makes the Material wrapper transparent
      child: Container(
        // Styling for the dock container background and border
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DockConstants.borderRadius), // Rounds the corners
          color: Colors.black.withOpacity(0.2), // Sets a semi-transparent black background
          border: Border.all(
            color: Colors.white.withOpacity(0.2), // Adds a semi-transparent white border
            width: 0.5, // Border width
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Adds a shadow with slight transparency
              blurRadius: 15, // Controls shadow blur
              spreadRadius: 5, // Controls shadow spread
            ),
          ],
        ),
        // Padding inside the container for better spacing around the content
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        // Adds horizontal margin on either side of the container
        margin: const EdgeInsets.symmetric(horizontal: 16),
        // Constraints to set minimum and maximum height based on the dock item size
        constraints: const BoxConstraints(
          minHeight: DockConstants.baseHeight + 16,
          maxHeight: DockConstants.baseHeight + 16,
        ),
        // Allows the container width to match the intrinsic width of its content
        child: IntrinsicWidth(child: child),
      ),
    );
  }
}

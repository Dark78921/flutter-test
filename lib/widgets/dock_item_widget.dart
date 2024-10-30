import 'package:flutter/material.dart'; // Importing Flutter's material design library

import '../constants/dock_constants.dart'; // Importing dock constants for layout configuration
import '../models/dock_item.dart'; // Importing the DockItem model

/// A widget that represents a single item in the dock, displaying an icon with a background.
class DockItemWidget extends StatelessWidget {
  /// The dock item data containing the icon, color, and tap action.
  final DockItem item;

  /// Creates a [DockItemWidget] with the specified [item].
  const DockItemWidget({
    super.key, // Key for the widget, used for preserving state
    required this.item, // The DockItem is required
  });

  @override
  Widget build(BuildContext context) {
    // Builds the dock item widget with specific styling and layout
    return Container(
      width: DockConstants.baseWidth, // Sets the width of the dock item
      height: DockConstants.baseHeight, // Sets the height of the dock item
      margin: const EdgeInsets.symmetric(
        horizontal: DockConstants.itemSpacing / 2, // Horizontal spacing around the item
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DockConstants.itemBorderRadius), // Applies rounded corners
        color: item.color ?? // Sets the background color, defaults to a color based on the icon if none is provided
            Colors.primaries[item.icon.hashCode % Colors.primaries.length],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 5, // Blur radius of the shadow
            spreadRadius: 1, // Spread radius of the shadow
          ),
        ],
      ),
      child: Center(
        child: Icon(
          item.icon, // Displays the icon from the DockItem
          color: Colors.white, // Sets the icon color to white
          size: DockConstants.iconSize, // Sets the size of the icon
        ),
      ),
    );
  }
}
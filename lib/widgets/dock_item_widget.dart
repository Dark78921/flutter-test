import 'package:flutter/material.dart';

import '../constants/dock_constants.dart';
import '../models/dock_item.dart';

// A widget representing a single item within the dock, styled with an icon, background color, and shadow
class DockItemWidget extends StatelessWidget {
  // The DockItem model containing icon, color, and tap action for this widget
  final DockItem item;

  // Constructor accepts a required DockItem to render
  const DockItemWidget({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // Sets the width and height based on dock constants for consistent sizing
      width: DockConstants.baseWidth,
      height: DockConstants.baseHeight,
      
      // Adds horizontal margin around each dock item for spacing
      margin: const EdgeInsets.symmetric(
        horizontal: DockConstants.itemSpacing / 2,
      ),
      
      // Applies a box decoration for background color, border radius, and shadow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(DockConstants.itemBorderRadius), // Rounds the item’s corners
        
        // Sets the background color of the item, or chooses a default if no color is specified
        color: item.color ??
            Colors.primaries[item.icon.hashCode % Colors.primaries.length],
        
        // Adds a subtle shadow for a floating effect
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Semi-transparent shadow color
            blurRadius: 5, // Blur radius for soft shadow edges
            spreadRadius: 1, // Spread radius for slight shadow expansion
          ),
        ],
      ),
      
      // Centers the icon within the dock item container
      child: Center(
        child: Icon(
          item.icon, // Icon from the DockItem model
          color: Colors.white, // Icon color set to white for visibility
          size: DockConstants.iconSize, // Icon size defined in constants
        ),
      ),
    );
  }
}

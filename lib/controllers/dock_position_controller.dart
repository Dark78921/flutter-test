import 'package:flutter/material.dart';

import '../constants/dock_constants.dart';

// Controller class for calculating positions of dock items during drag-and-drop
class DockPositionController {
  
  // Calculates the offset for a dock item based on its position, dragged index, and target index
  static Offset calculateOffset(
      int index, int? draggedIndex, int? targetIndex, bool isOutsideDock) {
    
    // If there is no dragged or target index, or the item is outside the dock, no offset is applied
    if (draggedIndex == null || targetIndex == null || isOutsideDock) {
      return Offset.zero;
    }

    // Moves items to the left when dragged index is before target index
    if (draggedIndex < targetIndex) {
      if (index > draggedIndex && index <= targetIndex) {
        return const Offset(-1.0, 0.0); // Shift left by 1 unit
      }
    } 
    // Moves items to the right when dragged index is after target index
    else if (draggedIndex > targetIndex) {
      if (index < draggedIndex && index >= targetIndex) {
        return const Offset(1.0, 0.0); // Shift right by 1 unit
      }
    }

    // Returns zero offset if no movement is needed
    return Offset.zero;
  }

  // Updates the target index based on the drag position, triggering a callback when the index changes
  static void updateTargetIndex(
    Offset position, // Current position of the dragged item
    int? draggedIndex, // Index of the currently dragged item
    int itemsLength, // Total number of items in the dock
    Function(int) onTargetIndexChanged, // Callback to notify the new target index
  ) {
    // If there is no dragged index, exit the method
    if (draggedIndex == null) return;

    final double dx = position.dx; // X-position of the dragged item

    // Loop through all items to find where the dragged item should be placed
    for (int i = 0; i < itemsLength; i++) {
      if (i == draggedIndex) continue; // Skip the dragged item itself

      // Calculate the start position of each item based on its index and spacing
      final double itemStart =
          i * (DockConstants.baseWidth + DockConstants.itemSpacing);

      // Calculate the center position of each item for precise target detection
      final double itemCenter =
          itemStart + (DockConstants.baseWidth + DockConstants.itemSpacing) / 2;

      // If the drag position is to the left of an item's center, set it as the new target index
      if (dx < itemCenter) {
        onTargetIndexChanged(i); // Trigger callback with the new target index
        return;
      }
    }

    // If dragged position is beyond the last item, set the last index as the target
    onTargetIndexChanged(itemsLength - 1);
  }
}

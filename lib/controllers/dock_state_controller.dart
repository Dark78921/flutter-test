import '../models/dock_item.dart';

// Controller class for managing the state of dock items during drag-and-drop operations
class DockStateController {
  // List of dock items currently in the dock
  final List<DockItem> items;

  // Index of the item currently being dragged
  int? draggedIndex;

  // Target index where the dragged item is intended to be placed
  int? targetIndex;

  // Flag indicating if the dragged item is currently outside the dock
  bool isOutsideDock = false;

  // Flag indicating if an item is currently being dragged
  bool isDragging = false;

  // Constructor initializes the controller with a list of dock items
  DockStateController(this.items);

  // Handles the beginning of a drag event, setting the dragged and target indexes
  void handleDragStart(int index) {
    draggedIndex = index; // Set the initial dragged item index
    targetIndex = index; // Initialize target to the dragged item's index
    isDragging = true; // Update dragging status
  }

  // Handles the end of a drag event, reordering items if needed and resetting state variables
  void handleDragEnd() {
    // Checks if a target index exists and the dragged item is within the dock
    if (targetIndex != null && !isOutsideDock) {
      // Removes the dragged item from its original position
      final item = items.removeAt(draggedIndex!);
      // Inserts the item at the target position
      items.insert(targetIndex!, item);
    }

    // Resets the indices and flags to indicate no item is being dragged
    targetIndex = null;
    draggedIndex = null;
    isOutsideDock = false;
    isDragging = false;
  }

  // Checks if an item should shrink in size, applicable when dragged outside the dock
  bool shouldShrink(int index) {
    return draggedIndex == index && isOutsideDock && isDragging;
  }

  // Reorders items in the list, adjusting indices if the dragged item is moved to a higher index
  void reorderItems(int fromIndex, int toIndex) {
    // If moving to a higher index, adjust target index by subtracting 1
    if (fromIndex < toIndex) {
      toIndex -= 1;
    }
    // Removes the item from its original index
    final item = items.removeAt(fromIndex);
    // Inserts the item at the new target index
    items.insert(toIndex, item);
  }
}

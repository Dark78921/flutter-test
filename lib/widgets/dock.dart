import 'package:flutter/material.dart'; // Importing Flutter's material design library

import '../constants/dock_constants.dart'; // Importing dock constants for layout configuration
import '../models/dock_item.dart'; // Importing the DockItem model
import 'dock_container.dart'; // Importing the DockContainer widget
import 'dock_item_widget.dart'; // Importing the DockItemWidget for displaying individual dock items

/// A widget that represents the dock, containing a list of dock items that can be rearranged.
class Dock extends StatefulWidget {
  /// The list of dock items to be displayed in the dock.
  final List<DockItem> items;

  /// Creates a [Dock] with the specified list of [items].
  const Dock({
    super.key, // Key for the widget, used for preserving state
    required this.items, // The list of DockItems is required
  });

  @override
  State<Dock> createState() => _DockState(); // Creates the state for the Dock widget
}

/// The state class for the [Dock] widget, managing the dock items and their drag-and-drop behavior.
class _DockState extends State<Dock> {
  late final List<DockItem> _items = List.from(widget.items); // Copies the list of dock items
  int? _draggedIndex; // Index of the currently dragged item
  int? _targetIndex; // Index where the dragged item is currently hovering
  bool _isOutsideDock = false; // Flag to check if the dragged item is outside the dock

  @override
  Widget build(BuildContext context) {
    // Builds the dock container with a row of dock item widgets
    return DockContainer(
      child: Row(
        mainAxisSize: MainAxisSize.min, // Minimizes the row size to fit its children
        mainAxisAlignment: MainAxisAlignment.center, // Centers the dock items in the row
        children: List.generate(_items.length, (index) {
          return _buildAnimatedItem(index); // Builds each dock item with animation
        }),
      ),
    );
  }

  /// Builds an animated item for the dock at the specified index.
  Widget _buildAnimatedItem(int index) {
    return AnimatedSlide(
      duration: Duration(milliseconds: _targetIndex != null ? 200 : 0), // Animation duration based on target index
      offset: _calculateOffset(index), // Calculates the offset for the animation
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Duration for the container animation
        width: _shouldShrink(index) ? 0 : DockConstants.baseWidth, // Width based on whether the item should shrink
        child: _buildDraggableItem(index), // Builds the draggable item widget
      ),
    );
  }

  /// Builds a draggable item widget for the dock at the specified index.
  Widget _buildDraggableItem(int index) {
    return Draggable<int>(
      data: index, // Passes the index of the item being dragged
      feedback: Material(
        color: Colors.transparent, // Makes the feedback transparent
        child: DockItemWidget(item: _items[index]), // Displays the dock item widget as feedback
      ),
      childWhenDragging: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: DockConstants.itemSpacing / 2, // Margin when dragging
        ),
      ),
      onDragStarted: () => _handleDragStart(index), // Handles the start of the drag
      onDragEnd: _handleDragEnd, // Handles the end of the drag
      onDragUpdate: _handleDragUpdate, // Handles updates during the drag
      child: DragTarget<int>(
        onWillAcceptWithDetails: (details) => details.data != index, // Prevents dropping on itself
        builder: (context, candidateData, rejectedData) {
          return DockItemWidget(item: _items[index]); // Displays the dock item widget
        },
      ),
    );
  }

  /// Handles the start of the drag operation.
  void _handleDragStart(int index) {
    setState(() {
      _draggedIndex = index; // Sets the index of the dragged item
      _targetIndex = index; // Sets the target index to the dragged item's index
    });
  }

  /// Handles the end of the drag operation.
  void _handleDragEnd(DraggableDetails details) {
    setState(() {
      if (_targetIndex != null && !_isOutsideDock) {
        final item = _items.removeAt(_draggedIndex!); // Removes the dragged item from its original position
        _items.insert(_targetIndex!, item); // Inserts the item at the target index
      }
      _targetIndex = null; // Resets the target index
      _draggedIndex = null; // Resets the dragged index
      _isOutsideDock = false; // Resets the outside dock flag
    });
  }

  /// Handles updates during the drag operation.
  void _handleDragUpdate(DragUpdateDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox; // Gets the render box for position calculations
    final Offset localPosition = box.globalToLocal(details.globalPosition); // Converts global position to local
    final bool isOutside = !box.size.contains(localPosition); // Checks if the drag is outside the dock

    if (isOutside != _isOutsideDock) {
      setState(() {
        _isOutsideDock = isOutside; // Updates the outside dock flag
      });
    }

    if (!isOutside) {
      _updateTargetIndex(localPosition); // Updates the target index based on the drag position
    }
  }

  /// Determines if the item at the specified index should shrink.
  bool _shouldShrink(int index) {
    return _draggedIndex == index && _isOutsideDock; // Shrinks if the item is being dragged outside the dock
  }

  /// Calculates the offset for the animated item based on drag positions.
  Offset _calculateOffset(int index) {
    if (_draggedIndex == null || _targetIndex == null || _isOutsideDock) {
      return Offset.zero; // No offset if not dragging or outside the dock
    }

    if (_draggedIndex! < _targetIndex!) {
      if (index > _draggedIndex! && index <= _targetIndex!) {
        return const Offset(-1.0, 0.0); // Moves items to the left
      }
    } else if (_draggedIndex! > _targetIndex!) {
      if (index < _draggedIndex! && index >= _targetIndex!) {
        return const Offset(1.0, 0.0); // Moves items to the right
      }
    }
    return Offset.zero; // No offset for other cases
  }

  /// Updates the target index based on the current drag position.
  void _updateTargetIndex(Offset position) {
    if (_draggedIndex == null) return; // No update if no item is being dragged

    final double dx = position.dx; // Gets the horizontal position
    for (int i = 0; i < _items.length; i++) {
      if (i == _draggedIndex) continue; // Skips the dragged item

      final double itemStart =
          i * (DockConstants.baseWidth + DockConstants.itemSpacing); // Calculates the start position of the item
      final double itemCenter =
          itemStart + (DockConstants.baseWidth + DockConstants.itemSpacing) / 2; // Calculates the center position

      if (dx < itemCenter) {
        if (_targetIndex != i) {
          setState(() {
            _targetIndex = i; // Updates the target index if it changes
          });
        }
        return; // Exits after updating the target index
      }
    }

    if (_targetIndex != _items.length - 1) {
      setState(() {
        _targetIndex = _items.length - 1; // Sets target index to the last item if not already
      });
    }
  }
}
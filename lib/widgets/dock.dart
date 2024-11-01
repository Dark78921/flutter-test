import 'package:flutter/material.dart';

import '../constants/dock_constants.dart';
import '../controllers/dock_animation_controller.dart';
import '../controllers/dock_position_controller.dart';
import '../controllers/dock_state_controller.dart';
import '../models/dock_item.dart';
import 'dock_container.dart';
import 'dock_item_widget.dart';

// Main widget representing the dock with draggable, animated items
class Dock extends StatefulWidget {
  // List of DockItems to be displayed in the dock
  final List<DockItem> items;

  // Constructor requires a list of DockItems
  const Dock({
    super.key,
    required this.items,
  });

  @override
  State<Dock> createState() => _DockState();
}

// State class for Dock, managing animation, drag-and-drop, and item positioning
class _DockState extends State<Dock> with SingleTickerProviderStateMixin {
  late final DockAnimationController _animationController; // Controls item scaling animation
  late final DockStateController _stateController; // Manages the state of items in the dock

  @override
  void initState() {
    super.initState();
    _animationController = DockAnimationController(this); // Initializes the animation controller
    _stateController = DockStateController(List.from(widget.items)); // Sets initial items in dock state
  }

  @override
  void dispose() {
    _animationController.dispose(); // Disposes the animation controller when widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Wraps dock items in a styled container with specified layout
    return DockContainer(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(_stateController.items.length, _buildAnimatedItem), // Creates animated items
      ),
    );
  }

  // Builds an animated item widget for each dock item
  Widget _buildAnimatedItem(int index) {
    return AnimatedSlide(
      duration: Duration(
          milliseconds: _stateController.targetIndex != null ? 200 : 0), // Slide animation duration
      offset: DockPositionController.calculateOffset(
        index,
        _stateController.draggedIndex,
        _stateController.targetIndex,
        _stateController.isOutsideDock,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200), // Fade-in/out animation
        curve: Curves.easeInOut,
        width:
            _stateController.shouldShrink(index) ? 0 : DockConstants.baseWidth, // Shrinks width if needed
        child: _buildDraggableItem(index), // Builds the draggable item
      ),
    );
  }

  // Builds a draggable item for reordering within the dock
  Widget _buildDraggableItem(int index) {
    return Draggable<int>(
      data: index, // Passes the index of the dragged item
      feedback: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: _animationController.scaleAnimation, // Animates scaling effect while dragging
          child: DockItemWidget(item: _stateController.items[index]), // Dock item being dragged
        ),
      ),
      childWhenDragging: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: DockConstants.itemSpacing / 2,
        ),
      ),
      onDragStarted: () {
        setState(() {
          _stateController.handleDragStart(index); // Initializes drag state for the item
        });
        _animationController.forward(); // Starts scaling animation
      },
      onDragEnd: (details) {
        _animationController.reverse(); // Reverses scaling animation
        setState(() {
          _stateController.handleDragEnd(); // Finalizes drag state
        });
      },
      onDragUpdate: _handleDragUpdate, // Updates item position during drag
      child: _buildDragTarget(index), // Builds the target area for item drop
    );
  }

  // Builds the target area for dropped items, handling reorder logic
  Widget _buildDragTarget(int index) {
    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => details.data != index, // Prevents item from dropping onto itself
      onAcceptWithDetails: (details) {
        setState(() {
          _stateController.reorderItems(details.data, index); // Reorders items based on drop position
        });
      },
      builder: (context, candidateData, rejectedData) {
        return AnimatedScale(
          duration: const Duration(milliseconds: 200), // Scale animation for target area
          scale: _stateController.isDragging &&
                  _stateController.draggedIndex == index
              ? 0.0
              : 1.0, // Scales down the original item while dragging
          child: DockItemWidget(item: _stateController.items[index]), // Displays the item at its target
        );
      },
    );
  }

  // Updates the drag position and determines if the item is outside the dock
  void _handleDragUpdate(DragUpdateDetails details) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset localPosition = box.globalToLocal(details.globalPosition);
    final bool isOutside = !box.size.contains(localPosition); // Checks if dragged item is outside dock

    if (isOutside != _stateController.isOutsideDock) {
      setState(() {
        _stateController.isOutsideDock = isOutside; // Updates state if item is outside
      });
    }

    if (!isOutside) {
      DockPositionController.updateTargetIndex(
        localPosition,
        _stateController.draggedIndex,
        _stateController.items.length,
        (index) {
          if (_stateController.targetIndex != index) {
            setState(() {
              _stateController.targetIndex = index; // Sets the target position for the dragged item
            });
          }
        },
      );
    }
  }
}

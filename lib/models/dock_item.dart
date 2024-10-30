import 'package:flutter/material.dart'; // Importing Flutter's material design library

/// A class representing an item in the dock with an icon, color, and tap action.
class DockItem {
  /// The icon displayed for the dock item.
  final IconData icon;

  /// The color of the dock item. This can be null if no color is specified.
  final Color? color;

  /// The callback function that is executed when the dock item is tapped.
  final VoidCallback? onTap;

  /// Creates a [DockItem] with the specified [icon], optional [color], and optional [onTap] callback.
  const DockItem({
    required this.icon, // The icon is required for the dock item
    this.color, // The color is optional
    this.onTap, // The onTap callback is optional
  });
}
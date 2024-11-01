import 'package:flutter/material.dart';

// Model class representing an item in the dock
class DockItem {
  // Icon displayed for this dock item
  final IconData icon;

  // Optional color for the icon
  final Color? color;

  // Optional callback function triggered when the dock item is tapped
  final VoidCallback? onTap;

  // Constructor to initialize DockItem with required icon, and optional color and onTap callback
  const DockItem({
    required this.icon, // Icon is required for each dock item
    this.color, // Color can be specified or left null for default
    this.onTap, // onTap callback can be specified to handle tap events
  });
}

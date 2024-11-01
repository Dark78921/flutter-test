import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/dock_item.dart';
import 'widgets/dock.dart';

// Entry point of the Flutter application
void main() {
  // Ensures all Flutter bindings are initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Sets the system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.light, // Light icons on status bar
    ),
  );

  // Runs the app by calling MyApp widget
  runApp(const MyApp());
}

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Mac Dock', // Sets the title of the app
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary color to blue
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(), // Sets HomeScreen as the default route
    );
  }
}

// Main screen of the application, displaying a custom dock at the bottom
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extends the body behind the app bar
      extendBody: true, // Extends the body behind the bottom of the screen
      body: Container(
        // Background decoration with an image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wallpaper.jpg'), // Sets a wallpaper image
            fit: BoxFit.cover, // Makes the image cover the entire screen
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // Aligns content at the bottom
            children: [
              // Centered custom Dock widget with interactive items
              Center(
                child: Dock(
                  items: [
                    // Dock items with icons, colors, and onTap event handlers
                    DockItem(
                      icon: Icons.person, // Profile icon
                      color: Colors.blue,
                      onTap: () => _handleItemTap(context, 'Profile'),
                    ),
                    DockItem(
                      icon: Icons.message, // Messages icon
                      color: Colors.green,
                      onTap: () => _handleItemTap(context, 'Messages'),
                    ),
                    DockItem(
                      icon: Icons.call, // Calls icon
                      color: Colors.orange,
                      onTap: () => _handleItemTap(context, 'Calls'),
                    ),
                    DockItem(
                      icon: Icons.camera, // Camera icon
                      color: Colors.purple,
                      onTap: () => _handleItemTap(context, 'Camera'),
                    ),
                    DockItem(
                      icon: Icons.photo, // Photos icon
                      color: Colors.red,
                      onTap: () => _handleItemTap(context, 'Photos'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24), // Adds space below the dock
            ],
          ),
        ),
      ),
    );
  }

  // Method to handle dock item taps
  void _handleItemTap(BuildContext context, String itemName) {
    // Displays a floating Snackbar message when a dock item is tapped
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on $itemName'), // Message displays item name
        behavior: SnackBarBehavior.floating, // Snackbar floats over the UI
        backgroundColor: Colors.black87, // Snackbar background color
        duration: const Duration(seconds: 1), // Duration of the Snackbar
      ),
    );
  }
}

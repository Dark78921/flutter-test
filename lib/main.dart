import 'package:flutter/material.dart'; // Importing Flutter's material design library
import 'package:flutter/services.dart'; // Importing services for system UI customization

import 'models/dock_item.dart'; // Importing the DockItem model
import 'widgets/dock.dart'; // Importing the Dock widget

void main() {
  // Ensures that the Flutter engine is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  
  // Sets the system UI overlay style for the app
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes the status bar transparent
      statusBarIconBrightness: Brightness.light, // Sets the status bar icons to light
    ),
  );
  
  // Runs the MyApp widget
  runApp(const MyApp());
}

// The main application widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds the MaterialApp widget
    return MaterialApp(
      title: 'Flutter Mac Dock', // Title of the application
      debugShowCheckedModeBanner: false, // Hides the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary color theme
        visualDensity: VisualDensity.adaptivePlatformDensity, // Adjusts the visual density
      ),
      home: const HomeScreen(), // Sets the home screen of the app
    );
  }
}

// The home screen widget of the application
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Builds the Scaffold widget for the home screen
    return Scaffold(
      extendBodyBehindAppBar: true, // Extends the body behind the app bar
      extendBody: true, // Extends the body to fill the screen
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/wallpaper.jpg'), // Background image
            fit: BoxFit.cover, // Covers the entire container
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end, // Aligns children to the bottom
            children: [
              Center(
                child: Dock(
                  items: [
                    // List of dock items with icons and actions
                    DockItem(
                      icon: Icons.person, // Icon for the Profile item
                      color: Colors.blue, // Color for the Profile item
                      onTap: () => _handleItemTap(context, 'Profile'), // Action on tap
                    ),
                    DockItem(
                      icon: Icons.message, // Icon for the Messages item
                      color: Colors.green, // Color for the Messages item
                      onTap: () => _handleItemTap(context, 'Messages'), // Action on tap
                    ),
                    DockItem(
                      icon: Icons.call, // Icon for the Calls item
                      color: Colors.orange, // Color for the Calls item
                      onTap: () => _handleItemTap(context, 'Calls'), // Action on tap
                    ),
                    DockItem(
                      icon: Icons.camera, // Icon for the Camera item
                      color: Colors.purple, // Color for the Camera item
                      onTap: () => _handleItemTap(context, 'Camera'), // Action on tap
                    ),
                    DockItem(
                      icon: Icons.photo, // Icon for the Photos item
                      color: Colors.red, // Color for the Photos item
                      onTap: () => _handleItemTap(context, 'Photos'), // Action on tap
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

  // Handles the tap event for dock items
  void _handleItemTap(BuildContext context, String itemName) {
    // Displays a SnackBar with the tapped item name
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tapped on $itemName'), // Message displayed in the SnackBar
        behavior: SnackBarBehavior.floating, // Makes the SnackBar float above the content
        backgroundColor: Colors.black87, // Background color of the SnackBar
        duration: const Duration(seconds: 1), // Duration for which the SnackBar is visible
      ),
    );
  }
}
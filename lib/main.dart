import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/toolbar_provider.dart';
import 'package:provider/provider.dart';
import 'application/folder_provider.dart';
import 'presentation/pages/explorer_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FolderProvider(initialExpandAll: true)),
        ChangeNotifierProvider(create: (_) => ToolbarProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Explorer',
      theme: ThemeData(
        primaryColor: const Color(0xFF0078D4), // Windows 11 blue accent
        // accentColor: const Color(0xFF00A4EF), // Light blue for buttons, highlights
        brightness: Brightness.light, // Light theme
        scaffoldBackgroundColor: const Color(0xFFF3F3F3), // Light gray background
        cardColor: Colors.white, // White cards
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // White app bar
          iconTheme: IconThemeData(color: Colors.black), // Black icons in the app bar
          titleTextStyle: TextStyle(
            color: Colors.black, // Black text for app bar
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // textTheme: const TextTheme(
        //   bodyText1: TextStyle(color: Colors.black, fontSize: 16), // Main text style
        //   bodyText2: TextStyle(color: Colors.black87, fontSize: 14), // Secondary text
        //   headline6: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        // ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0), // Rounded corners for buttons
          ),
          buttonColor: const Color(0xFF0078D4), // Button color
          textTheme: ButtonTextTheme.primary, // White text on buttons
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            borderSide: BorderSide.none, // No border
          ),
        ),
      ),
      home: const ExplorerPage(),
    );
  }
}

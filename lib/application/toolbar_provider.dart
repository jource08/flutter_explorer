import 'package:flutter/material.dart';

class ToolbarProvider extends ChangeNotifier {
  final TextEditingController pathController = TextEditingController();

  // Initial path value
  String _currentPath = '';

  // Getter for the current path
  String get currentPath => _currentPath;

  // Method to set the current path
  void setPath(String newPath) {
    _currentPath = newPath;
    notifyListeners(); // Notify listeners about the change
  }

  // Method to implement back functionality
  void goBack() {
    // Implement back logic here
    // Update _currentPath and call notifyListeners() if needed
  }

  // Method to implement forward functionality
  void goForward() {
    // Implement forward logic here
    // Update _currentPath and call notifyListeners() if needed
  }

  // Method to implement up functionality
  void goUp() {
    // Implement up logic here
    // Update _currentPath and call notifyListeners() if needed
  }

  // Method to implement refresh functionality
  void refresh() {
    // Implement refresh logic here
    // This might involve re-fetching data based on _currentPath
    notifyListeners(); // Notify listeners if the path changes or data is refreshed
  }
}

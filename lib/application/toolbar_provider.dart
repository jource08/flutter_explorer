import 'package:flutter/material.dart';

class ToolbarProvider extends ChangeNotifier {
  final TextEditingController pathController = TextEditingController();

  // Initial path value
  String _currentPath = '';

  // Track the current view type (list or grid)
  bool _isGridView = false;

  // Getters for current path and view state
  String get currentPath => _currentPath;
  bool get isGridView => _isGridView;

  // Method to set the current path
  void setPath(String newPath) {
    _currentPath = newPath;
    notifyListeners(); // Notify listeners about the change
  }

  // Method to toggle between grid and detailed views
  void toggleView() {
    _isGridView = !_isGridView; // Toggle the view type
    notifyListeners();
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
    // Notify listeners if the path changes or data is refreshed
    notifyListeners();
  }
}

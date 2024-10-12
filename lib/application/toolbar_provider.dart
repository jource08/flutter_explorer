import 'package:flutter/material.dart';

class ToolbarProvider extends ChangeNotifier {
  final TextEditingController pathController = TextEditingController();

  // Initial path value
  String _currentPath = '';
  
  // Stack for back/forward navigation
  final List<String> _history = []; // Stack for history
  int _historyIndex = -1; // Track the current index in the history

  // Track the current view type (list or grid)
  bool _isGridView = false;

  // Getters for current path and view state
  String get currentPath => _currentPath;
  bool get isGridView => _isGridView;

  // Method to set the current path
  void setPath(String newPath) {
    if (_currentPath != newPath) {
      if (_historyIndex < _history.length - 1) {
        // Remove forward history if we are navigating to a new path
        _history.removeRange(_historyIndex + 1, _history.length);
      }
      _history.add(newPath);
      _historyIndex++;
      _currentPath = newPath;
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Method to toggle between grid and detailed views
  void toggleView() {
    _isGridView = !_isGridView; // Toggle the view type
    notifyListeners();
  }

  // Method to implement back functionality
  void goBack() {
    if (_historyIndex > 0) {
      _historyIndex--;
      _currentPath = _history[_historyIndex];
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Method to implement forward functionality
  void goForward() {
    if (_historyIndex < _history.length - 1) {
      _historyIndex++;
      _currentPath = _history[_historyIndex];
      notifyListeners(); // Notify listeners about the change
    }
  }

  // Method to implement up functionality
  void goUp() {
    // Assuming the path is a file system path
    List<String> pathParts = _currentPath.split('/');
    if (pathParts.length > 1) {
      // Remove the last part to go up one level
      pathParts.removeLast();
      _currentPath = pathParts.join('/');
      notifyListeners(); // Notify listeners about the change
    } else if (pathParts.length == 1) {
      // If there's only one part, we can set it to root or empty
      _currentPath = '';
      notifyListeners();
    }
  }

  // Method to implement refresh functionality
  void refresh() {
    // Implement refresh logic here, e.g., reloading the content of the current path
    // Notify listeners if the path changes or data is refreshed
    notifyListeners();
  }
}

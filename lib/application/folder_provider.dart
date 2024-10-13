import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_explorer/domain/entites/file.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';
import 'package:flutter_explorer/services/api_service.dart';

class FolderProvider extends ChangeNotifier {
  // The currently selected item from right side panel (folder content viewer)
  Folder? _selectedItem;
  Folder? get selectedItem => _selectedItem;

  // The currently selected folder
  Folder? _selectedFolder;
  Folder? get selectedFolder => _selectedFolder;

  // List of root folders
  List<Folder> rootFolders = [];

  // Loading state
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // Tracks which folders are expanded
  final Map<String, bool> _expandedFolders = {};
  bool _initialExpandAll = true;
  bool get initialExpandAll => _initialExpandAll;

  // Instance of ApiService to fetch data
  final ApiService _apiService;

  // Constructor initializes the ApiService and loads folders
  FolderProvider({Dio? dio})
      : _apiService = ApiService(dio ?? Dio()) {
    loadFolders(); // Load folders when the provider is created
  }

  /// Loads folders from the API.
  Future<void> loadFolders() async {
    try {
      // Fetch folders using the ApiService
      rootFolders = await _apiService.fetchFolders();
      _isLoading = false; // Data fetched successfully, update loading state
    } catch (e) {
      // Print error message if in debug mode
      if (kDebugMode) {
        print('Error loading folders: $e');
      }
      _isLoading = false; // Reset loading state on error
    }
    notifyListeners(); // Notify widgets to rebuild
  }

  /// Selects a item (file/folder single click from right side panel).
  void selectItem(item) {
    _selectedItem = item;
    notifyListeners(); // Notify listeners about the change
  }

  /// Selects a folder.
  void selectFolder(Folder folder) {
    _selectedFolder = folder;
    notifyListeners(); // Notify listeners about the change
  }

  /// Checks if a folder is expanded.
  bool isFolderExpanded(Folder folder) {
    return _expandedFolders[folder.id] ?? false; // Return false if not found
  }

  /// Toggles the expansion state of a folder.
  void toggleFolderExpansion(Folder folder) {
    _expandedFolders[folder.id] = !(_expandedFolders[folder.id] ?? false);
    notifyListeners(); // Notify listeners about the change
  }

  /// Expands a folder.
  void expandFolder(Folder folder) {
    _expandedFolders[folder.id] = true;
    notifyListeners(); // Notify listeners about the change
  }

  /// Recursively expands a folder and all its subfolders.
  void expandFolderRecursively(Folder folder) {
    expandFolder(folder); // Expand the current folder
    for (var subFolder in folder.subFolders) {
      expandFolderRecursively(subFolder); // Recursively expand each subfolder
    }
    _initialExpandAll = false; // Disable further auto-expansion
  }

  /// Gets visible subfolders that are not hidden.
  List<Folder> getVisibleSubFolders(Folder folder) {
    return folder.subFolders.where((subFolder) => !subFolder.isHidden).toList();
  }

  /// Gets visible files that are not hidden.
  List<File> getVisibleFiles(Folder folder) {
    return folder.files.where((file) => !file.isHidden).toList();
  }
}

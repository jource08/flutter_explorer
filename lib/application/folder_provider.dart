import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_explorer/domain/entites/file.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';
import 'package:flutter_explorer/services/api_service.dart';

class FolderProvider extends ChangeNotifier {
  Folder? _selectedFolder;
  Folder? get selectedFolder => _selectedFolder;

  List<Folder> rootFolders = []; // List of root folders
  bool _isLoading = true; // Loading state
  bool get isLoading => _isLoading;

  // Track expanded folders
  final Map<String, bool> _expandedFolders = {};
  bool _initialExpandAll = true; // Track initial expansion
  bool get initialExpandAll => _initialExpandAll;

  final ApiService _apiService; // Instance of ApiService

  // Constructor
  FolderProvider({Dio? dio}) 
      : _apiService = ApiService(dio ?? Dio()) {
    loadFolders(); // Load folders when the provider is initialized
  }

  // Load folders from the API
  Future<void> loadFolders() async {
    try {
      rootFolders = await _apiService.fetchFolders(); // Fetch folders using ApiService
      _isLoading = false; // Set loading to false once data is fetched
    } catch (e) {
      // Handle any errors here
      if (kDebugMode) {
        print('Error loading folders: $e');
      }
      _isLoading = false; // Ensure loading state is reset on error
    }
    notifyListeners(); // Notify listeners after loading is complete
  }

  // Select a folder
  void selectFolder(Folder folder) {
    _selectedFolder = folder;
    notifyListeners();
  }

  // Check if a folder is expanded
  bool isFolderExpanded(Folder folder) {
    return _expandedFolders[folder.id] ?? false;
  }

  // Toggle the expansion state of a folder
  void toggleFolderExpansion(Folder folder) {
    _expandedFolders[folder.id] = !(_expandedFolders[folder.id] ?? false);
    notifyListeners(); // Notify listeners when the expansion state changes
  }

  // Expand a folder
  void expandFolder(Folder folder) {
    _expandedFolders[folder.id] = true;
    notifyListeners();
  }

  // Recursively expand folders
  void expandFolderRecursively(Folder folder) {
    expandFolder(folder);
    for (var subFolder in folder.subFolders) {
      expandFolderRecursively(subFolder);
    }
    _initialExpandAll = false; // Disable further auto-expansion
  }

  // Get visible subfolders that are not hidden
  List<Folder> getVisibleSubFolders(Folder folder) {
    return folder.subFolders.where((subFolder) => !subFolder.isHidden).toList();
  }

  // Get visible files that are not hidden
  List<File> getVisibleFiles(Folder folder) {
    return folder.files.where((file) => !file.isHidden).toList();
  }
}

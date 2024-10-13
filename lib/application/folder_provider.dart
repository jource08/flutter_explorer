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
  FolderProvider({Dio? dio}) : _apiService = ApiService(dio ?? Dio()) {
    loadFolders(); // Load folders when the provider is created
  }

// Method to implement refresh functionality
  Future<void> refresh() async {
    await loadFolders(); // Wait for folders to load
  }

// Loads folders from the API.
  Future<void> loadFolders() async {
    _isLoading = true; // Set loading to true before starting the fetch
    notifyListeners(); // Notify listeners to rebuild UI with loading state

    try {
      // Fetch folders using the ApiService
      rootFolders = await _apiService.fetchFolders();
    } catch (e) {
      // Print error message if in debug mode
      if (kDebugMode) {
        print('Error loading folders: $e');
      }
    } finally {
      _isLoading = false; // Reset loading state
      notifyListeners(); // Notify listeners to rebuild after loading
    }
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

  /// Go up one level in the folder hierarchy.
  void goUpOneLevel() {
    if (_selectedFolder != null) {
      // Find the parent folder
      String? parentId = _selectedFolder!.parentId;
      if (parentId != null) {
        // Find the parent folder from the root folders
        Folder? parentFolder = rootFolders.firstWhere(
          (folder) => folder.id == parentId,
          orElse: () => Folder(
              id: '',
              name: '',
              parentId: null,
              createdAt: DateTime.now(),
              fullPath: ""),
        );

        // If the parent folder is found, select it
        selectFolder(parentFolder);
      }
    }
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

  /// Selects a folder by its full path.
  void selectFolderByFullPath(String fullPath) {
    // Split the full path into segments
    final segments =
        fullPath.split('/').where((segment) => segment.isNotEmpty).toList();

    // Starting point for searching
    Folder? currentFolder;

    // Check each root folder to find the first matching segment
    for (var rootFolder in rootFolders) {
      if (rootFolder.name == segments[0]) {
        currentFolder = rootFolder;
        break;
      }
    }

    // Iterate through the segments to find the corresponding folder
    for (String segment in segments) {
      if (currentFolder == null) {
        return; // If there's no current folder, exit
      }

      // Find the next folder in the current folder's subfolders or ancestors
      currentFolder = _findFolderInHierarchy(currentFolder, segment);

      // Debug output
      if (currentFolder != null) {
      } else {}
    }

    // If the folder is found, select it
    if (currentFolder != null) {
      selectFolder(currentFolder);
    } else {}
  }

  /// Helper method to search for a folder by name in the given folder and its hierarchy.
  Folder? _findFolderInHierarchy(Folder folder, String segment) {
    // Check if the current folder matches the segment
    if (folder.name == segment) {
      return folder; // Found the folder
    }

    // Recursively check subfolders
    for (var subFolder in folder.subFolders) {
      // Check in the subfolder recursively
      Folder? foundFolder = _findFolderInHierarchy(subFolder, segment);
      if (foundFolder != null) {
        return foundFolder; // Return found folder from subfolder
      }
    }

    // If not found, return null
    return null;
  }
}

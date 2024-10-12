import 'package:flutter/foundation.dart';
import 'package:flutter_explorer/application/mock_data.dart';
import 'package:flutter_explorer/domain/entites/file.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';

class FolderProvider extends ChangeNotifier {
  Folder? _selectedFolder;
  Folder? get selectedFolder => _selectedFolder;
  
  final Folder rootFolder = mockData;

  // Track expanded folders
  final Map<String, bool> _expandedFolders = {};

  // Flag for initial expansion of all folders
  bool _initialExpandAll = true;
  bool get initialExpandAll => _initialExpandAll;

  FolderProvider() {
    _selectedFolder = rootFolder;
  }

  void selectFolder(Folder folder) {
    _selectedFolder = folder;
    notifyListeners();
  }

  bool isFolderExpanded(Folder folder) {
    return _expandedFolders[folder.id] ?? false;
  }

  void toggleFolderExpansion(Folder folder) {
    _expandedFolders[folder.id] = !(_expandedFolders[folder.id] ?? false);
    notifyListeners(); // Notify listeners when the expansion state changes
  }

  void expandFolder(Folder folder) {
    _expandedFolders[folder.id] = true;
    notifyListeners();
  }

  // Method to recursively expand folders
  void expandFolderRecursively(Folder folder) {
    expandFolder(folder);
    for (var subFolder in folder.subFolders) {
      expandFolderRecursively(subFolder);
    }
    _initialExpandAll = false; // Disable further auto-expansion
  }

  List<Folder> getVisibleSubFolders(Folder folder) {
    return folder.subFolders.where((subFolder) => !subFolder.isHidden).toList();
  }

  List<File> getVisibleFiles(Folder folder) {
    return folder.files.where((file) => !file.isHidden).toList();
  }
}

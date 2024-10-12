import 'package:flutter/foundation.dart';
import 'package:flutter_explorer/application/mock_data.dart';
import 'package:flutter_explorer/domain/entites/file.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';

class FolderProvider extends ChangeNotifier {
  Folder? _selectedFolder;
  Folder? get selectedFolder => _selectedFolder;
  String? _selectedItemId; 

final Folder rootFolder = mockData;

  FolderProvider() {
    _selectedFolder = rootFolder;
  }

  void selectFolder(Folder folder) {
    _selectedFolder = folder;
    notifyListeners();
  }

  void selectItem(String id) {
    _selectedItemId = id;
    notifyListeners();
  }
  
  bool shouldExpandFolder(Folder folder) {
    // Check if the selected folder is this folder
    if (_selectedFolder == folder) return true;

    // Check if any of the subfolders contain the selected folder
    for (var subFolder in folder.subFolders) {
      if (shouldExpandFolder(subFolder)) return true;
    }

    return false; // Folder should not expand if not selected
  }

  bool isSelected(String id) {
    return _selectedItemId == id;
  }

  List<Folder> getVisibleSubFolders(Folder folder) {
    return folder.subFolders.where((subFolder) => !subFolder.isHidden).toList();
  }

  List<File> getVisibleFiles(Folder folder) {
    return folder.files.where((file) => !file.isHidden).toList();
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter_explorer/domain/entites/file.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';

class FolderProvider extends ChangeNotifier {
  Folder? _selectedFolder;
  Folder? get selectedFolder => _selectedFolder;
  String? _selectedItemId; 

  // Example data (replace with real backend API later)
  final Folder rootFolder = Folder(
    id: '1',
    name: 'Root',
    createdAt: DateTime.now(),
    subFolders: [
      Folder(
        id: '2',
        name: 'Documents',
        createdAt: DateTime.now(),
        icon: 'folder', // Material icon for folder
        subFolders: [
          Folder(
              id: '3',
              name: 'Projects',
              createdAt: DateTime.now(),
              icon: 'work',
              isHidden: false),
        ],
        files: [
          File(
              id: '101',
              name: 'Resume',
              type: 'pdf',
              size: 12345,
              folderId: '2',
              createdAt: DateTime.now(),
              isHidden: false)
        ],
      ),
      Folder(
        id: '4',
        name: 'Pictures',
        createdAt: DateTime.now(),
        files: [
          File(
              id: '102',
              name: 'Vacation',
              type: 'jpg',
              size: 56789,
              folderId: '4',
              createdAt: DateTime.now(),
              isHidden: false)
        ],
      ),
    ],
  );

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

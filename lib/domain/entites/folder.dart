import 'package:flutter_explorer/domain/entites/file.dart';

class Folder {
  final String id;  // Unique identifier
  final String name;  // Folder name, unique within the same parent
  final String? parentId;  // ID of the parent folder (null for root folder)
  final List<Folder> subFolders;  // Subfolders within this folder
  final List<File> files;  // Files within this folder
  final bool isHidden;  // Whether the folder is hidden or not
  final String icon;  // Icon name, refers to Material Icons
  final DateTime createdAt;  // When the folder was created
  final DateTime? modifiedAt;  // When the folder was last modified

  Folder({
    required this.id,
    required this.name,
    this.parentId,
    this.subFolders = const [],
    this.files = const [],
    this.isHidden = false,  // Default is not hidden
    this.icon = 'folder',  // Default folder icon
    required this.createdAt,
    this.modifiedAt,
  });

  // Method to add a subfolder
  void addSubFolder(Folder folder) {
    subFolders.add(folder);
  }

  // Method to add a file
  void addFile(File file) {
    files.add(file);
  }
}

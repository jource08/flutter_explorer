import 'package:flutter_explorer/domain/entites/file.dart';

class Folder {
  final String id; // Unique identifier
  final String name; // Folder name, unique within the same parent
  final String? parentId; // ID of the parent folder (null for root folder)
  final List<Folder> subFolders; // Subfolders within this folder
  final List<File> files; // Files within this folder
  final bool isHidden; // Whether the folder is hidden or not
  final String icon; // Icon name, refers to Material Icons
  final DateTime createdAt; // When the folder was created
  final DateTime? modifiedAt; // When the folder was last modified

  Folder({
    required this.id,
    required this.name,
    this.parentId,
    List<Folder>? subFolders,
    List<File>? files,
    this.isHidden = false,
    this.icon = 'folder',
    required this.createdAt,
    this.modifiedAt,
  })  : subFolders = subFolders ?? [],
        files = files ?? [];

  List<Folder> getSubFolders() => List.unmodifiable(subFolders);
  List<File> getFiles() => List.unmodifiable(files);

  Folder copyWith({
    String? id,
    String? name,
    String? parentId,
    List<Folder>? subFolders,
    List<File>? files,
    bool? isHidden,
    String? icon,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) {
    return Folder(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      subFolders: subFolders ?? this.subFolders,
      files: files ?? this.files,
      isHidden: isHidden ?? this.isHidden,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
    );
  }

  // Method to add a subfolder
  void addSubFolder(Folder folder) {
    subFolders.add(folder);
  }

  // Method to add a file
  void addFile(File file) {
    files.add(file);
  }
}

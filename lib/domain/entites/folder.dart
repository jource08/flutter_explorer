import 'package:flutter_explorer/domain/entites/file.dart';

class Folder {
  final String id;
  final String name;
  final String? parentId;
  final List<Folder> subFolders;
  final List<File> files;
  final bool isHidden;
  final String icon;
  final DateTime createdAt;
  final DateTime? modifiedAt;

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

  factory Folder.fromJson(Map<String, dynamic> json) {
    return Folder(
      id: json['id'].toString(), // Convert to String if necessary
      name: json['name'],
      parentId: json['parentId']?.toString(), // Convert to String if necessary
      isHidden: json['isHidden'] ?? false,
      icon: json['icon'],
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: json['modifiedAt'] != null
          ? DateTime.parse(json['modifiedAt'])
          : null,
      files: (json['files'] as List<dynamic>)
          .map((fileJson) => File.fromJson(fileJson as Map<String, dynamic>))
          .toList(),
      subFolders: (json['subFolders'] as List<dynamic>)
          .map((folderJson) =>
              Folder.fromJson(folderJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'parentId': parentId,
      'isHidden': isHidden,
      'icon': icon,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt?.toIso8601String(),
      'files': files.map((file) => file.toJson()).toList(),
      'subFolders': subFolders.map((folder) => folder.toJson()).toList(),
    };
  }

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
  Folder addSubFolder(Folder folder) {
    final updatedSubFolders = List<Folder>.from(subFolders)..add(folder);
    return copyWith(subFolders: updatedSubFolders);
  }

  // Method to add a file
  Folder addFile(File file) {
    final updatedFiles = List<File>.from(files)..add(file);
    return copyWith(files: updatedFiles);
  }
}

class File {
  final String id;  // Unique identifier
  final String name;  // File name
  final String type;  // File type or extension
  final int size;  // File size in bytes
  final String folderId;  // Reference to the folder that contains this file
  final bool isHidden;  // Whether the file is hidden or not
  final DateTime createdAt;  // When the file was created
  final DateTime? modifiedAt;  // When the file was last modified

  File({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    this.modifiedAt,
    this.isHidden = false,  // Default is not hidden
    required this.folderId,
    required this.createdAt,
  });
}

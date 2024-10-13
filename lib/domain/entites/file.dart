class File {
  final String id;
  final String name;
  final String type;
  final int size;
  final String folderId;
  final bool isHidden;
  final DateTime createdAt;
  final DateTime? modifiedAt;

  File({
    required this.id,
    required this.name,
    required this.type,
    required this.size,
    required this.folderId,
    this.isHidden = false,
    required this.createdAt,
    this.modifiedAt,
  });

  factory File.fromJson(Map<String, dynamic> json) {
    return File(
      id: json['id'].toString(), 
      name: json['name'],
      type: json['type'],
      size: json['size'],
      folderId: json['folderId'].toString(),
      isHidden: json['isHidden'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      modifiedAt: json['modifiedAt'] != null
          ? DateTime.parse(json['modifiedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'size': size,
      'folderId': folderId,
      'isHidden': isHidden,
      'createdAt': createdAt.toIso8601String(),
      'modifiedAt': modifiedAt?.toIso8601String(),
    };
  }
}

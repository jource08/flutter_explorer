import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/folder_provider.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';
import 'package:provider/provider.dart';

class FolderContentDetailed extends StatelessWidget {
  final Folder folder;

  const FolderContentDetailed({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FolderProvider>(context);

    return ListView(
      children: [
        // Display subfolders if they are not hidden
        ...provider.getVisibleSubFolders(folder).map((subFolder) => ListTile(
              title: Text(subFolder.name),
              leading: const Icon(Icons.folder), // You can use subFolder.icon here
            )),
        // Display files if they are not hidden
        ...provider.getVisibleFiles(folder).map((file) => ListTile(
              title: Text('${file.name}.${file.type}'),
              leading: const Icon(Icons.insert_drive_file),
            )),
      ],
    );
  }
}

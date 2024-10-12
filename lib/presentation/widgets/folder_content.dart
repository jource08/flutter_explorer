import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/folder_provider.dart';
import 'package:provider/provider.dart';

class FolderContent extends StatelessWidget {
  const FolderContent({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FolderProvider>(context);
    final folder = provider.selectedFolder;

    if (folder == null) {
      return const Center(child: Text('No folder selected'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Folder: ${folder.name}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        const Divider(),
        Expanded(
          child: ListView(
            children: [
              // Display subfolders if they are not hidden
              ...provider.getVisibleSubFolders(folder).map((subFolder) => ListTile(
                title: Text(subFolder.name),
                leading: const Icon(Icons.folder),  // You can use subFolder.icon here
              )),
              // Display files if they are not hidden
              ...provider.getVisibleFiles(folder).map((file) => ListTile(
                title: Text(file.name),
                leading: const Icon(Icons.insert_drive_file),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

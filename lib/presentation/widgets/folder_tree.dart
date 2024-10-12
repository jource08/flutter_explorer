import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/folder_provider.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';
import 'package:provider/provider.dart';

class FolderTree extends StatelessWidget {
  const FolderTree({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FolderProvider>(context);
    final rootFolder = provider.rootFolder;

    return ListView(
      children: [
        FolderItem(folder: rootFolder),
      ],
    );
  }
}

class FolderItem extends StatelessWidget {
  final Folder folder;

  const FolderItem({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FolderProvider>(context, listen: false);

    return ExpansionTile(
      leading: const Icon(Icons.folder),  // Use the default folder icon
      title: Text(folder.name),
      children: [
        // Display subfolders if they are not hidden
        for (var subFolder in provider.getVisibleSubFolders(folder))
          ListTile(
            title: Text(subFolder.name),
            leading: const Icon(Icons.folder),  // You can map the subFolder.icon to actual icons
            onTap: () => provider.selectFolder(subFolder),
          ),
      ],
    );
  }
}

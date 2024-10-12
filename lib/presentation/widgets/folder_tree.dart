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
    final provider = Provider.of<FolderProvider>(context);
    final isSelected = provider.selectedFolder?.id == folder.id; // Check if this folder is selected

    return ExpansionTile(
      leading: const Icon(Icons.folder), // Default folder icon
      title: Text(
        folder.name,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // Bold if selected
          color: isSelected ? Colors.blue : Colors.black, // Change color if selected
        ),
      ),
      children: [
        // Display subfolders if they are not hidden
        for (var subFolder in provider.getVisibleSubFolders(folder))
          FolderItem(folder: subFolder), // Recursive call for subfolders
      ],
      onExpansionChanged: (isExpanded) {
        // Select the folder when expanded
        if (isExpanded) {
          provider.selectFolder(folder); // Select the folder when expanded
        }
      },
    );
  }
}

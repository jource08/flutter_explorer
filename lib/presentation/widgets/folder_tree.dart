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

    return Expanded(
      child: ListView(
        children: [
          FolderItem(
              folder: rootFolder, depth: 0), // Start with depth 0 for root
        ],
      ),
    );
  }
}

class FolderItem extends StatelessWidget {
  final Folder folder;
  final int depth;

  const FolderItem({super.key, required this.folder, required this.depth});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FolderProvider>(context);
    final isSelected = provider.selectedFolder?.id == folder.id;
    final isExpanded =
        provider.shouldExpandFolder(folder); // Check if it should expand

    return Padding(
      padding: EdgeInsets.only(left: depth * 16.0),
      child: ExpansionTile(
        initiallyExpanded:
            isExpanded, // Set initial expanded state based on provider
        leading: const Icon(Icons.folder),
        title: Text(
          folder.name,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? Colors.blue : Colors.black,
          ),
        ),
        children: [
          for (var subFolder in provider.getVisibleSubFolders(folder))
            FolderItem(folder: subFolder, depth: depth + 1),
        ],
        onExpansionChanged: (isExpanded) {
          if (isExpanded) {
            provider.selectFolder(folder); // Select the folder when expanded
          }
        },
      ),
    );
  }
}

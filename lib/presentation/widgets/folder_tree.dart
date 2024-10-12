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

    // Use WidgetsBinding to perform actions after the initial frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.initialExpandAll) {
        provider.expandFolderRecursively(rootFolder);
      }
    });

    return Expanded(
      child: ListView(
        children: [
          FolderTreeItem(
              folder: rootFolder, depth: 0), // Start with depth 0 for root
        ],
      ),
    );
  }
}

class FolderTreeItem extends StatelessWidget {
  final Folder folder;
  final int depth;

  const FolderTreeItem({super.key, required this.folder, required this.depth});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FolderProvider>(context);
    final isSelected = provider.selectedFolder?.id == folder.id;

    // Check if the folder is expanded
    bool isExpanded = provider.isFolderExpanded(folder);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              provider.selectFolder(folder); // Select folder on double tap
            },
            child: Row(
              children: [
                GestureDetector(
                    onTap: () => provider.toggleFolderExpansion(
                        folder), // Toggle expansion state via provider,
                    child: Icon(isExpanded ? Icons.remove : Icons.add)),
                Row(
                  children: [
                    const Icon(Icons.folder),
                    const SizedBox(width: 8),
                    Text(
                      folder.name,
                      style: TextStyle(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                children: [
                  for (var subFolder in provider.getVisibleSubFolders(folder))
                    FolderTreeItem(folder: subFolder, depth: depth + 1),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

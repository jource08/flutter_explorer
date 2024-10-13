import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/folder_provider.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';
import 'package:provider/provider.dart';

class FolderTree extends StatelessWidget {
  const FolderTree({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FolderProvider>(context);
    final rootFolders = provider
        .rootFolders; // Changed to rootFolders to support multiple root folders

    // Use WidgetsBinding to perform actions after the initial frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.initialExpandAll && rootFolders.isNotEmpty) {
        for (var rootFolder in rootFolders) {
          provider.expandFolderRecursively(rootFolder);
        }
      }
    });

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(width: 1, color: Colors.black38),
        ),
      ),
      child: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator()) // Show loading indicator
          : rootFolders.isNotEmpty // Check if rootFolders is not empty
              ? ListView.builder(
                  itemCount: rootFolders.length,
                  itemBuilder: (context, index) {
                    return FolderTreeItem(
                      folder: rootFolders[index], // Pass each root folder
                      depth: 0, // Start with depth 0 for root
                    );
                  },
                )
              : const Center(
                  child: Text(
                      'No folders available')), // Show message if no folders
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
          // Highlight the selected folder
          Container(
            color: isSelected ? Colors.black12 : Colors.transparent, // Highlight color
            child: InkWell(
              onTap: () {
                provider.selectFolder(folder); // Select folder on tap
              },
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => provider.toggleFolderExpansion(folder), // Toggle expansion state via provider
                    child: Icon(isExpanded ? Icons.remove : Icons.add),
                  ),
                  const SizedBox(width: 8), // Added spacing for clarity
                  const Icon(Icons.folder),
                  const SizedBox(width: 8),
                  Text(
                    folder.name,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.w900 : FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
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

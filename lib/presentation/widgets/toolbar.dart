import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/folder_provider.dart';
import 'package:flutter_explorer/application/toolbar_provider.dart';
import 'package:flutter_explorer/presentation/widgets/toolbar_secondary.dart';
import 'package:provider/provider.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  const Toolbar({super.key});

  final double bottomBorderWidth = 1;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight +
      56 +
      bottomBorderWidth); // Adjust for secondary toolbar height

  @override
  Widget build(BuildContext context) {
    final toolbarProvider = Provider.of<ToolbarProvider>(context);
    final folderProvider = Provider.of<FolderProvider>(context);

    final currentFullPath = folderProvider.selectedFolder?.fullPath ?? "";
    // Update the path input field with the current path
    toolbarProvider.pathController.text = currentFullPath;

    // Determine if loading
    bool isLoading = folderProvider.isLoading;

    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: bottomBorderWidth, color: Colors.black38),
      )),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              // Back Button
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: isLoading
                    ? null
                    : () {
                        toolbarProvider
                            .goBack(); // Implement back functionality
                      },
              ),
              // Forward Button
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: isLoading
                    ? null
                    : () {
                        toolbarProvider
                            .goForward(); // Implement forward functionality
                      },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_upward),
                onPressed: (folderProvider.selectedFolder?.parentId?.isEmpty ??
                            true) ||
                        isLoading
                    ? null
                    : () {
                        // Get the current full path
                        String currentFullPath =
                            folderProvider.selectedFolder?.fullPath ?? '';

                        // Check if the current fullPath is not empty
                        if (currentFullPath.isNotEmpty) {
                          // Slice the current path to get the parent path
                          List<String> pathSegments =
                              currentFullPath.split('/');

                          if (pathSegments.length > 1) {
                            // Remove the last segment to go up one level
                            String parentPath = pathSegments
                                .sublist(0, pathSegments.length - 1)
                                .join('/');
                            folderProvider.selectFolderByFullPath(parentPath);
                          } else {
                            // If there's only one segment, set it to root (or handle accordingly)
                            folderProvider.selectFolderByFullPath('/');
                          }
                        }
                      },
              ),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: isLoading
                    ? null
                    : () {
                        folderProvider
                            .refresh(); // Call refresh directly on the folderProvider
                      },
              ),

              const SizedBox(width: 8),
              // Current Path Input
              Expanded(
                child: TextField(
                  controller: toolbarProvider.pathController,
                  decoration: InputDecoration(
                    hintText: 'Enter path',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  enabled: !isLoading, // Disable input when loading
                  onSubmitted: (value) {
                    if (!isLoading) {
                      toolbarProvider
                          .setPath(value); // Update path when submitted
                    }
                  },
                ),
              ),
            ],
          ),
          actions: [
            // Search Input
            Container(
              width: MediaQuery.of(context).size.width *
                  0.25, // Set width to 25% of screen width
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                enabled: !isLoading, // Disable search input when loading
                onSubmitted: (value) {
                  if (!isLoading) {
                    // Implement search functionality
                  }
                },
              ),
            ),
          ],
        ),
        body: const Column(
          children: [
            SecondaryToolbar(),
          ],
        ),
      ),
    );
  }
}

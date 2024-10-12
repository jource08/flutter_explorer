import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/folder_provider.dart';
import 'package:flutter_explorer/application/toolbar_provider.dart';
import 'package:flutter_explorer/presentation/widgets/folder_content_detailed.dart';
import 'package:flutter_explorer/presentation/widgets/folder_content_grid.dart';
import 'package:provider/provider.dart';

class FolderContent extends StatelessWidget {
  const FolderContent({super.key});

  @override
  Widget build(BuildContext context) {
    final folderProvider = Provider.of<FolderProvider>(context);
    final toolbarProvider = Provider.of<ToolbarProvider>(context);
    final folder = folderProvider.selectedFolder;

    if (folder == null) {
      return const Center(child: Text('No folder selected'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: toolbarProvider.isGridView
              ? FolderContentGrid(folder: folder)
              : FolderContentDetailed(folder: folder),
        ),
      ],
    );
  }
}

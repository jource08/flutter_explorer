import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/folder_provider.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';
import 'package:provider/provider.dart';

class FolderContentGrid extends StatelessWidget {
  final Folder folder;

  const FolderContentGrid({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FolderProvider>(context);

    return GridView.count(
      crossAxisCount: 4, // Number of columns in the grid
      children: [
        // Display subfolders if they are not hidden
        ...provider.getVisibleSubFolders(folder).map((subFolder) => InkWell(
              onTap: () {},
              onDoubleTap: () => provider.selectFolder(subFolder),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.folder, size: 48),
                  Text(subFolder.name),
                ],
              ),
            )),
        // Display files if they are not hidden
        ...provider.getVisibleFiles(folder).map((file) => InkWell(
              onTap: () {},
              onDoubleTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("File open event")));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.insert_drive_file, size: 48),
                  Text(file.name),
                ],
              ),
            )),
      ],
    );
  }
}

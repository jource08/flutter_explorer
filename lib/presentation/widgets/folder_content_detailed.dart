import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/folder_provider.dart';
import 'package:flutter_explorer/domain/entites/folder.dart';
import 'package:provider/provider.dart';

class FolderContentDetailed extends StatelessWidget {
  final Folder folder; // Assume this is your folder model class

  const FolderContentDetailed({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FolderProvider>(context);

    return Column(
      children: [
        // Header Row
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Row(
              children: [
                Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.arrow_upward, size: 16,)
              ],
            )),
            Expanded(
                child: Text('Date Modified',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
                child: Text('Type',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Expanded(
                child: Text('Size',
                    style: TextStyle(fontWeight: FontWeight.bold))),
          ],
        ),
        const Divider(),

        // Display subfolders
        ...provider.getVisibleSubFolders(folder).map((subFolder) => InkWell(
              onTap: () {},
              onDoubleTap: () => provider.selectFolder(subFolder),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      const Icon(Icons.folder),
                      Text(subFolder.name),
                    ],
                  )),
                  Expanded(child: Text(subFolder.modifiedAt.toString())),
                  const Expanded(child: Text('Folder')),
                  const Expanded(child: Text('')),
                ],
              ),
            )),

        // Display files
        ...provider.getVisibleFiles(folder).map((file) => InkWell(
              onTap: () {},
              onDoubleTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("File open event")));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      const Icon(Icons.insert_drive_file),
                      Text(file.name),
                    ],
                  )),
                  Expanded(child: Text(file.modifiedAt.toString())),
                  const Expanded(child: Text('File')),
                  Expanded(child: Text(file.size.toString())),
                ],
              ),
            )),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_explorer/presentation/widgets/folder_content.dart';
import 'package:flutter_explorer/presentation/widgets/folder_tree.dart';

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Explorer')),
      body: const Row(
        children: [
          // Left Panel: Folder Structure
          Expanded(
            flex: 1,
            child: FolderTree(),
          ),
          // Right Panel: Contents of Selected Folder
          Expanded(
            flex: 2,
            child: const FolderContent(),
          ),
        ],
      ),
    );
  }
}

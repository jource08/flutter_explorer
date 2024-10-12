import 'package:flutter/material.dart';
import 'package:flutter_explorer/presentation/widgets/folder_content.dart';
import 'package:flutter_explorer/presentation/widgets/folder_tree.dart';
import 'package:flutter_explorer/presentation/widgets/toolbar.dart'; // Import the Toolbar

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Toolbar(), // Use the Toolbar widget
      body: Row(
        children: [
          // Left Panel: Folder Structure
          Expanded(
            flex: 1,
            child: FolderTree(),
          ),
          // Right Panel: Contents of Selected Folder
          Expanded(
            flex: 2,
            child: FolderContent(),
          ),
        ],
      ),
    );
  }
}

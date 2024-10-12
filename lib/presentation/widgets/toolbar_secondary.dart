import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/toolbar_provider.dart';
import 'package:provider/provider.dart';

class SecondaryToolbar extends StatelessWidget {
  const SecondaryToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    final toolbarProvider = Provider.of<ToolbarProvider>(context);

    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // New Button with Menu
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            onSelected: (value) {
              // Implement create functionality based on selected value
              if (value == 'file') {
                // Logic to create a new file
              } else if (value == 'folder') {
                // Logic to create a new folder
              }
            },
            child: const Row(
              children: [
                Icon(Icons.add), // New Icon
                SizedBox(width: 4),
                Text('New'), // New Button Text
              ],
            ),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 'file', child: Text('New File')),
                const PopupMenuItem(value: 'folder', child: Text('New Folder')),
              ];
            },
          ),
          const SizedBox(width: 8),
          // Cut, Copy, Paste, Rename, Delete Buttons
          IconButton(
            icon: const Icon(Icons.cut),
            onPressed: () {
              // Implement Cut functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () {
              // Implement Copy functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.paste),
            onPressed: () {
              // Implement Paste functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Implement Rename functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Implement Delete functionality
            },
          ),
          const Spacer(), // Space between buttons and sort/view menus
          // Sort Menu Button
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            onSelected: (value) {
              // Implement sort functionality based on value
              // For example: sortItems(value);
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 'name', child: Text('Sort by Name')),
                const PopupMenuItem(value: 'date', child: Text('Sort by Date')),
              ];
            },
            child: const Icon(Icons.sort),
          ),
          const SizedBox(width: 8),
          // View Menu Button
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            onSelected: (value) {
              if (value == 'list') {
                toolbarProvider.toggleView(); // Call toggleView method to switch to list view
              } else if (value == 'grid') {
                toolbarProvider.toggleView(); // Call toggleView method to switch to grid view
              }
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 'list', child: Text('List View')),
                const PopupMenuItem(value: 'grid', child: Text('Grid View')),
              ];
            },
            child: const Icon(Icons.view_list),
          ),
        ],
      ),
    );
  }
}

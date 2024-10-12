import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/toolbar_provider.dart';
import 'package:provider/provider.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  const Toolbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 56); // Adjust for secondary toolbar height

  @override
  Widget build(BuildContext context) {
    final pathProvider = Provider.of<ToolbarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Back Button
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                pathProvider.goBack(); // Implement back functionality
              },
            ),
            // Forward Button
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                pathProvider.goForward(); // Implement forward functionality
              },
            ),
            // Up Button
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: () {
                pathProvider.goUp(); // Implement up functionality
              },
            ),
            // Refresh Button
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                pathProvider.refresh(); // Implement refresh functionality
              },
            ),
            const SizedBox(width: 8),
            // Current Path Input
            Expanded(
              child: TextField(
                controller: pathProvider.pathController,
                decoration: InputDecoration(
                  hintText: 'Enter path',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onSubmitted: (value) {
                  pathProvider.setPath(value); // Update path when submitted
                },
              ),
            ),
          ],
        ),
        actions: [
          // Search Input
          Container(
            width: MediaQuery.of(context).size.width * 0.25, // Set width to 25% of screen width
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
              onSubmitted: (value) {
                // Implement search functionality
              },
            ),
          ),
        ],
      ),
      body: const Column(
        children: [
          SecondaryToolbar(), // Include the secondary toolbar here
          // Your main content goes here (e.g., folder tree)
        ],
      ),
    );
  }
}

class SecondaryToolbar extends StatelessWidget {
  const SecondaryToolbar({super.key});

  @override
  Widget build(BuildContext context) {
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
              // Implement view functionality based on value
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

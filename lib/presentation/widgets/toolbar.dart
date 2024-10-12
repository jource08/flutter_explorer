import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/toolbar_provider.dart';
import 'package:flutter_explorer/presentation/widgets/toolbar_secondary.dart';
import 'package:provider/provider.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  const Toolbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 56); // Adjust for secondary toolbar height

  @override
  Widget build(BuildContext context) {
    final toolbarProvider = Provider.of<ToolbarProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Back Button
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                toolbarProvider.goBack(); // Implement back functionality
              },
            ),
            // Forward Button
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () {
                toolbarProvider.goForward(); // Implement forward functionality
              },
            ),
            // Up Button
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: () {
                toolbarProvider.goUp(); // Go up one level
              },
            ),
            // Refresh Button
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                toolbarProvider.refresh(); // Implement refresh functionality
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
                onSubmitted: (value) {
                  toolbarProvider.setPath(value); // Update path when submitted
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
          SecondaryToolbar(),
        ],
      ),
    );
  }
}

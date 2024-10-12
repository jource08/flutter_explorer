import 'package:flutter/material.dart';
import 'package:flutter_explorer/application/toolbar_provider.dart';
import 'package:provider/provider.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  const Toolbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final pathProvider = Provider.of<ToolbarProvider>(context);

    return AppBar(
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
          const SizedBox(width: 8), // Add space between buttons and path input
          // Current Path Input
          Expanded(
            child: TextField(
              controller: pathProvider.pathController,
              decoration: InputDecoration(
                hintText: 'Enter path',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  // borderSide: BorderSide.none,
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
                // borderSide: BorderSide.none,
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'application/folder_provider.dart';
import 'presentation/pages/explorer_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FolderProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Windows Explorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExplorerPage(),
    );
  }
}

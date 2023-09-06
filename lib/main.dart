import 'package:flutter/material.dart';
import 'package:open_transit_app/map_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Open Transit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF25A18E)),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Open Transit'),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: const CustomMapWidget(),
          );
        },
      ),
    );
  }
}

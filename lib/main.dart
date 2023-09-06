import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Open Transit'),
          forceMaterialTransparency: true,
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        drawerEnableOpenDragGesture: false,
        drawer: Drawer(
          child: ListView(
            children: const [
              ListTile(
                title: Text('Open Transit'),
              ),
            ],
          ),
        ),
        body: const CustomMapWidget(),
      ),
    );
  }
}

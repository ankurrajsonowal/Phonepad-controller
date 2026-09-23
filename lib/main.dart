import 'package:flutter/material.dart';
import 'controller_screen.dart';
import 'connection_service.dart';

void main() {
  runApp(const PhonePadApp());
}

class PhonePadApp extends StatelessWidget {
  const PhonePadApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeSelector(),
    );
  }
}

class HomeSelector extends StatelessWidget {
  const HomeSelector({super.key});
  @override
  Widget build(BuildContext context) {
    final conn = ConnectionService();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ControllerScreen(connection: conn))),
          child: const Text("START CONTROLLER"),
        ),
      ),
    );
  }
}

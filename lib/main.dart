import 'package:flutter/material.dart';
void main() => runApp(const MaterialApp(home: MyApp()));
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Text("PhonePad Controller Ready!", style: TextStyle(color: Colors.white, fontSize: 22))),
    );
  }
}

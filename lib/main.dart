import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const PhonePadApp());

class PhonePadApp extends StatelessWidget {
  const PhonePadApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhonePad',
      theme: ThemeData.dark(),
      home: const GamepadScreen(),
    );
  }
}

class GamepadScreen extends StatefulWidget {
  const GamepadScreen({super.key});
  @override
  State<GamepadScreen> createState() => _GamepadScreenState();
}

class _GamepadScreenState extends State<GamepadScreen> {
  Offset _leftStick = Offset.zero;
  Offset _rightStick = Offset.zero;
  bool isConnected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("PhonePad Controller", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              label: Text(isConnected ? "Connected" : "Not Connected", style: const TextStyle(fontSize: 12)),
              backgroundColor: isConnected ? Colors.green : Colors.red,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Top triggers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _triggerButton("L1"), _triggerButton("L2"),
                const Spacer(),
                _triggerButton("R2"), _triggerButton("R1"),
              ],
            ),
          ),
          const Spacer(),
          // Main controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left side - Dpad + Joystick
                Column(
                  children: [
                    _dPad(),
                    const SizedBox(height: 30),
                    _joystick(_leftStick, (p) => setState(() => _leftStick = p), Colors.blue),
                  ],
                ),
                // Right side - Buttons + Joystick
                Column(
                  children: [
                    _actionButtons(),
                    const SizedBox(height: 30),
                    _joystick(_rightStick, (p) => setState(() => _rightStick = p), Colors.orange),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          // Bottom controls
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _smallButton(Icons.select_all, "SELECT"),
                const SizedBox(width: 30),
                ElevatedButton.icon(
                  onPressed: () => setState(() => isConnected = !isConnected),
                  icon: Icon(isConnected ? Icons.bluetooth_connected : Icons.bluetooth),
                  label: Text(isConnected ? "Disconnect" : "Connect to PC"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isConnected ? Colors.red : Colors.blue,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                ),
                const SizedBox(width: 30),
                _smallButton(Icons.start, "START"),
              ],
            ),
          ),
       

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
              label: Text(isConnected? "Connected" : "Not Connected", style: const TextStyle(fontSize: 12)),
              backgroundColor: isConnected? Colors.green : Colors.red,
            ),
          )
        ],
      ),
      body: Column(
        children: [
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [_dPad(), const SizedBox(height: 30), _joystick(_leftStick, (p) => setState(() => _leftStick = p), Colors.blue)]),
                Column(children: [_actionButtons(), const SizedBox(height: 30), _joystick(_rightStick, (p) => setState(() => _rightStick = p), Colors.orange)]),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _smallButton(Icons.select_all, "SELECT"),
                const SizedBox(width: 30),
                ElevatedButton.icon(
                  onPressed: () => setState(() => isConnected =!isConnected),
                  icon: Icon(isConnected? Icons.bluetooth_connected : Icons.bluetooth),
                  label: Text(isConnected? "Disconnect" : "Connect to PC"),
                  style: ElevatedButton.styleFrom(backgroundColor: isConnected? Colors.red : Colors.blue, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                ),
                const SizedBox(width: 30),
                _smallButton(Icons.start, "START"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _triggerButton(String label) => Container(padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10), decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(8)), child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)));
  Widget _smallButton(IconData icon, String label) => Column(children: [Icon(icon, size: 28), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 10))]);
  Widget _dPad() => SizedBox(width: 120, height: 120, child: Stack(children: [Positioned(top: 0, left: 40, child: _dPadKey(Icons.arrow_drop_up)), Positioned(bottom: 0, left: 40, child: _dPadKey(Icons.arrow_drop_down)), Positioned(top: 40, left: 0, child: _dPadKey(Icons.arrow_left)), Positioned(top: 40, right: 0, child: _dPadKey(Icons.arrow_right)), const Positioned(top: 40, left: 40, child: CircleAvatar(radius: 20, backgroundColor: Color(0xFF222222)))]));
  Widget _dPadKey(IconData icon) => Container(width: 40, height: 40, decoration: BoxDecoration(color: Colors.grey[850], borderRadius: BorderRadius.circular(6)), child: Icon(icon, color: Colors.white70));
  Widget _actionButtons() => SizedBox(width: 120, height: 120, child: Stack(children: [Positioned(top: 0, left: 40, child: _gameButton("Y", Colors.yellow)), Positioned(bottom: 0, left: 40, child: _gameButton("A", Colors.green)), Positioned(top: 40, left: 0, child: _gameButton("X", Colors.blue)), Positioned(top: 40, right: 0, child: _gameButton("B", Colors.red))]));
  Widget _gameButton(String label, Color color) => Container(width: 40, height: 40, decoration: BoxDecoration(color: color, shape: BoxShape.circle), child: Center(child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white))));
  Widget _joystick(Offset pos, Function(Offset) onMove, Color color) {
    return GestureDetector(
      onPanUpdate: (d) {
        final center = const Offset(50, 50);
        Offset delta = d.localPosition - center;
        double dist = math.sqrt(delta.dx * delta.dx + delta.dy * delta.dy);
        if (dist > 35) delta = Offset.fromDirection(math.atan2(delta.dy, delta.dx), 35);
        onMove(delta);
      },
      onPanEnd: (_) => onMove(Offset.zero),
      child: Container(width: 100, height: 100, decoration: BoxDecoration(color: Colors.grey[900], shape: BoxShape.circle, border: Border.all(color: Colors.grey.shade800, width: 2)), child: Stack(children: [Center(child: Container(width: 60, height: 60, decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle))), Positioned(left: 50 + pos.dx - 20, top: 50 + pos.dy - 20, child: Container(width: 40, height: 40, decoration: BoxDecoration(color: color, shape: BoxShape.circle)))])),
    );
  }
}

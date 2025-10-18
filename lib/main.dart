import 'package:flutter/material.dart';
import 'screens/camera_screen.dart';

void main() {
  runApp(const SmartVisualAssistant());
}

class SmartVisualAssistant extends StatelessWidget {
  const SmartVisualAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Visual Assistant',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const CameraScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'presentation/screens/camera_screen.dart';

class PhishSnapApp extends StatelessWidget {
  const PhishSnapApp({super.key});

  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: const CameraScreen(), debugShowCheckedModeBanner: false);
}
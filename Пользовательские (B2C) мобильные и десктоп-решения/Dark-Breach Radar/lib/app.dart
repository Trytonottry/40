import 'package:flutter/material.dart';
import 'presentation/screens/home_screen.dart';

class DarkBreachApp extends StatelessWidget {
  const DarkBreachApp({super.key});

  @override
  Widget build(BuildContext context) =>
     MaterialApp(title: 'Dark-Breach Radar', home: HomeScreen());
}
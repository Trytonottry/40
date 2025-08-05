import 'package:flutter/material.dart';
import '../../domain/entities/scan_result.dart';

class ResultScreen extends StatelessWidget {
  final ScanResult result;
  const ResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final color = result.isPhish ? Colors.red : Colors.green;
    return Scaffold(
      backgroundColor: color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(result.isPhish ? Icons.dangerous : Icons.check_circle,
                size: 120, color: Colors.white),
            const SizedBox(height: 24),
            Text(
              result.isPhish ? 'ФИШИНГ!' : 'Безопасно',
              style: const TextStyle(
                  fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                result.url,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Сканировать ещё'),
            ),
          ],
        ),
      ),
    );
  }
}
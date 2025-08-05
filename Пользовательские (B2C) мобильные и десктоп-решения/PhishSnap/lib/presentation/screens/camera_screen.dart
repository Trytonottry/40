import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import '../../data/repositories/scan_repository_impl.dart';
import 'result_screen.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  final _repo = ScanRepositoryImpl();
  final _scanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);

  @override
  void initState() {
    super.initState();
    _repo.init();
    availableCameras().then((cams) {
      _controller = CameraController(cams[0], ResolutionPreset.medium);
      _controller.initialize().then((_) => setState(() {}));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scanner.close();
    super.dispose();
  }

  Future<void> _scanFrame() async {
    final img = await _controller.takePicture();
    final input = InputImage.fromFilePath(img.path);
    final barcodes = await _scanner.processImage(input);
    if (barcodes.isNotEmpty) {
      final url = barcodes.first.rawValue ?? '';
      final result = _repo.scan(url);
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => ResultScreen(result: result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) return const SizedBox.shrink();
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(_controller),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: FloatingActionButton(
                onPressed: _scanFrame,
                child: const Icon(Icons.qr_code_scanner),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'dart:developer';
import 'dart:typed_data';
import 'package:brosoftresturent/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Scanner'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.torchState,
              builder: (context, state, child) {
                switch (state as TorchState) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.toggleTorch(),
          ),
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state as CameraFacing) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            // fit: BoxFit.contain,
            controller: cameraController,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              final Uint8List? image = capture.image;
              for (final barcode in barcodes) {
                log('Barcode found! ${barcode.rawValue}');

                if (barcode.rawValue!.isNotEmpty) {
                  _navigateToResultScreen(barcode.rawValue!);
                  cameraController.stop();
                }

                if (barcode.format == BarcodeFormat.qrCode) {
                  // Handle WiFi QR code
                  handleWifiQRCode(barcode.rawValue!);
                }
              }
            },
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToResultScreen(String barcodeValue) async {
    await Get.to(() => ResultScreen(result: barcodeValue));
    cameraController.stop();
  }

  //Qr formate wifi
  void handleWifiQRCode(String rawResult) {
    // Parse the rawResult to extract the password
    final List<String> keyValuePairs = rawResult.split(';');
    String password = '';

    for (final pair in keyValuePairs) {
      final List<String> parts = pair.split(':');
      if (parts.length == 2) {
        final String key = parts[0].trim().toLowerCase();
        final String value = parts[1].trim();

        if (key == 'password') {
          password = value;
          break;
        }
      }
    }

    if (password.isNotEmpty) {
      // Navigate to ResultScreen and wait for result
      _navigateToResultScreen(password);
    }
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.result});

  final String result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(const HomeScreen());
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Center(child: Text(result ?? "")),
    );
  }
}

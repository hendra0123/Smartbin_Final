import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:smartbin/viewmodel/SampahController.dart';
import 'package:smartbin/viewmodel/points_controller.dart';

class QRScannerPage extends StatefulWidget {
  @override
  _QRScannerPageState createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  bool isScanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Barcode"),
        leading: BackButton(),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Camera view
          MobileScanner(
            controller: MobileScannerController(
              detectionSpeed: DetectionSpeed.normal,
              facing: CameraFacing.back,
            ),
            onDetect: (capture) {
              final barcode = capture.barcodes.first;
              final String? code = barcode.rawValue;
              if (code != null && !isScanned) {
                setState(() {
                  isScanned = true;
                });

                PointsController.addPoints(50); // Add 50 coins
                SampahController.addSampah(1); // Add 1 to total sampah

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text('Scanned: $code — +50 coins, +1 sampah')),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Scanned: $code')),
                );
              }
            },
          ),

          // Overlay
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent, width: 2),
              ),
              child: CustomPaint(
                foregroundPainter: _RedLinePainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Custom painter to draw red line
class _RedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    final middleY = size.height / 2;
    canvas.drawLine(Offset(0, middleY), Offset(size.width, middleY), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

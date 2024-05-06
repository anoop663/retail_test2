import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class BarcodeApp extends StatefulWidget {
  const BarcodeApp({Key? key}) : super(key: key);

  @override
  State<BarcodeApp> createState() => _BarcodeAppState();
}

class _BarcodeAppState extends State<BarcodeApp> {
  String result = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Scan Barcode',
          style: TextStyle(
            color: Color(0xff4B4B87),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 16),
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('lib/assets/Back1.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () async {
                var res = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimpleBarcodeScannerPage(),
                  ),
                );
                setState(() {
                  if (res is String) {
                    result = res;
                  }
                },
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: const Color(0XFF4B4B87), // Background color
              ),
              child: Container(
                width: 120, // Adjusted width for better visualization
                height: 40, // Adjusted height for better visualization
                alignment: Alignment.center,
                child: const Text(
                  'Scan Barcode',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Text('Barcode Result: $result')
          ],
        ),
      ),
    );
  }
}

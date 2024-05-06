import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/hive_services.dart';
import 'package:project_fourth/screens/widgets/homepage/home_model.dart';

class SalesGraphWidgetBackup1 extends StatefulWidget {
  const SalesGraphWidgetBackup1({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SalesGraphWidgetBackupState1 createState() =>
      _SalesGraphWidgetBackupState1();
}

class _SalesGraphWidgetBackupState1 extends State<SalesGraphWidgetBackup1> {
  final HiveServices _hiveController = HiveServices();
  List<SalesGraphModel> salesDataList = [];
  double maxValue = 0;
  List<Color> pillarColors = [
    const Color(0xFF6659FF),
    const Color(0xFFB9EAFF),
    const Color(0xFFBEADFF),
    const Color(0xFFEC77FF),
  ]; // Define different colors for each pillar

  @override
  void initState() {
    super.initState();
    loadSalesData();
  }

  Future<void> loadSalesData() async {
    List<SalesGraphModel> graph = await _hiveController.hiveSalesGraph();
    graph.sort((a, b) =>
        double.parse(b.salesValue).compareTo(double.parse(a.salesValue)));
    setState(() {
      salesDataList = graph.take(4).toList();
      // Calculate the maximum sales value
      maxValue = salesDataList.isNotEmpty
          ? salesDataList
              .map((data) => double.parse(data.salesValue))
              .reduce((value, element) => value > element ? value : element)
          : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: 358,
        height: 245,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 110,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(-1.57),
                child: const Text(
                  'Sales',
                  style: TextStyle(
                    color: Color(0xFF4B4B87),
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
            const Positioned(
              left: 150,
              top: 230,
              child: Text(
                'Customers',
                style: TextStyle(
                  color: Color(0xFF4B4B87),
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                  height: 0,
                ),
              ),
            ),
            // Fetch customer names dynamically
            for (int i = 0; i < salesDataList.length; i++)
              Positioned(
                left: 45 + 80 * i.toDouble(), // Adjust position dynamically
                bottom: 24, // Position at the bottom
                child: Text(
                  salesDataList[i].customerName,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            // Render sales values dynamically
            for (int i = 0; i < salesDataList.length; i++)
              Positioned(
                left: 27 + 80 * i.toDouble(), // Adjust position dynamically
                top: 205 -
                    (180 * double.parse(salesDataList[i].salesValue) / maxValue),
                child: Text(
                  salesDataList[i].salesValue.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
              ),
            // Render colored bars
            for (int i = 0; i < salesDataList.length; i++)
              Positioned(
                left: 63 + 80 * i.toDouble(), // Adjust position dynamically
                bottom:
                    40, // Adjust bottom position to align with the bottom of the graph
                child: Container(
                  width: 30,
                  height:
                      206 * double.parse(salesDataList[i].salesValue) / maxValue,
                  decoration: BoxDecoration(
                    color: pillarColors[
                        i % pillarColors.length], // Assign a color from the list
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            // Render horizontal lines
            for (int i = 0; i < 6; i++)
              Positioned(
                left: 40,
                bottom: 9 +
                    41 *
                        i.toDouble(), // Adjust bottom position to align with the bottom of the graph
                // ignore: sized_box_for_whitespace
                child: Container(
                  width: 318,
                  height: 32, // Change height to represent horizontal lines
                  child: CustomPaint(
                    painter: DottedLinePainter(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFFE2E2E2)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    const double dashWidth = 5;
    const double dashSpace = 3;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

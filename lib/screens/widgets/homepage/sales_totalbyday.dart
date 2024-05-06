import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/home_controller.dart';
import 'package:project_fourth/screens/widgets/sales_module/list_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';

class SalesDropdownAndTotal extends StatefulWidget {
  const SalesDropdownAndTotal({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SalesDropdownAndTotalState createState() => _SalesDropdownAndTotalState();
}

class _SalesDropdownAndTotalState extends State<SalesDropdownAndTotal> {
  final GraphData _homeGraph = GraphData();
  String dropdownValue = 'Total'; // Initial dropdown value
  double totalGrandFuture = 0.0; // Initial total sales value

  @override
  void initState() {
    super.initState();
    calculateTotalGrandHive().then((value) {
      setState(() {
        totalGrandFuture = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                  calculateTotalSales(newValue);
                }
              },
              style:
                  const TextStyle(color: Colors.black), // Dropdown text color
              icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
              underline: const SizedBox(), // Remove underline
              items: <String>[
                'Total',
                'Today',
                'Yesterday',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ListSales(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                decoration: ShapeDecoration(
                  color: const Color(0xFF2AC3FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 16,
                      top: 10,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFF38D3FD),
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('lib/assets/Vector5.png'),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      top: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          const Text(
                            'Sales',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            '₹ ${totalGrandFuture.toString()}',
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void calculateTotalSales(String newValue) async {
    final double totalSales = await _homeGraph.getTotalSalesForTimeFrame(newValue);
    setState(() {
      totalGrandFuture = totalSales;
    });
  }
}

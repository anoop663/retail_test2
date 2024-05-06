import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/sales_graph_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/sales_totalbyday.dart';
import 'package:project_fourth/screens/widgets/sales_module/add_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:provider/provider.dart';
import 'package:project_fourth/screens/widgets/homepage/count_provider.dart';
import 'package:project_fourth/screens/widgets/homepage/navigation_drawerscreen2.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/add_product_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/outofstock_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Home',
              style: TextStyle(
                color: Color(0xff4B4B87),
                fontWeight: FontWeight.bold, // Make text bold
              ),
            ),
            centerTitle: true,
            leading: Builder(
              // Wrap leading with Builder
              builder: (context) => GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Image.asset('lib/assets/Vector1.png',
                      width: 40, height: 40),
                ),
              ),
            ),
          ),
          drawer: const MyDrawer2(), // Use MyDrawer as the drawer
          backgroundColor: const Color(0xFFF1F5F9),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigation(initialIndex: 2),
                              ),
                            );
                          },
                          child: Container(
                            height: isDesktop ? 200 : 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF6968),
                              borderRadius: BorderRadius.circular(20),
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
                                      color: Color(0xFFFF8280),
                                      shape: BoxShape.circle,
                                    ),
                                    child:
                                        Image.asset('lib/assets/Vector2.png'),
                                  ),
                                ),
                                Positioned(
                                  left: 80,
                                  top: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      const Text(
                                        'Categories',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        Provider.of<CountProvider>(context)
                                            .catCount
                                            .toString(),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigation(initialIndex: 3),
                              ),
                            );
                          },
                          child: Container(
                            height: isDesktop ? 200 : 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFF7A54FF),
                              borderRadius: BorderRadius.circular(20),
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
                                      color: Color(0xFF926AFF),
                                      shape: BoxShape.circle,
                                    ),
                                    child:
                                        Image.asset('lib/assets/Vector3.png'),
                                  ),
                                ),
                                Positioned(
                                  left: 80,
                                  top: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      const Text(
                                        'Total Products',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        Provider.of<CountProvider>(context)
                                            .proCount
                                            .toString(),
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
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) =>
                                    const BottomNavigation(initialIndex: 1),
                              ),
                            );
                          },
                          child: Container(
                            height: isDesktop ? 200 : 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF8F61),
                              borderRadius: BorderRadius.circular(20),
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
                                      color: Color(0xFFFEA776),
                                      shape: BoxShape.circle,
                                    ),
                                    child:
                                        Image.asset('lib/assets/Vector4.png'),
                                  ),
                                ),
                                Positioned(
                                  left: 80,
                                  top: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      const Text(
                                        'Customers',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        Provider.of<CountProvider>(context)
                                            .custCount
                                            .toString(),
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const OutofStock()));
                          },
                          child: Container(
                            height: isDesktop ? 200 : 120,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFF61C0),
                              borderRadius: BorderRadius.circular(20),
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
                                      color: Color(0xFFFF8DDF),
                                      shape: BoxShape.circle,
                                    ),
                                    child:
                                        Image.asset('lib/assets/Vector3.png'),
                                  ),
                                ),
                                Positioned(
                                  left: 80,
                                  top: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 15),
                                      const Text(
                                        'Out Of Stock',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        Provider.of<CountProvider>(context)
                                            .outCount
                                            .toString(),
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
                ),
                const SizedBox(height: 5),
                const SalesDropdownAndTotal(),
                const SizedBox(height: 10),
                const SalesGraphWidgetBackup1(),
                const SizedBox(height: 100), // Adjust this size as needed
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(left: 30.0, bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    Provider.of<SalesControllerState>(context, listen: false)
                        .selectedProducts
                        .clear();
                    Provider.of<SalesControllerState>(context, listen: false)
                        .nosControllers
                        .clear();
                    Provider.of<SalesControllerState>(context, listen: false)
                        .totalControllers
                        .clear();
                    Provider.of<SalesControllerState>(context, listen: false)
                        .addRow();
                    Provider.of<SalesControllerState>(context, listen: false)
                        .getCustomers();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AddSales()));
                  },
                  backgroundColor: const Color(0xFF4B4B87),
                  tooltip: 'Sales Button',
                  heroTag: "111111155",
                  shape: const CircleBorder(),
                  child:
                      const Icon(Icons.percent, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 12), // Add space between the buttons
                FloatingActionButton(
                  heroTag: "11111111",
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const AddProducts()));
                  },
                  backgroundColor: const Color(0xFF4B4B87),
                  tooltip: 'New Product',
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add, color: Colors.white, size: 28),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

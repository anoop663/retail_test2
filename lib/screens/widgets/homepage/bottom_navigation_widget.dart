import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/list_customer_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/home_screen.dart';
import 'package:project_fourth/screens/widgets/product_module/list_category_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/list_product_widget.dart';

class BottomNavigation extends StatefulWidget {
  final int initialIndex; // Index to be initially selected

  const BottomNavigation({Key? key, required this.initialIndex})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int
      _currentIndex; // Track the current index of the bottom navigation bar

  final List<Widget> _pages = [
    const HomePage(),
    const ListCustomer(),
    const ListCategories(),
    const ListProducts(),
  ]; // List of pages to switch between

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex; // Set initial index
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Display the current page based on the selected index
          IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          Positioned(
            // Bottom navigation bar positioned at the bottom of the screen
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset('lib/assets/home_notselec.png'),
                  activeIcon: Image.asset('lib/assets/Home1.png'),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('lib/assets/Customers1.png'),
                  activeIcon: Image.asset('lib/assets/cust_select.png'),
                  label: 'Customers',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('lib/assets/Categories1.png'),
                  activeIcon: Image.asset('lib/assets/cat_select.png'),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset('lib/assets/Product1.png'),
                  activeIcon: Image.asset('lib/assets/prod_select.png'),
                  label: 'Products',
                ),
              ],
              selectedItemColor: const Color(0xFF4B4B87),
              unselectedItemColor: const Color.fromARGB(255, 121, 119, 119),
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index; // Update the selected index
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

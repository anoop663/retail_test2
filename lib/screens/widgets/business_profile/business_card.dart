import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_controller.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_model.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_screen.dart';
import 'package:project_fourth/screens/widgets/customer_module/list_customer_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/home_screen.dart';
import 'package:project_fourth/screens/widgets/product_module/list_category_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/list_product_widget.dart';

class BusinessCard extends StatefulWidget {
  const BusinessCard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _BusinessCardState createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  final BusinussController _businessController = BusinussController();
  @override
  void initState() {
    super.initState();
    _businessController.getAllBusines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Business Profile',
          style: TextStyle(
            color: Color(0xff4B4B87),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(initialIndex: 0),
              ),
            );
          },
          child: Container(
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
        ),
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ValueListenableBuilder<List<RetailModel2>>(
          valueListenable: _businessController.businessListNotifier,
          builder: (context, business1, _) {
            // ignore: avoid_print
            print('Busniess length: ${business1.length}');
            return business1.isEmpty
                ? Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BusinessProfile(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF4B4B87), // Background color
                        foregroundColor: Colors.white, // Text color
                      ),
                      child: const Text('Add your Business Profile'),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (ctx, index) {
                      final business = business1[index];
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF6968),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Business Name: ${business.name}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Phone: ${business.phone}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Address: ${business.address}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Hero(
                                    tag: 'edit_icon_${business.id}',
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 90, right: 8),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BusinessProfile(
                                                      business: business),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          backgroundColor: const Color(
                                              0XFF4B4B87), // Background color
                                        ),
                                        child: Container(
                                          width: 40,
                                          height: 16,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Update',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                      padding: EdgeInsets.only(top: 20)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 14),
                    itemCount: 1,
                  );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Home1.png'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Customers1.png'),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Categories1.png'),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('lib/assets/Product1.png'),
            label: 'Products',
          ),
        ],
        selectedItemColor: const Color(0xFF4B4B87),
        unselectedItemColor: const Color.fromARGB(255, 121, 119, 119),
        currentIndex: 1,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
              break;
            case 1:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ListCustomer()));
              break;
            case 2:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ListCategories()));
              break;
            case 3:
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const ListProducts(),
              ));
              break;
          }
        },
      ),
    );
  }
}

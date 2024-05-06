import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/add_customer_widget.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_controller.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';

class ListCustomer extends StatefulWidget {
  const ListCustomer({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListCustomerState createState() => _ListCustomerState();
}

class _ListCustomerState extends State<ListCustomer> {
  final CustomerController _customerController = CustomerController();
  @override
  void initState() {
    super.initState();
    _customerController.getAllCustomers();
  }

  // Delete confirmation popup
  Future<void> showDeleteConfirmationDialog(int id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this customer?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                _customerController.deleteCustomers(id);
                Navigator.of(context).pop(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Customer deleted successfully!'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //Provider.of<CountProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Customer List',
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
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ValueListenableBuilder<List<CustomerModel>>(
          valueListenable: _customerController.customerListNotifier,
          builder: (context, customers, _) {
            // Log the length of customers to verify if data exists
            // ignore: avoid_print
            print('Customers length: ${customers.length}');

            //Count provider Data passing
            // cusCount.updateCustomerCount(customers.length);

            return customers.isEmpty
                ? const Center(
                    child: Text('There are no Customers added yet.'),
                  )
                : ListView.separated(
                    itemBuilder: (ctx, index) {
                      final customer = customers[index];
                      return Container(
                        height: 85,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
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
                                padding: const EdgeInsets.only(top: 20),
                                child: Text(customer.name),
                              ),
                              Row(
                                children: [
                                  Hero(
                                    tag: 'edit_icon_${customer.id}',
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, right: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => AddCustomer(
                                                  customer: customer),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: const Color(0XFF98B5FF),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'lib/assets/edit1.png'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        // Show delete confirmation dialog
                                        showDeleteConfirmationDialog(
                                            customer.id!);
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: const Color(0XFFFA3E3E),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                                'lib/assets/delete1.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      if (index == customers.length) {
                        return const SizedBox(height: 100);
                        
                      } else {
                        return const SizedBox(height: 14);
                      }
                    },
                    itemCount: customers.length,
                  );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0, bottom: 50),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF4B4B87),
          tooltip: 'New Customer',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddCustomer()),
            );
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}

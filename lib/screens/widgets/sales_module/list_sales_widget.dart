import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/list_category_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/add_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';
import 'package:provider/provider.dart';

class ListSales extends StatefulWidget {
  const ListSales({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListSalesState createState() => _ListSalesState();
}

class _ListSalesState extends State<ListSales> {
  final TextEditingController _searchController = TextEditingController();
  final SalesController _salesController = SalesController();
  List<SalesModel> _allSales = [];

  @override
  void initState() {
    super.initState();
    // Initialize Hive when the widget is first initialized
    _salesController.initializeHiveSales();
    _allSales = _salesController
        .salesListNotifier.value; // Store all products initially
  }

  Future<void> showDeleteConfirmationDialog(int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        final salesState = Provider.of<SalesControllerState>(context);

        return AlertDialog(
          title: const Text("Confirm Delete"),
          content:
              const Text("Are you sure you want to delete this sales entry?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                debugPrint('The Sales id is: $index');
                salesState.deleteSale(index);
                //Navigator.of(context).pop(true);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ListSales(),
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sales deleted successfully!'),
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
    final salesState = Provider.of<SalesControllerState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Sales List',
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Search with Cusomer Name",
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  // Filter products based on the entered text
                  filterSales(value);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ValueListenableBuilder<List<SalesModel>>(
                valueListenable: _salesController.salesListNotifier,
                builder: (context, sales, _) {
                  if (sales.isEmpty) {
                    return const Center(
                      child: Text(
                        'Sales List is Empty',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(137, 0, 0, 0),
                        ),
                      ),
                    );
                  } else {
                    return ListView.separated(
                      itemBuilder: (ctx, index) {
                        final sale = sales[index];
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
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    'Cust Name: ${sale.customer}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                    height:
                                        4), // Add space between customer name and ID
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ID: ${sale.id}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      '₹ ${sale.grand}',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Hero(
                                    tag: 'edit_icon_${sale.id}',
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, right: 8),
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) =>
                                          //         UpdateSales(sales: sale),
                                          //   ),
                                          // );

                                          salesState.editClickBinding(sale);
                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddSales(
                                                        sales: sale,
                                                      )));
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
                                    padding: const EdgeInsets.only(top: 0),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDeleteConfirmationDialog(index);
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
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 14),
                      itemCount: sales.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(width: 12), // Add space between the buttons
            FloatingActionButton(
              backgroundColor: const Color(0xFF4B4B87),
              tooltip: 'New Sales',
              heroTag: generateRandomString(6),
              shape: const CircleBorder(),
              onPressed: () {
                //Add sales page navigation
                salesState.selectedProducts.clear();
                salesState.nosControllers.clear();
                salesState.totalControllers.clear();
                salesState.addRow();
                salesState.getCustomers();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const AddSales()));
              },
              child: const Icon(Icons.percent_outlined,
                  color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }

  void filterSales(String value) {
    if (value.isEmpty) {
      // If search text is empty, restore all Sales
      _salesController.salesListNotifier.value = _allSales;
      return;
    }
    // Filter Sales based on the entered text
    List<SalesModel> filteredSales = _allSales.where((sales) {
      return sales.customer.toLowerCase().contains(value.toLowerCase());
    }).toList();
    // Update the ValueListenable with the filtered Sales
    _salesController.salesListNotifier.value = filteredSales;
  }
}

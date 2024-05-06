import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_controller.dart';
import 'package:project_fourth/screens/widgets/product_module/update_product_widget.dart';

class OutofStock extends StatefulWidget {
  const OutofStock({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _OutofStockState createState() => _OutofStockState();
}

class _OutofStockState extends State<OutofStock> {
  final ProductPageController _productpageController = ProductPageController();
  String result = '';
  // ignore: prefer_final_fields
  TextEditingController _searchController = TextEditingController();
  List<ProductModel> _allProducts = [];

  @override
  void initState() {
    super.initState();
    _productpageController.initializeHive();
    _allProducts = _productpageController.productListNotifier.value;
    _allProducts.map((product) => product.category).toSet().toList();
  }

  Future<void> showDeleteConfirmationDialog(int id) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text("Are you sure you want to delete this product?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () {
                _productpageController.deleteProducts(id);
                Navigator.of(context).pop(true);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product deleted successfully!'),
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Product List',
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
        actions: const [],
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
                  hintText: "Search...",
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
                  // filterProducts(value);
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ValueListenableBuilder<List<ProductModel>>(
                valueListenable: _productpageController.productListNotifier,
                builder: (context, products, _) {
                  final outOfStockProducts = products
                      .where((product) => product.stock == "0")
                      .toList();

                  if (products.isEmpty) {
                    return const Center(
                      child: Text(
                        'Product List is Empty',
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
                        final product = outOfStockProducts[index];
                        return Container(
                          height: 100,
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
                            leading: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10), // Adjust the top padding as needed
                              child: CircleAvatar(
                                radius: 26,
                                backgroundImage: product.image != null
                                    ? FileImage(File(product.image!))
                                    : const AssetImage(
                                            'lib/assets/app_icon.png')
                                        as ImageProvider<Object>?,
                              ),
                            ),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 18),
                                  child: Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Hero(
                                      tag: 'edit_icon_${product.id}',
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 23, right: 8),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateProducts(
                                                        product: product),
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
                                          showDeleteConfirmationDialog(
                                              product.id!);
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
                            subtitle: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Price: ${product.price}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    'Stock: ${product.stock}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 14),
                      itemCount: outOfStockProducts.length,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

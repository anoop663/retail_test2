import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/hive_services.dart';
import 'package:project_fourth/screens/widgets/product_module/list_product_widget.dart';
import 'package:project_fourth/screens/widgets/product_module/product_controller.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';
import 'package:provider/provider.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class AddSalesDynamic extends StatefulWidget {
  final SalesModel? sales;
  const AddSalesDynamic({
    Key? key,
    this.sales,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddSalesDynamicState createState() => _AddSalesDynamicState();
}

class _AddSalesDynamicState extends State<AddSalesDynamic> {
  final ProductPageController _productpageController = ProductPageController();
  final HiveServices _hiveServices = HiveServices();
  final List<ProductModel> products = [];

  double grandTotal = 0;

  bool isLoadingItem = false;

  @override
  void initState() {
    super.initState();
    loadProducts();
    //addRow();
  }

  Future<void> loadProducts() async {
    isLoadingItem = (true);
    final productBox = await _hiveServices.hiveProducts();
    setState(() {
      products.addAll(productBox);
      isLoadingItem = (false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final salesState = Provider.of<SalesControllerState>(context);
    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: salesState.selectedProducts.length,
            itemBuilder: (b, i) {
              return isLoadingItem
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : productIncrement(i, salesState);
            }),

        // for (int i = 0; i < salesState.selectedProducts.length; i++)
        //   productIncrement(i, salesState),
        const SizedBox(height: 10), // Add gap between rows
        buildGrandTotalField(salesState), // Add grand total field
      ],
    );
  }

  Widget buildGrandTotalField(SalesControllerState salesState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Grand Total',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
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
            readOnly: true,
            controller: salesState.grandTotalController,
            decoration: InputDecoration(
              hintText: "Grand Total",
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
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget productIncrement(int i, SalesControllerState state) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 0,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: GestureDetector(
                  onTap: () async {
                    var scanResult = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SimpleBarcodeScannerPage(),
                      ),
                    );
                    if (scanResult is String) {
                      setState(() {
                        String result = scanResult;
                        filterProducts(result);
                      });
                      //filterProducts(_searchController.text);
                    } else {
                      String result = scanResult.toString();
                      setState(
                        () {
                          result = scanResult;
                          filterProducts(result);
                        },
                      );
                    }

                    // Set the scanned product in the dropdown
                    setState(() {
                      state.nosControllers[i].text = '1';
                      double price1 = double.parse(scanResult.price);
                      state.totalControllers[i].text = price1.toString();
                    });
                  },
                  child: Material(
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'lib/assets/scan2.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 3,
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
                child: CustomDropdown<ProductModel>.search(
                  hintText: 'Select Product',
                  initialItem: widget.sales == null
                      ? null
                      : products.firstWhere((element) =>
                          state.selectedProducts[i].name == element.name),
                  items: products.isNotEmpty
                      ? products
                      : [
                          ProductModel(
                              name: 'No Customers Added',
                              code: '',
                              stock: '',
                              price: '',
                              date: '',
                              category: ''),
                        ],
                  // key: GlobalKey(),
                  excludeSelected: false,
                  onChanged: (ProductModel? value) {
                    if (value != null) {
                      double price1 = double.parse(value.price);

                      state.selectedProducts[i] = ProductSale(
                          name: value.name, nos: '1', total: value.price);

                      state.nosControllers[i].text = '1';

                      int nos1 = int.parse(state.nosControllers[i].text);
                      state.totalControllers[i].text =
                          (nos1 * price1).toString();
                      if (state.nosControllers[i].text.isNotEmpty) {
                        int quantity = int.parse(state.nosControllers[i].text);
                        int availableStock = int.parse(value
                            .stock); // Access stock from the selected product
                        if (quantity > availableStock) {
                          // Show a snackbar with the error message
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('No stock available'),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }
                      state.updateGrandTotal();
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 1,
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
                  controller: state.nosControllers[i],
                  decoration: InputDecoration(
                    hintText: "Nos",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
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
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    //  final ProductModel? selectedProduct = state. selectedProducts[i];
                    if (value.isEmpty) return;
                    int nos1 = int.parse(state.nosControllers[i].text);
                    final double price1 =
                        double.parse(state.selectedProducts[i].total);
                    final double newTotalPrice = price1 * nos1;
                    state.totalControllers[i].text = newTotalPrice.toString();

                    //  widget.getNos(i, nos1);
                    //  widget.getTotal(i, newTotalPrice);
                    state.updateGrandTotal();
                    // widget.getGrandTotal(grandTotal);
                  },
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 1,
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
                  controller: state.totalControllers[i],
                  decoration: InputDecoration(
                    hintText: "Total",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
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
                  keyboardType: TextInputType.none,
                  onChanged: (_) => state.updateGrandTotal(),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              flex: 0,
              child: GestureDetector(
                onTap: () {
                  state.addRow();
                },
                child: Material(
                  color: const Color(0xFF4B4B87),
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'lib/assets/plus5.png',
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 0,
              child: GestureDetector(
                onTap: () {
                  state.removeRow(i);
                  state.updateGrandTotal();
                },
                child: Material(
                  color: const Color(0xFF4B4B87),
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'lib/assets/minus.png',
                      width: 10,
                      height: 10,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10), // Add gap between rows
      ],
    );
  }

  void filterProducts(String value) {
    if (value.isEmpty) {
      // If search text is empty, restore all products
      _productpageController.productListNotifier.value = products;
      return;
    }

    // Check if the scanned result matches any product code
    ProductModel? scannedProduct;
    if (value.isNotEmpty) {
      scannedProduct = products.firstWhereOrNull(
        (product) => product.code == value,
      );
    }

    // Update the ValueListenable with the scanned product or filtered products
    _productpageController.productListNotifier.value = scannedProduct != null
        ? [scannedProduct]
        : products
            .where((product) =>
                product.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
  }
}

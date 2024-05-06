import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/list_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';

class AddSales1 extends StatefulWidget {
  final SalesModel? sales;

  const AddSales1({Key? key, this.sales}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddSalesState1 createState() => _AddSalesState1();
}

class _AddSalesState1 extends State<AddSales1> {
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _grandTotalController = TextEditingController();

  double grandTotal = 0;

  final List<ProductModel> products = [];
  final List<TextEditingController> nosControllers = [];
  final List<TextEditingController> totalControllers = [];
  final List<ProductModel?> selectedProducts = [];
  final TextEditingController grandTotalController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.sales != null) {
      _customerController.text = widget.sales!.customer;
      // selectedProducts.addAll(widget.sales!.products);
      _grandTotalController.text = widget.sales!.grand;
    }

    loadProducts();
    addRow();
  }

  Future<void> loadProducts() async {
    final productBox = await Hive.openBox<ProductModel>('product_db2');
    setState(() {
      products.addAll(productBox.values);
    });
  }

  void addRow() {
    final newNosController = TextEditingController();
    final newTotalController = TextEditingController();
    setState(() {
      nosControllers.add(newNosController);
      totalControllers.add(newTotalController);
      selectedProducts.add(null);
      newTotalController.addListener(updateGrandTotal);
    });
  }

  void removeRow(int index) {
    if (index == 0) {
      nosControllers[index].clear();
      totalControllers[index].clear();
      selectedProducts[index] = null;
    } else {
      nosControllers.removeAt(index);
      totalControllers[index].removeListener(updateGrandTotal);
      totalControllers.removeAt(index);
      selectedProducts.removeAt(index);
    }
    updateGrandTotal();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<CustomerModel>('customer_db'),
      builder: (context, AsyncSnapshot<Box<CustomerModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final customerBox = snapshot.data!;
          final customers = customerBox.values.toList();

          return FutureBuilder(
            future: Hive.openBox<ProductModel>('product_db2'),
            builder: (context, AsyncSnapshot<Box<ProductModel>> snapshot1) {
              if (snapshot1.connectionState == ConnectionState.done) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    title: const Text(
                      'Create Sales',
                      style: TextStyle(
                        color: Color(0xff4B4B87),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListSales(),
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
                  body: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        const Text(
                          'Select Customer',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
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
                          child: DropdownButtonFormField<CustomerModel>(
                            items: customers.map((customer) {
                              return DropdownMenuItem<CustomerModel>(
                                value: customer,
                                child: Text(customer.name),
                              );
                            }).toList(),
                            onChanged: (CustomerModel? value) {
                              _customerController.text = value!.name;
                            },
                            decoration: InputDecoration(
                              hintText: "Select Customer",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w400,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
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
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text(
                            'OR',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        const Text(
                          'Products',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            for (int i = 0; i < nosControllers.length; i++)
                              productIncrement(i),
                            const SizedBox(height: 10),
                            buildGrandTotalField(),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              //  await createSales(
                              //  _customerController.text,
                              // selectedProducts,
                              //   grandTotalController.text);

                              // ignore: use_build_context_synchronously
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ListSales(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4B4B87),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 12),
                            ),
                            child: Text(
                              widget.sales != null ? 'Update' : 'Create',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildGrandTotalField() {
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
            controller: grandTotalController,
            enabled: false,
            decoration: InputDecoration(
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
          ),
        ),
      ],
    );
  }

  Widget productIncrement(int index) {
    return Row(
      children: [
        Expanded(
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
            child: DropdownButtonFormField<ProductModel>(
              items: products.map((product) {
                return DropdownMenuItem<ProductModel>(
                  value: product,
                  child: Text(product.name),
                );
              }).toList(),
              onChanged: (ProductModel? value) {
                setState(() {
                  selectedProducts[index] = value;
                  nosControllers[index].text = '1';
                });
              },
              decoration: InputDecoration(
                hintText: "Select Product",
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
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
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
              controller: nosControllers[index],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Nos",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                updateTotal(index);
              },
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
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
              controller: totalControllers[index],
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Total",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        IconButton(
          icon:const Icon(Icons.remove_circle),
          onPressed: () {
            removeRow(index);
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  void updateTotal(int index) {
    if (selectedProducts[index] != null &&
        nosControllers[index].text.isNotEmpty) {
      final int nos = int.parse(nosControllers[index].text);
      final double total = nos * double.parse(selectedProducts[index]!.price);
      totalControllers[index].text = total.toStringAsFixed(2);
      updateGrandTotal();
    }
  }

  void updateGrandTotal() {
    double total = 0;
    for (int i = 0; i < totalControllers.length; i++) {
      if (totalControllers[i].text.isNotEmpty) {
        total += double.parse(totalControllers[i].text);
      }
    }
    grandTotalController.text = total.toStringAsFixed(2);
  }
}

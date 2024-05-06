import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_controller.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/homepage/hive_services.dart';
import 'package:project_fourth/screens/widgets/sales_module/list_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_update_dynamicwidget.dart';
import 'package:provider/provider.dart';

class UpdateSales extends StatefulWidget {
  final SalesModel? sales;

  const UpdateSales({Key? key, this.sales}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdateSalesState createState() => _UpdateSalesState();
}

class _UpdateSalesState extends State<UpdateSales> {
   final HiveServices _hiveController = HiveServices();

  final CustomerController _customerdataController = CustomerController();
  final TextEditingController _customerController = TextEditingController();
  List<CustomerModel> customers = [];

  @override
  void initState() {
    super.initState();
    _customerdataController.getAllCustomers();
    if (widget.sales != null) {
      _customerController.text = widget.sales!.customer;
    }
  }

  @override
  Widget build(BuildContext context) {
    final salesState = Provider.of<SalesControllerState>(context);
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
              MaterialPageRoute(builder: (context) => const ListSales()),
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
                value: customers.isNotEmpty &&
                        _customerController.text.isNotEmpty
                    ? customers.firstWhere(
                        (customer) => customer.name == _customerController.text)
                    : null,
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
            const SizedBox(height: 20),
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
            const UpdateSalesDynamic(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool canCreateSale = true;
                  for (int i = 0; i < salesState.selectedProducts.length; i++) {
                    final selectedProduct = salesState.selectedProducts[i];
                    final quantity = int.parse(selectedProduct.nos);
                    final products =
                        await _hiveController.hiveProducts(); // Using the hiveProducts function

                    final product = products.firstWhere(
                      (product) => product.name == selectedProduct.name,
                    );
                    // ignore: unnecessary_null_comparison
                    if (product == null) {
                      canCreateSale = false;
                      break;
                    }
                    final availableStock = int.parse(product.stock);
                    if (quantity > availableStock) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No stock available for some products'),
                        backgroundColor: Colors.red,
                      ));
                      canCreateSale = false;
                      break;
                    }
                    if (quantity == 0) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Remove products with zero stock'),
                        backgroundColor: Colors.red,
                      ));
                      canCreateSale = false;
                      break;
                    }
                  }

                  if (canCreateSale) {
                    await salesState.createSales(_customerController.text);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Sale created successfully!'),
                      backgroundColor: Colors.green,
                    ));
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListSales()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B4B87),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
}

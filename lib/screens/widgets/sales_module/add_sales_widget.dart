import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_controller.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/homepage/count_provider.dart';
import 'package:project_fourth/screens/widgets/homepage/hive_services.dart';
import 'package:project_fourth/screens/widgets/sales_module/list_sales_widget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_create_dynamicwidget.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';
import 'package:provider/provider.dart';

class AddSales extends StatefulWidget {
  final SalesModel? sales;

  const AddSales({Key? key, this.sales}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddSalesState createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  final HiveServices _hiveController = HiveServices();
  final CustomerController _customerdataController = CustomerController();
  TextEditingController _customerController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  // double grandTo tal = 0;

  @override
  void initState() {
    super.initState();
    // Provider.of<SalesControllerState>(context, listen: false).addRow();
    if (widget.sales != null) {
      _customerController = TextEditingController(text: widget.sales!.customer);

      // selectedProducts.addAll(widget.sales!.products);
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
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const ListSales()));
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
              child: CustomDropdown<CustomerModel>.search(
                hintText: 'Select Customer',
                //items: salesState.customers,
                items: salesState.customers.isNotEmpty
                    ? salesState.customers
                    : [
                        CustomerModel(
                            name: 'No Customers Added', phone: '', address: ''),
                      ],

                excludeSelected: false,
                initialItem: widget.sales == null
                    ? null
                    : salesState.customers.firstWhere(
                        (element) => element.name == widget.sales!.customer),
                onChanged: (CustomerModel? value) {
                  _customerController.text = value!.name;
                  // Do something with the selected customer
                  // ignore: avoid_print
                  print('Selected customer: ${value.name}');
                },
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'Or you can create a New Customer ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Customer Name',
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
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Enter Customer Name",
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
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Customer Phone',
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
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      hintText: "Enter Customer Phone",
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
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Customer Address',
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
                  child: TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      hintText: "Enter Address",
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
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
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
            AddSalesDynamic(
              //key: UniqueKey(),
              sales: widget.sales,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  bool canCreateSale = true;
                  String customerName = _customerController.text.trim();
                  // If no customer selected from dropdown, use information from text fields
                  if (customerName.isEmpty) {
                    // Use information from text fields
                    String name = _nameController.text.trim();
                    String phone = _phoneController.text.trim();
                    String address = _addressController.text.trim();
                    // Validate if any of the fields are empty
                    if (name.isEmpty || phone.isEmpty || address.isEmpty) {
                      // Show a snackbar indicating required fields are empty
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please fill all the fields'),
                        backgroundColor: Colors.red,
                      ));
                      return; // Exit onPressed method
                    }
                    // Create a new CustomerModel object with the provided information
                    CustomerModel newCustomer = CustomerModel(
                        name: name, phone: phone, address: address);

                    // Save the new customer to Hive
                    await _customerdataController.addCustomers(newCustomer);

                    // Use the name of the newly created customer for the sale
                    customerName = name;
                  }
                  for (int i = 0; i < salesState.selectedProducts.length; i++) {
                    final selectedProduct = salesState.selectedProducts[i];
                    final quantity = int.parse(selectedProduct.nos);
                    final products = await _hiveController
                        .hiveProducts(); // Using the hiveProducts function

                    final product = products.firstWhere(
                      (product) => product.name == selectedProduct.name,
                      //orElse: () => null,
                    );
                    // ignore: unnecessary_null_comparison
                    if (product == null) {
                      // Product not found in the database
                      canCreateSale = false;
                      break;
                    }
                    final availableStock = int.parse(product.stock);
                    if (quantity > availableStock) {
                      // Show a snackbar with the error message
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No stock available for some products'),
                        backgroundColor: Colors.red,
                      ));
                      canCreateSale = false;
                      break; // Exit loop if any product has insufficient stock
                    }
                    if (quantity == 0) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Remove products with zero stock'),
                        backgroundColor: Colors.red,
                      ));
                      canCreateSale = false;
                      break; // Exit loop if any product has zero stock
                    }
                  }

                  if (widget.sales == null) {
                    if (canCreateSale) {
                      if (_customerController.text.isEmpty) {
                        await salesState.createSales(customerName);
                      } else {
                        await salesState.createSales(_customerController.text);
                      }
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
                  } else {
                    if (canCreateSale) {
                      if (_customerController.text.isEmpty) {
                        await salesState.updateSale(
                            widget.sales!, customerName);
                      } else {
                        await salesState.updateSale(
                            widget.sales!, _customerController.text);
                      }
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Sale updated successfully!'),
                        backgroundColor: Colors.green,
                      ));
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListSales()),
                      );
                    }
                  }
                  // ignore: use_build_context_synchronously
                  Provider.of<CountProvider>(context, listen: false).loadCounts();
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

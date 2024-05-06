import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_controller.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/count_provider.dart';
import 'package:provider/provider.dart';

class AddCustomer extends StatefulWidget {
  final CustomerModel? customer;

  const AddCustomer({Key? key, this.customer}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final CustomerController _customerController = CustomerController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.customer != null) {
      _nameController.text = widget.customer!.name;
      _phoneController.text = widget.customer!.phone;
      _addressController.text = widget.customer!.address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Create Customer',
          style: TextStyle(
            color: Color(0xff4B4B87),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Column(
            children: [
              Container(
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
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
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
                  hintText: "Enter Name",
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
                  hintText: "Enter Phone Number",
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
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (widget.customer != null) {
                    widget.customer!.name = _nameController.text;
                    widget.customer!.phone = _phoneController.text;
                    widget.customer!.address = _addressController.text;
                    await _customerController.updateCustomers(widget.customer!);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Customer data updated successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  } else {
                    Provider.of<CountProvider>(context, listen: false);
                    CustomerModel customer1 = CustomerModel(
                        name: _nameController.text,
                        phone: _phoneController.text,
                        address: _addressController.text);
                    await _customerController.addCustomers(customer1);

                    if (context.mounted) {
                      Provider.of<CountProvider>(context, listen: false)
                          .loadCounts();
                    }

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Customer created successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) =>
                          const BottomNavigation(initialIndex: 1),
                    ),
                  );
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
                  widget.customer != null ? 'Update' : 'Create',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

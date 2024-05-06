import 'dart:io';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/count_provider.dart';
import 'package:project_fourth/screens/widgets/product_module/product_controller.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateProducts extends StatefulWidget {
  final ProductModel? product;

  const UpdateProducts({Key? key, this.product}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UpdateproductsState createState() => _UpdateproductsState();
}

class _UpdateproductsState extends State<UpdateProducts> {
  final ProductPageController _productpageController = ProductPageController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        // ignore: avoid_print
        print('No image selected.');
      }
    });
  }

  Future<String> _saveImage(File image) async {
    final appDir = await getApplicationDocumentsDirectory();
    final imageName = path.basename(image.path);
    final savedImage = await image.copy('${appDir.path}/$imageName');
    return savedImage.path;
  }

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _categoryController.text = widget.product!.category;
      _nameController.text = widget.product!.name;
      _codeController.text = widget.product!.code;
      _priceController.text = widget.product!.price;
      _stockController.text = widget.product!.stock;
      _expiryDateController.text = widget.product!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Hive.openBox<CategoryModel>('product_db'),
      builder: (context, AsyncSnapshot<Box<CategoryModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final categoryBox = snapshot.data!;
          final categories = categoryBox.values.toList();

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Create Products',
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
                          builder: (context) =>
                              const BottomNavigation(initialIndex: 3)));
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
                    'Select Category',
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
                    child: CustomDropdown<CategoryModel>.search(
                      hintText: 'Select Categories',
                      items: categories,
                      initialItem: widget.product != null
                         ? categories.firstWhere((category) =>
                             category.name == widget.product!.category)
                         : null,
                      excludeSelected: false,
                      onChanged: (CategoryModel? value) {
                        _categoryController.text = value!.name;
                        // Do something with the selected category
                        // ignore: avoid_print
                        print('Selected category: ${value.name}');
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Product Name',
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
                        hintText: "Enter Product Name",
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
                    'Product Code',
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
                      controller: _codeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Enter Product Code",
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
                      keyboardType: TextInputType.none,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Product Stock',
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
                      controller: _stockController,
                      decoration: InputDecoration(
                        hintText: "Enter Product Stock",
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Product Price',
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
                      controller: _priceController,
                      decoration: InputDecoration(
                        hintText: "Enter Product Price",
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
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Product Expiry Date',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      _selectExpiryDate(context);
                    },
                    child: AbsorbPointer(
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
                          controller: _expiryDateController,
                          decoration: InputDecoration(
                            hintText: "Enter Expiry Date",
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
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                    ),
                  ),
                  //Image Capture button
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _getImage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.file_upload_outlined),
                    label: const Text('Upload Image'),
                  ),
                  if (_image != null) ...[
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.file(_image!),
                    ),
                  ],
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        String? imagePath;
                        if (_image != null) {
                          imagePath = await _saveImage(_image!);
                        }

                        if (widget.product != null) {
                          widget.product!.category = _categoryController.text;
                          widget.product!.name = _nameController.text;
                          widget.product!.code = _codeController.text;
                          widget.product!.price = _priceController.text;
                          widget.product!.stock = _stockController.text;
                          widget.product!.date = _expiryDateController.text;
                          widget.product!.image = imagePath;
                          await _productpageController.updateProducts(widget.product!);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product updated successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ProductModel product = ProductModel(
                            category: _categoryController.text,
                            name: _nameController.text,
                            code: _codeController.text,
                            price: _priceController.text,
                            stock: _stockController.text,
                            date: _expiryDateController.text,
                            image: imagePath,
                          );
                          await _productpageController.addProducts(product);
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product created successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }

                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BottomNavigation(initialIndex: 3)),
                        );
                        // ignore: use_build_context_synchronously
                        Provider.of<CountProvider>(context, listen: false).loadCounts();
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
                        widget.product != null ? 'Update' : 'Create',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Future<void> _selectExpiryDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 50),
      initialDatePickerMode: DatePickerMode.day,
    );
    if (picked != null) {
      setState(() {
        final formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        _expiryDateController.text = formattedDate;
      });
    }
  }
}

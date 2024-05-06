import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/homepage/home_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';
import 'package:uuid/uuid.dart';

class SalesControllerState extends ChangeNotifier {
  final SalesController _salesController = SalesController();
  final List<TextEditingController> _nosControllers = [];

  List<TextEditingController> get nosControllers => _nosControllers;

  set addnosControllers(TextEditingController value) {
    _nosControllers.add(value);
  }

  final List<TextEditingController> _totalControllers = [];
  TextEditingController grandTotalController = TextEditingController();
  List<TextEditingController> get totalControllers => _totalControllers;

  set addtotalControllers(TextEditingController value) {
    _totalControllers.add(value);
  }

  final List<ProductSale> _selectedProducts = [];

  List<ProductSale> get selectedProducts => _selectedProducts;

  set addSelectedProducts(ProductSale value) {
    _selectedProducts.add(value);
    notifyListeners();
    //  notifyListeners();
  }

  void addRow() {
    addSelectedProducts = (ProductSale(name: '', nos: '', total: ''));
    addtotalControllers = TextEditingController();
    addnosControllers = TextEditingController();
    notifyListeners();
  }

  void removeRow(int index) {
    // if (index == 0) {
    //   // Clear text fields instead of removing controllers
    nosControllers.removeAt(index);
    totalControllers.removeAt(index);
    _selectedProducts.removeAt(index);
    notifyListeners();
    // } else {
    //   // Remove controllers from lists
    //   nosControllers.removeAt(index);
    //   totalControllers[index].removeListener(updateGrandTotal);
    //   totalControllers.removeAt(index);
    //   // selectedProducts1.removeAt(index);
    // }
    // updateGrandTotal();
  }

  void updateGrandTotal() {
    double total = 0;
    for (int i = 0; i < _selectedProducts.length; i++) {
      if (totalControllers[i].text.isNotEmpty) {
        total += (double.parse(_selectedProducts[i].total) *
            int.parse(nosControllers[i].text.trim()));
      }
    }

    grandTotalController =
        TextEditingController(text: total.toStringAsFixed(2));

    //print(grandTotalController.text);
    notifyListeners();
  }

  void editClickBinding(SalesModel editData) {
    selectedProducts.clear();
    nosControllers.clear();
    totalControllers.clear();

    getCustomers();
    grandTotalController = TextEditingController(text: editData.grand);
    for (var i in editData.products) {
      addSelectedProducts = (i);
      addtotalControllers = TextEditingController(text: i.total);
      addnosControllers = TextEditingController(text: i.nos);
    }
  }

  Future<void> updateSale(SalesModel item, String customerName) async {
    try {
      var box1 = await Hive.openBox<SalesModel>('sales_db');
      int index = box1.values.toList().indexWhere((cat) => cat.id == item.id);
      if (index != -1) {
        final sales = SalesModel(
          customer: customerName,
          products: selectedProducts,
          grand: grandTotalController.text.trim(),
          id: item.id,
        );

        box1.putAt(index, sales);
      } else {
        throw 'sales not found';
      } // Notify listeners after updating
    } catch (error) {
      // ignore: avoid_print
      print('Failed to update sales: $error');
      throw 'Failed to update sales: $error';
    }
  }

//Creating sale entry function

  Future<void> createSales(String customerName) async {
    try {
      final salesBox = await Hive.openBox<SalesModel>('sales_db');
      const uuid = Uuid();
      final uuidString = uuid.v4(); // Generate UUID as a string
      final id = uuidString.hashCode.abs(); // Convert UUID string to integer

      final List<ProductSale> saleProducts = [];

      for (var item in selectedProducts) {
        saleProducts.add(item);
      }

      final sales = SalesModel(
        customer: customerName,
        products: saleProducts,
        grand: grandTotalController.text.trim(),
        createddate: DateTime.now(),
        id: id,
      );

      // Add the sale to sales_db
      await salesBox.add(sales).then((value) async {
        // Get all products from product_db2
        //initializeHive();
        await Hive.openBox<ProductModel>('product_db2');
        final productBox = Hive.box<ProductModel>('product_db2');
        // Iterate through each selected product in the sale
        for (var productSale in selectedProducts) {
          // Find the corresponding product in product_db2 by its code
          final index = productBox.values
              .toList()
              .indexWhere((product) => product.name == productSale.name);
          if (index != -1) {
            // Get the product from product_db2
            final productToUpdate = productBox.getAt(index);
            // Update the stock of the product
            final int updatedStock =
                int.parse(productToUpdate!.stock) - int.parse(productSale.nos);
            productToUpdate.stock = updatedStock.toString();
            // Update the product in product_db2
            productBox.putAt(index, productToUpdate);
          }
        }
        // Save data to SalesGraphModel
        final graphBox = await Hive.openBox<SalesGraphModel>('graph_db');
        final existingCustomerIndex = graphBox.values
            .toList()
            .indexWhere((graph) => graph.customerName == customerName);
        if (existingCustomerIndex != -1) {
          // If customerName already exists, update the it
          final existingGraph = graphBox.getAt(existingCustomerIndex);
          final double currentSalesValue =
              double.parse(existingGraph!.salesValue);
          final double newSalesValue =
              double.parse(grandTotalController.text.trim());
          existingGraph.salesValue =
              (currentSalesValue + newSalesValue).toString();
          graphBox.putAt(existingCustomerIndex, existingGraph);
        } else {
          // If customerName doesn't exist, add it as a new
          final salesGraph = SalesGraphModel(
            customerName: customerName,
            salesValue: grandTotalController.text.trim(),
          );
          await graphBox.add(salesGraph);
        }
      });

      // Get all sales after adding the new sale
      _salesController.initializeHiveSales();
      grandTotalController.clear();
      selectedProducts.clear();
      nosControllers.clear();
      totalControllers.clear();
      addRow();
      getCustomers();
    } catch (error) {
      log(error.toString());
    }
  }

  deleteSale(int index) async {
    final box1 = await Hive.openBox<SalesModel>('sales_db');

    box1.deleteAt(index);
    _salesController.initializeHiveSales();
  }

  //////////////////////////////////////////////////////////////
  // customer list

  final List<CustomerModel> _customers = [];

  //////////////////////////////////////////////////////////////
  List<CustomerModel> get customers => _customers;

  set addCustomers(CustomerModel value) {
    _customers.add(value);
    notifyListeners();
  }

  void getCustomers() async {
    final box1 = await Hive.openBox<CustomerModel>('customer_db');
    _customers.clear();

    for (var element in box1.values) {
      addCustomers = (element);
    }
  }
}

Future<double> calculateTotalGrandHive() async {
  final box = await Hive.openBox<SalesModel>('sales_db');
  double totalGrand = 0;

  try {
    for (int i = 0; i < box.length; i++) {
      final salesModel = box.getAt(i);
      totalGrand += double.parse(salesModel?.grand ?? '0');
    }
    // ignore: avoid_print
    print('Total grand value: $totalGrand');
  } catch (e) {
    // ignore: avoid_print
    print('Error calculating total grand: $e');
  }

  return totalGrand;
}

// Method to calculate total sales for the selected time frame

Future<double> calculateTotalSales2(String selectedTimeFrame) async {
  final salesBox = await Hive.openBox<SalesModel>('sales_db');
  double totalSales = 0;

  final now = DateTime.now();
  final beginningOfWeek = now
      .subtract(Duration(days: now.weekday - 1)); // Monday of the current week
  final beginningOfMonth =
      DateTime(now.year, now.month, 1); // First day of the current month

  // Filter sales data based on the selected time frame
  final filteredSales = salesBox.values.where((sale) {
    if (selectedTimeFrame == 'This Week') {
      return sale.createddate!.isAfter(beginningOfWeek);
    } else if (selectedTimeFrame == 'This Month') {
      return sale.createddate!.isAfter(beginningOfMonth);
    }
    return true; // Return true for all other cases
  }).toList();

  // Calculate total sales for the filtered sales data
  for (final sale in filteredSales) {
    totalSales += double.parse(sale.grand);
  }

  return totalSales;
}

class ProductController {
  static Future<Box<ProductModel>> openProductDatabase() async {
    return await Hive.openBox<ProductModel>('product_db2');
  }
}

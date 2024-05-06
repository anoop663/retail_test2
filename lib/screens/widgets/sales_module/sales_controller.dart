import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';

//import 'package:uuid/uuid.dart';
class SalesController {
  ValueNotifier<List<SalesModel>> salesListNotifier = ValueNotifier([]);
//final List<ProductSale> selectedProducts = [];

  Future<void> getAllSales() async {
    final box1 = await Hive.openBox<SalesModel>('sales_db');
    salesListNotifier.value.clear();
    salesListNotifier.value.addAll(box1.values);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    salesListNotifier.notifyListeners();
    // ignore: avoid_print
    print('All Categories are listed');
  }

// Function to update a sales in Hive
  Future<void> updateSales(SalesModel updatedSales) async {
    try {
      var box1 = await Hive.openBox<SalesModel>('sales_db');

      int index =
          box1.values.toList().indexWhere((cat) => cat.id == updatedSales.id);
      if (index != -1) {
        box1.putAt(index, updatedSales);
      } else {
        throw 'Product not found';
      } // Notify listeners after updating
    } catch (error) {
      // ignore: avoid_print
      print('Failed to update product: $error');
      throw 'Failed to update product: $error';
    }
    getAllSales();
  }

  Future<void> deleteSales1(int id) async {
    try {
      final box1 = await Hive.openBox<SalesModel>('sales_db');
      // Iterate through the box and delete entries with matching ID
      final keys = box1.keys.toList();
      for (var key in keys) {
        final sale = box1.get(key);
        if (sale != null && sale.id == id) {
          await box1.delete(key);
        }
      }
      salesListNotifier.value.clear();
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting customers: $e');
    }
    await getAllSales();
  }

  Future<void> initializeHiveSales() async {
    await Hive.openBox<SalesModel>('sales_db');
    getAllSales(); // Fetch products from Hive
  }

// Future<void> createSales(
//     String customerName, List<ProductSale> products, String grandTotal) async {
//   try {
//     final salesBox = await Hive.openBox<SalesModel>('sales_db');
//     const uuid = Uuid();
//     final uuidString = uuid.v4(); // Generate UUID as a string
//     final id = uuidString.hashCode.abs(); // Convert UUID string to integer
//     final sales = SalesModel(
//       customer: customerName,
//       products: products,
//       grand: grandTotal,
//       id: id,
//     );
//     await salesBox.add(sales);

//     getAllSales();
//   } catch (error) {
//     // Handle error
//   }
// }

  Future<void> deleteSales(int id) async {
    try {
      final box1 = await Hive.openBox<SalesModel>('sales_db');

      // Iterate through the box and delete entries with matching ID
      final keys = box1.keys.toList();
      for (var key in keys) {
        final sale = box1.get(key);
        if (sale != null && sale.id == id) {
          // Delete the sales entry
          await box1.delete(key);

          // Delete associated ProductSale entries
          for (var productSale in sale.products) {
            final productBox = await Hive.openBox<ProductSale>('sales_db');
            final productKeys = productBox.keys.toList();
            for (var productKey in productKeys) {
              final product = productBox.get(productKey);
              if (product != null && product.name == productSale.name) {
                await productBox.delete(productKey);
              }
            }
          }
        }
      }
      salesListNotifier.value.clear();
    } catch (e) {
      // Handle error
      // ignore: avoid_print
      print('Error deleting sales: $e');
    }
    await getAllSales();
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:uuid/uuid.dart';
  
class CustomerController {
//CAtegory Controllers are given below
  ValueNotifier<List<CustomerModel>> customerListNotifier = ValueNotifier([]);

  Future<void> getAllCustomers() async {
    final box1 = await Hive.openBox<CustomerModel>('customer_db');
    customerListNotifier.value.clear();
    customerListNotifier.value.addAll(box1.values);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    customerListNotifier.notifyListeners();
    // ignore: avoid_print
    print('All Categories are listed');
  }

// Function to delete a category in Hive

// Function to update a category in Hive
  Future<void> updateCustomers(CustomerModel updatedCategory) async {
    try {
      var box1 = await Hive.openBox<CustomerModel>('customer_db');
      int index = box1.values
          .toList()
          .indexWhere((cat) => cat.id == updatedCategory.id);
      if (index != -1) {
        box1.putAt(index, updatedCategory);
      } else {
        throw 'Category not found';
      } // Notify listeners after updating
    } catch (error) {
      // ignore: avoid_print
      print('Failed to update category: $error');
      throw 'Failed to update category: $error';
    }
    getAllCustomers();
  }

//Future<void> addCategory(CategoryModel categories) async {
//  final box1 = await Hive.openBox<CategoryModel>('product_db');
//  await box1.add(categories);
//  getAllCategories();
//}

  Future<void> addCustomers(CustomerModel category) async {
    final box1 = await Hive.openBox<CustomerModel>('customer_db');
    const uuid = Uuid();
    final uuidString = uuid.v4(); // Generate UUID as a string
    final id = uuidString.hashCode.abs(); // Convert UUID string to integer
    category.id = id;
    await box1.add(category);

    getAllCustomers();
  }

  Future<void> deleteCustomers(int id) async {
    try {
      final box1 = await Hive.openBox<CustomerModel>('customer_db');
      // Iterate through the box and delete entries with matching ID
      final keys = box1.keys.toList();
      for (var key in keys) {
        final customer = box1.get(key);
        if (customer != null && customer.id == id) {
          await box1.delete(key);
        }
      }
      customerListNotifier.value.clear();
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting customers: $e');
    }
    await getAllCustomers();
  }
}

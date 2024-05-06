import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:uuid/uuid.dart';

class CategoryPageController {
//Category Controllers are given below

  ValueNotifier<List<CategoryModel>> categoryListNotifier = ValueNotifier([]);

  Future<void> getAllCategories() async {
    final box1 = await Hive.openBox<CategoryModel>('product_db');
    categoryListNotifier.value.clear();
    categoryListNotifier.value.addAll(box1.values);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    categoryListNotifier.notifyListeners();
    // ignore: avoid_print
    print('All Categories are listed');
  }

// Function to update a category in Hive
  Future<void> updateCategory(CategoryModel updatedCategory) async {
    try {
      var box1 = await Hive.openBox<CategoryModel>('product_db');
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
    getAllCategories();
  }

  Future<void> addCategory(CategoryModel category) async {
    final box1 = await Hive.openBox<CategoryModel>('product_db');
    const uuid = Uuid();
    final uuidString = uuid.v4(); // Generate UUID as a string
    final id = uuidString.hashCode.abs(); // Convert UUID string to integer
    category.id = id;
    await box1.add(category);

    getAllCategories();
  }

  Future<void> deleteCategory(int id) async {
    try {
      final box1 = await Hive.openBox<CategoryModel>('product_db');
      // Iterate through the box and delete entries with matching ID
      final keys = box1.keys.toList();
      for (var key in keys) {
        final category = box1.get(key);
        if (category != null && category.id == id) {
          await box1.delete(key);
        }
      }
      categoryListNotifier.value.clear();
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting customers: $e');
    }
    await getAllCategories();
  }
}

//////////////////////////////////////////
// Product Controllers are given below //
//////////////////////////////////////////
class ProductPageController {
  ValueNotifier<List<ProductModel>> productListNotifier = ValueNotifier([]);

  Future<void> getAllProducts() async {
    final box1 = await Hive.openBox<ProductModel>('product_db2');
    productListNotifier.value.clear();
    productListNotifier.value.addAll(box1.values);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    productListNotifier.notifyListeners();
    // ignore: avoid_print
    print('All Categories are listed');
  }

// Function to update a category in Hive
  Future<void> updateProducts(ProductModel updatedProduct) async {
    try {
      var box1 = await Hive.openBox<ProductModel>('product_db2');
      int index =
          box1.values.toList().indexWhere((cat) => cat.id == updatedProduct.id);
      if (index != -1) {
        box1.putAt(index, updatedProduct);
      } else {
        throw 'Product not found';
      } // Notify listeners after updating
    } catch (error) {
      // ignore: avoid_print
      print('Failed to update product: $error');
      throw 'Failed to update product: $error';
    }
    getAllProducts();
  }

  Future<void> addProducts(ProductModel product) async {
    final box1 = await Hive.openBox<ProductModel>('product_db2');
    const uuid = Uuid();
    final uuidString = uuid.v4(); // Generate UUID as a string
    final id = uuidString.hashCode.abs(); // Convert UUID string to integer
    product.id = id;
    product.code = id.toString();
    await box1.add(product);
    getAllProducts();
  }

  Future<void> deleteProducts(int id) async {
    try {
      final box1 = await Hive.openBox<ProductModel>('product_db2');
      // Iterate through the box and delete entries with matching ID
      final keys = box1.keys.toList();
      for (var key in keys) {
        final product = box1.get(key);
        if (product != null && product.id == id) {
          await box1.delete(key);
        }
      }
      productListNotifier.value.clear();
    } catch (e) {
      // ignore: avoid_print
      print('Error deleting customers: $e');
    }
    await getAllProducts();
  }

  Future<void> initializeHive() async {
    await Hive.openBox<ProductModel>('product_db2');
    getAllProducts(); // Fetch products from Hive
  }


  Future<int> countProductsWithZeroStock() async {
  final box = await Hive.openBox<ProductModel>('product_db2');
  List<ProductModel> products =  box.values.toList();

  await box.close();
  int zeroStockCount = products.where((product) => product.stock == '0').length;
  return zeroStockCount;
}
}

class CategoryController {
  static Future<Box<CategoryModel>> openCategoryDatabase() async {
    return await Hive.openBox<CategoryModel>('product_db');
  }
}

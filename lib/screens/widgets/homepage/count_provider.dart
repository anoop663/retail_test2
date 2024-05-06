import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';

class CountProvider extends ChangeNotifier {
  //final ProductPageController _productPageController = ProductPageController();
  int _catCount = 0;
  int _proCount = 0;
  int _outCount1 = 0;
  int _custCount = 0;

  int get catCount => _catCount;
  int get proCount => _proCount;
  int get outCount => _outCount1;
  int get custCount => _custCount;

  // Method to load counts from shared preferences
  Future<void> loadCounts() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();

    final box1 = await Hive.openBox<ProductModel>('product_db2');
    final box2 = await Hive.openBox<CustomerModel>('customer_db');
    final box3 = await Hive.openBox<CategoryModel>('product_db');
    List<ProductModel> products = box1.values.toList();
     int zeroStockCount =
        products.where((product) => product.stock == '0').length;
        notifyListeners();

    _catCount = box3.length;
    _proCount = box1.length;
    notifyListeners();
    //_outCount1 = prefs.getInt('outCount') ?? 0;
    _outCount1 = zeroStockCount;

    _custCount = box2.length;
    notifyListeners();
  }
}

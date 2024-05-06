import 'package:hive/hive.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/homepage/home_model.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';

class HiveServices {
  Future<List<ProductModel>> hiveProducts() async {
    // Open the Hive box
    final box = await Hive.openBox<ProductModel>('product_db2');

    // Collect data from the box
    List<ProductModel> products = box.values.toList();

    // Close the box
    await box.close();

    // Return the collected products
    return products;
  }

  Future<List<SalesModel>> hiveSales() async {
    // Open the Hive box
    final box = await Hive.openBox<SalesModel>('sales_db');

    // Collect data from the box
    List<SalesModel> sales = box.values.toList();

    // Close the box
    await box.close();

    // Return the collected products
    return sales;
  }

  Future<List<CustomerModel>> hiveCustomers() async {
    // Open the Hive box
    final box = await Hive.openBox<CustomerModel>('customer_db');

    // Collect data from the box
    List<CustomerModel> customers = box.values.toList();

    // Close the box
    await box.close();

    // Return the collected products
    return customers;
  }

  Future<List<SalesGraphModel>> hiveSalesGraph() async {
    // Open the Hive box
    final box = await Hive.openBox<SalesGraphModel>('graph_db');

    // Collect data from the box
    List<SalesGraphModel> graph = box.values.toList();

    // Close the box
    await box.close();

    // Return the collected products
    return graph;
  }
}

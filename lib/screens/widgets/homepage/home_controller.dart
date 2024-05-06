import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';

class GraphData {
  Future<double> getTotalSalesForTimeFrame(String timeFrame) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    double totalSales = 0;
    final salesBox = await Hive.openBox<SalesModel>('sales_db');

    for (final sale in salesBox.values) {
      if (timeFrame == 'Today') {
        if (isSameDay(sale.createddate!, today)) {
          totalSales += double.parse(sale.grand);
        }
      } else if (timeFrame == 'Yesterday') {
        if (isSameDay(sale.createddate!, yesterday)) {
          totalSales += double.parse(sale.grand);
        }
      } else if (timeFrame == 'Total') {
        totalSales += double.parse(sale.grand);
      }
    }

    return totalSales;
  }

  // Function to check if two dates are on the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
  
}

import 'package:hive_flutter/hive_flutter.dart';
part 'sales_model.g.dart';

@HiveType(typeId: 9)
class SalesModel {
  @HiveField(0)
  late String customer;
  @HiveField(1)
  late List<ProductSale> products;
  @HiveField(2)
  late String grand;
  @HiveField(3)
  int? id;
  @HiveField(4)
  DateTime? createddate;

  SalesModel({
    required this.customer,
    required this.products,
    required this.grand,
    this.createddate,
    this.id,
  });
}

@HiveType(typeId: 10)
class ProductSale {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String nos;
  @HiveField(2)
  late String total;

  ProductSale({
    required this.name,
    required this.nos,
    required this.total,
  });
}

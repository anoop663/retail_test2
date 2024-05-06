import 'package:hive_flutter/hive_flutter.dart';
part 'product_model.g.dart';

@HiveType(typeId: 3)
class CategoryModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  int? id; 
  CategoryModel({
    required this.name,
    this.id,
  });
  @override
  String toString() {
    
    return name.toString();
  }

}

@HiveType(typeId: 5)
class ProductModel {
  @HiveField(0)
  late String category;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String code;
  @HiveField(3)
  late String price;
  @HiveField(4)
  late String stock;
  @HiveField(5)
  late String date;
  @HiveField(6)
  late String? image;
  @HiveField(7)
  int? id;

  ProductModel({
    required this.category,
    required this.name,
    required this.code,
    required this.stock,
    required this.price,
    required this.date,
    this.image,
    this.id,
  });
  @override
  String toString() {
    
    return name.toString();
  }
}

import 'package:hive_flutter/hive_flutter.dart';
part 'home_model.g.dart';

@HiveType(typeId: 15)
class SalesGraphModel {
  @HiveField(0)
  late String customerName;
  @HiveField(1)
  late String salesValue;
  @HiveField(2)
  int? id; 
  SalesGraphModel({
    required this.customerName,
    required this.salesValue,
    this.id,
  });
}
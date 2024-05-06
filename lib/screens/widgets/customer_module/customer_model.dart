import 'package:hive_flutter/hive_flutter.dart';
part 'customer_model.g.dart';

@HiveType(typeId: 7)
class CustomerModel {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String phone;
  @HiveField(2)
  late String address;
  @HiveField(3)
  int? id; // Change id to non-nullable int

  CustomerModel({
    required this.name,
    required this.phone,
    required this.address,
    this.id, // Update constructor to require id
  });

  @override
  String toString() {
    return name.toString();
  }
}

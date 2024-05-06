import 'package:hive_flutter/hive_flutter.dart';
part 'business_model.g.dart';

@HiveType(typeId: 2)
class RetailModel2 {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String phone;
  @HiveField(2)
  late String address;
  @HiveField(3)
  int? id;

  RetailModel2({
    required this.name,
    required this.phone,
    required this.address,
    this.id,
  });
}

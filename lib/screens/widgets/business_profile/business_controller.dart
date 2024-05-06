// business_controller.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_model.dart';
import 'package:uuid/uuid.dart';

class BusinussController {
  ValueNotifier<List<RetailModel2>> businessListNotifier = ValueNotifier([]);

  Future<void> getAllBusines() async {
    final retailDB = await Hive.openBox<RetailModel2>('retail_db');
    businessListNotifier.value.clear();
    businessListNotifier.value.addAll(retailDB.values);
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    businessListNotifier.notifyListeners();
    // ignore: avoid_print
    print('All Categories are listed');
  }

  Future<void> updateBusiness(RetailModel2 business) async {
    try {
      var retailDB1 = await Hive.openBox<RetailModel2>('retail_db');
      int index =
          retailDB1.values.toList().indexWhere((bus) => bus.id == business.id);
      if (index != -1) {
        retailDB1.putAt(index, business);
      } else {
        throw 'Category not found';
      } // Notify listeners after updating
    } catch (error) {
      debugPrint('Failed to update busniss data: $error');
      throw 'Failed to update busniss data: $error';
    }
    getAllBusines();
  }

  Future<void> addBusiness(RetailModel2 business) async {
    final retailDB = await Hive.openBox<RetailModel2>('retail_db');
    const uuid = Uuid();
    final uuidString = uuid.v4(); // Generate UUID as a string
    final id = uuidString.hashCode.abs(); // Convert UUID string to integer
    business.id = id;
    await retailDB.add(business);
    getAllBusines();
  }
}

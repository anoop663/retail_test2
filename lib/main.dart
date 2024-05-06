import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_fourth/screen_splash.dart';
import 'package:project_fourth/screens/widgets/homepage/home_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_controller_state.dart';
import 'package:provider/provider.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_model.dart';
import 'package:project_fourth/screens/widgets/customer_module/customer_model.dart';
import 'package:project_fourth/screens/widgets/homepage/count_provider.dart';
import 'package:project_fourth/screens/widgets/product_module/product_model.dart';
import 'package:project_fourth/screens/widgets/sales_module/sales_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RetailModel2Adapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(CustomerModelAdapter());
  Hive.registerAdapter(ProductSaleAdapter());
  Hive.registerAdapter(SalesModelAdapter());
  Hive.registerAdapter(SalesGraphModelAdapter());

  runApp(
    MyApp(),
  );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(
        //   create: (context) => CountProvider(),
        // ),
        ChangeNotifierProvider(create: (_) => CountProvider()),
        ChangeNotifierProvider(create: (_) => SalesControllerState()),
      ],

      // Provide CountProvider
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            // Define the default text styles using Montserrat font
            bodySmall: TextStyle(fontFamily: 'Montserrat'),
            bodyLarge: TextStyle(fontFamily: 'Montserrat'),
            bodyMedium: TextStyle(fontFamily: 'Montserrat'),
            // Add more text styles as needed
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

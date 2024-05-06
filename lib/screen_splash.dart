import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';
import 'package:project_fourth/screens/widgets/homepage/count_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countProvider = Provider.of<CountProvider>(context);
    Future.delayed(const Duration(seconds: 2), () {
      // var categories;
      countProvider.loadCounts();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const BottomNavigation(initialIndex: 0),
        ),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFFF6968),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                child: SizedBox(),
              ),
              Image.asset(
                'lib/assets/app_icon.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 16),
              const Text(
                'Retailer Helper App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Expanded(
                child: SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

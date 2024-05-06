import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/homepage/bottom_navigation_widget.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'About Us',
          style: TextStyle(
            color: Color(0xff4B4B87), // Adjusted text color for better visibility
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const BottomNavigation(initialIndex: 0),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('lib/assets/Back1.png'),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      body: const Padding(
        padding:  EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Retail Helper App',
                      style:  TextStyle(
                        color: Color(0xff4B4B87),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Phone: +911 12939 4992',
                      style:  TextStyle(
                        color: Color(0xff4B4B87),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Address: New York, US',
                      style:  TextStyle(
                        color: Color(0xff4B4B87),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

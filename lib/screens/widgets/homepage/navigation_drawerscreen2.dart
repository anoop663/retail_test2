import 'package:flutter/material.dart';
import 'package:project_fourth/screens/widgets/business_profile/aboutus_widget.dart';
import 'package:project_fourth/screens/widgets/business_profile/business_card.dart';
import 'package:project_fourth/screens/widgets/business_profile/privacy_widget.dart';
import 'package:project_fourth/screens/widgets/business_profile/terms_widget.dart';

class MyDrawer2 extends StatelessWidget {
  const MyDrawer2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF1F5F9),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );

  Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Businuess Profile'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const BusinessCard()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle_outlined),
            title: const Text('About Us'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const AboutUs()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.content_paste),
            title: const Text('Privacy'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Privacy()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.content_paste),
            title: const Text('Terms'),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Terms()));
            },
          ),
          ListTile(
            //leading: const Icon(Icons.content_paste),
            title: const Text('Version 1.0'),
            onTap: () {
              
            },
          )
        ],
      ));
}

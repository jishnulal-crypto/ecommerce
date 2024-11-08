import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/category_screen.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/contact_screen.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/login_screen.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/profile_screen.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/register_screen.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          // Drawer Header (optional)
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Navigation Drawer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          // ListTiles for navigation
          ListTile(
            title: Text('categories'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CategoriesScreen()),
              );
            },
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ContactScreen()),
                );
              },
              child: Text('contact us'))
        ],
      ),
    );
  }
}

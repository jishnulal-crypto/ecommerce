import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/category_screen.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/login_screen.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/screens/register_screen.dart';
import 'package:ecommerce_with_flutter_firebase_and_stripe/utils/prefs.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // For delay

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Function to wait for 3 seconds and then navigate to the HomeScreen
  _navigateToHome() async {
    // Wait for 3 seconds (adjust the time as needed)
    await Future.delayed(Duration(seconds: 3));
    if (await PreferencesHelper.getLoginState() == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CategoriesScreen()), // HomeScreen is your main screen
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginScreen()), // HomeScreen is your main screen
      );
    }
    // After delay, navigate to HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue, // Choose your background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Example: Show a logo on the splash screen
            Icon(
              Icons.star,
              size: 100,
              color: Colors.white,
            ),
            SizedBox(height: 20),
            Text(
              'Welcome to My App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

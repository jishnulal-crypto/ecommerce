import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  // Hardcoded user details for demonstration purposes
  final String username = "john_doe";
  final String email = "john.doe@example.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Profile Info Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Displaying the username
                    Text(
                      'Username: $username',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Displaying the email
                    Text(
                      'Email: $email',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Add any other widgets below, like buttons, settings options, etc.
          ],
        ),
      ),
    );
  }
}

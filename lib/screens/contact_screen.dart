import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatelessWidget {
  // Hardcoded contact details for demonstration purposes
  final String name = "Jane Doe";
  final String phone = "+1 234 567 890";
  final String email = "jane.doe@example.com";

  // Function to launch the phone dialer
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUrl = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUrl.toString())) {
      await launch(phoneUrl.toString());
    } else {
      throw 'Could not make the phone call';
    }
  }

  // Function to send an email
  Future<void> _sendEmail(String email) async {
    final Uri emailUrl = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': 'Hello, Jane!'},
    );
    if (await canLaunch(emailUrl.toString())) {
      await launch(emailUrl.toString());
    } else {
      throw 'Could not send the email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Contact Info Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Displaying the contact's name
                    Text(
                      'Name: $name',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Displaying the contact's phone number
                    Text(
                      'Phone: $phone',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 10),
                    // Displaying the contact's email
                    Text(
                      'Email: $email',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Buttons for calling and emailing the contact
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        // Call button
                        ElevatedButton.icon(
                          onPressed: () => _makePhoneCall(phone),
                          icon: Icon(Icons.call),
                          label: Text('Call'),
                        ),
                        // Email button
                        ElevatedButton.icon(
                          onPressed: () => _sendEmail(email),
                          icon: Icon(Icons.email),
                          label: Text('Email'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
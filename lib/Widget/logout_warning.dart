import 'package:flutter/material.dart';

import '../Authenticator/login.dart';

class LogoutWarning extends StatelessWidget {
  final String message;

  LogoutWarning({required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            // Navigate to the login screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context); // Close the dialog
          },
          child: Text('No'),
        ),
      ],
    );
  }
}
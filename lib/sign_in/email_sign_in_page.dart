// @dart = 2.8
import 'package:flutter/material.dart';

import 'package:myapp/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInForm(),
          ),
        ),
      ),
      appBar: AppBar(
        title: Center(child: Text('Sign In')),
        elevation: 2.0,
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

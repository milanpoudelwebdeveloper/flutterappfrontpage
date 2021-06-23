// @dart = 2.8
import 'package:flutter/material.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:myapp/sign_in/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<Usera>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            Usera user = snapshot.data;
            if (user == null) {
              return SignInPage();
            } else {
              return HomePage();
            }
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}

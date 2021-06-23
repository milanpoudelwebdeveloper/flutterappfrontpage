// @dart = 2.8
import 'package:flutter/material.dart';
import 'package:myapp/landing_page.dart';
import 'package:myapp/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().whenComplete(() => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: MaterialApp(
        title: "Time Tracker App",
        theme: ThemeData(primaryColor: Colors.blue),
        home: LandingPage(),
      ),
    );
  }
}

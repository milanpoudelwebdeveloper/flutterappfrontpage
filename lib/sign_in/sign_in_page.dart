// @dart = 2.8

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:myapp/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:myapp/sign_in/email_sign_in_page.dart';
import 'package:myapp/sign_in/sign_in_button.dart';
import 'package:myapp/sign_in/social_sign_in_button.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  void _showSignInError(BuildContext context, FirebaseAuthException exception) {
    PlatformExceptionAlertDialog(title: 'Sign in Failed', exception: exception)
        .show(context);
  }

  bool _isLoading = false;

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithFacebook();
    } on FirebaseAuthException catch (e) {
      _showSignInError(context, e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => EmailSignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Time Tracker App")),
        elevation: 2.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 50.0, child: _buildHeader()),
          SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
            assetName: 'images/google-logo.png',
            text: 'Sign in With Google',
            textColor: Colors.black87,
            color: Colors.white,
            onPressed: () =>
                _isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook-logo.png',
            text: 'Sign in with Facebook',
            textColor: Colors.white,
            color: Color(0xFF334D92),
            onPressed: () =>
                _isLoading ? null : () => _signInWithFacebook(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Sign in with email',
            textColor: Colors.white,
            color: Colors.teal[700],
            onPressed: () =>
                _isLoading ? null : () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'OR',
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: 'Go anonymous',
            textColor: Colors.black,
            color: Colors.lime[300],
            onPressed: () =>
                _isLoading ? null : () => _signInAnonymously(context),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      "Sign in",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

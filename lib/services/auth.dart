// @dart = 2.8
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class Usera {
  Usera({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<Usera> get onAuthStateChanged;
  Future<Usera> currentUser();
  Future<Usera> signInAnonymously();
  Future<Usera> signInWithGoogle();
  Future<Usera> signInWithFacebook();
  Future<Usera> createUserWithEmailAndPassword(String email, String password);
  Future<Usera> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  Usera _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return Usera(uid: user.uid);
  }

  @override
  Stream<Usera> get onAuthStateChanged {
    Stream<User> result = _firebaseAuth.authStateChanges();
    return result.map(_userFromFirebase);
  }

  @override
  Future<Usera> currentUser() async {
    final User user = await _firebaseAuth.currentUser;
    return _userFromFirebase(user);
  }

  @override
  Future<Usera> signInAnonymously() async {
    final authResult = await _firebaseAuth.signInAnonymously();
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<Usera> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<Usera> signInWithFacebook() async {
    final facebooklogin = new FacebookLogin();
    facebooklogin.loginBehavior = FacebookLoginBehavior.webOnly;
    final result = await facebooklogin.logIn(['email']);
    if (result.accessToken != null) {
      final authresult = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(result.accessToken.token));
      return _userFromFirebase(authresult.user);
    } else {
      throw PlatformException(
          code: 'ERROR: ABORTED BY USER', message: 'Sign in aborted by user');
    }
  }

  @override
  Future<Usera> createUserWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _userFromFirebase(authResult.user);
  }

  @override
  Future<Usera> signInWithEmailAndPassword(
      String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    final facebookSignIn = FacebookLogin();
    await googleSignIn.signOut();
    await facebookSignIn.logOut();
    await _firebaseAuth.signOut();
  }
}

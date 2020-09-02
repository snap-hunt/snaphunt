import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

// src: https://gist.github.com/slightfoot/6f97d6c1ec4eb52ce880c6394adb1386
class Auth {
  static Future<Auth> create() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    return Auth._(currentUser);
  }

  static Auth of(BuildContext context) {
    return Provider.of<Auth>(context, listen: false);
  }

  Auth._(
    User currentUser,
  ) : currentUser = ValueNotifier<User>(currentUser);

  final ValueNotifier<User> currentUser;

  final _googleSignIn = GoogleSignIn();
  final _firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<User> _authSub;

  User init(VoidCallback onUserChanged) {
    currentUser.addListener(onUserChanged);
    _authSub = _firebaseAuth.authStateChanges().listen((User user) {
      currentUser.value = user;
    });
    return currentUser.value;
  }

  void dispose(VoidCallback onUserChanged) {
    currentUser.removeListener(onUserChanged);
    _authSub.cancel();
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e, st) {
      throw _getAuthException(e, st);
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        throw AuthException.cancelled;
      }
      final auth = await account.authentication;
      await _firebaseAuth.signInWithCredential(
        GoogleAuthProvider.credential(
            idToken: auth.idToken, accessToken: auth.accessToken),
      );
    } catch (e, st) {
      throw _getAuthException(e, st);
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e, st) {
      FlutterError.reportError(FlutterErrorDetails(exception: e, stack: st));
    }
  }

  AuthException _getAuthException(dynamic e, StackTrace st) {
    if (e is AuthException) {
      return e;
    }
    FlutterError.reportError(FlutterErrorDetails(exception: e, stack: st));
    if (e is PlatformException) {
      switch (e.code) {
        case 'ERROR_INVALID_EMAIL':
          throw const AuthException('Please check your email address.');
        case 'ERROR_WRONG_PASSWORD':
          throw const AuthException('Please check your password.');
        case 'ERROR_USER_NOT_FOUND':
          throw const AuthException(
              'User not found. Is that the correct email address?');
        case 'ERROR_USER_DISABLED':
          throw const AuthException(
              'Your account has been disabled. Please contact support');
        case 'ERROR_TOO_MANY_REQUESTS':
          throw const AuthException(
              'You have tried to login too many times. Please try again later.');
      }
    }
    throw const AuthException('Sorry, an error occurred. Please try again.');
  }
}

class AuthException implements Exception {
  static const cancelled = AuthException('cancelled');

  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:login_bloc/utils/auth_codes.dart';

class AuthBiometric {
  AuthBiometric._privateConstructor();

  static final AuthBiometric shared = AuthBiometric._privateConstructor();

  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      log('$e');
    }
    return canCheckBiometrics;
  }

  Future<AuthCodes> authenticate(String msg) async {
    bool canCheckBiometrics = await _checkBiometrics();
    if (canCheckBiometrics) {
      bool isAuthorized = false;
      try {
        isAuthorized = await _auth.authenticate(
            localizedReason: msg,
            options: const AuthenticationOptions(
                useErrorDialogs: true, biometricOnly: true, stickyAuth: true));
      } on PlatformException catch (e) {
        log('$e');
        switch (e.code) {
          case 'NotAvailable':
            return AuthCodes.notAvailable;
          case 'PasscodeNotSet':
            return AuthCodes.passcodeNotSet;
          case 'NotEnrolled':
            return AuthCodes.notEnrolled;
          case 'LockedOut':
            return AuthCodes.lockedOut;
          case 'OtherOperatingSystem':
            return AuthCodes.otherOperatingSystem;
          case 'PermanentlyLockedOut':
            return AuthCodes.permanentlyLockedOut;
        }
      }
      return isAuthorized ? AuthCodes.authSuccess : AuthCodes.noAutorized;
    } else {
      return AuthCodes.cantBiometric;
    }
  }
}

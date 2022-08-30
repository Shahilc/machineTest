import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../OtpPage.dart';

class PhoneAuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;


  /// Phone Verification Method
  Future<void> verifyPhoneNumber(BuildContext context, number) async {
    // phoneVerificationCompleted
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (PhoneAuthCredential credential) async {
      await auth.signInWithCredential(credential);
    };

    // Verification  failed
    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      print("err${e.code}");
    };

    // Otp Code Sending
    // ignore: prefer_function_declarations_over_variables
    final PhoneCodeSent phoneCodeSent =
        (String verificationId, int? resendToken) async {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OtpPage(
              number: number,
              verificationId: verificationId,
            );
          },
        ),
      );
    };
// Must Use Cloud.Google.com ==> Console=> Search Project=>API$ Services=>
// + Enable Api& Services => Search => Android Device Verification
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: phoneVerificationCompleted,
        verificationFailed: phoneVerificationFailed,
        codeSent: phoneCodeSent,
        timeout: const Duration(seconds: 80),
        codeAutoRetrievalTimeout: (String verificationId) {
          print(verificationId);
        },
      );
    } catch (e) {
      print(e);
    }
  }
}
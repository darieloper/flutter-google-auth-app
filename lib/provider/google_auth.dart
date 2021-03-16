import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignAuthProvider extends ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool _isProcessing;

  GoogleSignAuthProvider() {
    _isProcessing = false;
  }

  bool get isProcessing => _isProcessing;

  set isProcessing(bool value) {
    _isProcessing = value;
    this.notifyListeners();
  }

  Future login() async {
    isProcessing = true;

    final user = await googleSignIn.signIn();
    if (user == null) {
      isProcessing = false;

      return;
    }

    final auth = await user.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: auth.accessToken,
      idToken: auth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    isProcessing = false;
  }

  void logout() async {
    await googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }
}

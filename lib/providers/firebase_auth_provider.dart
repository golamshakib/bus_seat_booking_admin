import 'package:bus_seat_booking_admin/db/db_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthProvider with ChangeNotifier{
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<bool> loginAdmin(String email, String password) async {
    final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return DbHelper.isAdmin(cred.user!.uid);
  }

  Future<bool> isEmailVerified() async {
    return currentUser!.emailVerified;
  }

  Future<void> sendVerificationMail() async {
    currentUser!.sendEmailVerification();
  }

  Future<void> logout() {
    return _auth.signOut();
  }
}
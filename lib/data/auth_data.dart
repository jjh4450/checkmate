import 'package:firebase_auth/firebase_auth.dart';
import 'package:checkmate/data/firestor.dart';

class AuthenticationRemote{
  Future<void> login(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(), password: password.trim());
  }

  Future<void> register(
      String email, String password, String PasswordConfirm) async {
    if (PasswordConfirm == password) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) {
        Firestore_Datasource().CreateUser(email);
      });
    }
  }
}

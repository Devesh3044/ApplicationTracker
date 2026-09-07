import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> register (String email, String password){
    return _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
  }

  Future<UserCredential> login (String email, String password){
    return _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
  }

}
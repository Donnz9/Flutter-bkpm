import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register
  Future<UserModel?> register(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Pastikan user tidak null
      if (userCredential.user != null) {
        return UserModel(uid: userCredential.user!.uid, email: email);
      } else {
        return null; // Gagal mendapatkan user
      }
    } catch (e) {
      print("Register Error: ${e.toString()}");
      return null;
    }
  }

  // Login
  Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Pastikan user tidak null
      if (userCredential.user != null) {
        return UserModel(uid: userCredential.user!.uid, email: email);
      } else {
        return null; // Gagal mendapatkan user
      }
    } catch (e) {
      print("Login Error: ${e.toString()}");
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Logout Error: ${e.toString()}");
    }
  }
}

import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void login() async {
    var user = await _authService.login(
      emailController.text, 
      passwordController.text,
    );
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login berhasil! Selamat datang.'),
          backgroundColor: Colors.green,
        ),
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login gagal! Periksa email dan password.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController, 
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController, 
              obscureText: true, 
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login, 
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context, '/register');
              }, 
              child: const Text('Belum punya akun? Daftar disinii'),
            ),
          ],
        ),
      ),
    );
  }
}

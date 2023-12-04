import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 108),
              const SizedBox(height: 24),
              const Text(
                'Welcome!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Text(
                'It is nice to see you again',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(label: Text('email')),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(label: Text('password')),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    } catch (error) {
                      print(error);
                    }
                  },
                  child: const Text('Log in'))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    super.key,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';

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
                controller: widget.emailController,
                decoration: const InputDecoration(label: Text('email')),
              ),
              TextField(
                controller: widget.passwordController,
                decoration: const InputDecoration(label: Text('password')),
                obscureText: true,
              ),
              const SizedBox(height: 12),
              Text(errorMessage),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(() {
                        errorMessage = 'Error occured: ${error.toString()}';
                      });
                    }
                  },
                  child: const Text('Log in')),
              const SizedBox(height: 36),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member?'),
                  Text(
                    ' Register now',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

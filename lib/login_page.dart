import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'registration_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth authService = FirebaseAuth.instance;
  final _loginFormKey = GlobalKey<FormState>();
  String? userEmail, userPassword;

  Future<void> signInUser() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      try {
        await authService.signInWithEmailAndPassword(
            email: userEmail!, password: userPassword!);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Form(
        key: _loginFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => userEmail = value,
                validator: (value) => value!.isEmpty ? 'Enter your email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => userPassword = value,
                validator: (value) => value!.isEmpty ? 'Enter your password' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: signInUser, child: Text('Sign In')),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegistrationPage()));
                },
                child: Text("Don't have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

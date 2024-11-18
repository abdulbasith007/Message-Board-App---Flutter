import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth authService = FirebaseAuth.instance;
  final FirebaseFirestore dbService = FirebaseFirestore.instance;

  final _registrationFormKey = GlobalKey<FormState>();
  String? email, password, firstName, lastName, role, gender;

  Future<void> registerUser() async {
    if (_registrationFormKey.currentState!.validate()) {
      _registrationFormKey.currentState!.save();
      try {
        UserCredential userCredential = await authService
            .createUserWithEmailAndPassword(email: email!, password: password!);
        User? user = userCredential.user;

        if (user != null) {
          await dbService.collection('users').doc(user.uid).set({
            'uid': user.uid,
            'firstName': firstName,
            'lastName': lastName,
            'email': email,
            'gender': gender,
            'role': role,
            'registrationDate': FieldValue.serverTimestamp(),
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration successful! Please log in.')),
          );
          Navigator.pop(context);
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Form(
        key: _registrationFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'First Name'),
                onSaved: (value) => firstName = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your first name' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last Name'),
                onSaved: (value) => lastName = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your last name' : null,
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Gender'),
                items: ['Male', 'Female', 'Other']
                    .map((gender) =>
                        DropdownMenuItem(value: gender, child: Text(gender)))
                    .toList(),
                onChanged: (value) => gender = value,
                validator: (value) =>
                    value == null ? 'Please select your gender' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Role'),
                onSaved: (value) => role = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your role' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) => password = value,
                validator: (value) =>
                    value!.length < 6 ? 'Password must be at least 6 characters' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: registerUser,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

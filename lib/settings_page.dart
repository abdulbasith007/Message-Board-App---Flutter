import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth authService = FirebaseAuth.instance;
  final FirebaseFirestore dbService = FirebaseFirestore.instance;

  User? currentUser;
  String? updatedFirstName, updatedLastName, updatedRole, updatedGender;

  @override
  void initState() {
    super.initState();
    currentUser = authService.currentUser;
  }

  Future<void> updatePassword() async {
    String oldPassword = '';
    String newPassword = '';

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'Current Password'),
              onChanged: (value) => oldPassword = value,
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: 'New Password'),
              onChanged: (value) => newPassword = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              try {
                if (currentUser != null) {
                  final credential = EmailAuthProvider.credential(
                    email: currentUser!.email!,
                    password: oldPassword,
                  );
                  await currentUser!.reauthenticateWithCredential(credential);
                  await currentUser!.updatePassword(newPassword);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password updated successfully!')),
                  );
                  Navigator.pop(context);
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $e')),
                );
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  Future<void> logout() async {
    await authService.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: updatePassword,
              icon: Icon(Icons.lock),
              label: Text('Update Password'),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: logout,
              icon: Icon(Icons.logout),
              label: Text('Log Out'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // Logout button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

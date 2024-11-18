import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'home_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FastChatApp());
}

class FastChatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastChat',
      theme: ThemeData(primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/settings': (context) => SettingsPage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:session7/notes.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      const Duration(
        seconds: 3,
      ),
          () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (
              BuildContext context) => FirebaseAuth.instance.currentUser == null
              ? const MyLoginScreen()
              : const NotesScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: const Text(
            "MyApp",
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ),
        body: const Center(
          child: Text(
            "Welcome To My App",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,

            ),
          ),
        ),
      ),
    );
  }
}


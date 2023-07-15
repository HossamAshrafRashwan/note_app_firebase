import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => const MyLoginScreen(),
            ),
          );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: const Text(
          "Register",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: _isObscure,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: "Password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(onPressed: (){
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
                  icon: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => register(),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void register() {
    String email = emailController.text;
    String password = passwordController.text;
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value){Navigator.pop(context);},
    ).catchError((error){
     print("Register Failure => $error");
    });
  }
}

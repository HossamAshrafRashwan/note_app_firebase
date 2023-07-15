import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:session7/notes.dart';
import 'package:session7/reset_password_screen.dart';
import 'register.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({super.key});

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {

  bool _isObscure = true;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(
              color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Container(
        margin: const EdgeInsets.all(20,),
        child: Column(
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage:NetworkImage(
                    "https://images.wuzzuf-data.net/files/company_logo/Senior-Steps-Egypt-29775-1515491223.png",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0,),
                  child: Text(
                    "Senior Steps",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email,),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: "password",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.lock,),
                suffixIcon: IconButton(
                  onPressed: (){
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
              height: 20,
            ),
            GestureDetector(
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                      "Forget Your Password?",
                  ),
                ],
              ),
              onTap: ()=> Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen(),
                ),
              ).then((value) {
                const SnackBar(content: Text("Email sent successfully"));
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child:ElevatedButton(
                    onPressed: () => login(),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                    ),
                    child: const Text(
                        "Login",
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child:OutlinedButton(onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const Register(),
                        ),
                    );
                  }, style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                    child: const Text(
                        "Register",
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    String email = emailController.text;

    String password = passwordController.text;

    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NotesScreen(),
        ),
      );
    }).catchError((error){
      print("Login Failure");
    });
  }
}
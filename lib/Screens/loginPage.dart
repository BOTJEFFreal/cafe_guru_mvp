import 'package:cafeee/Screens/signupPage.dart';
import 'package:flutter/material.dart';

import '../Logic/Auth.dart';
import '../components/my_button.dart';
import '../components/my_textfield.dart';
import 'guruListPage.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignupPage())
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(onTap: (){
                if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {


                  logIn(emailController.text, passwordController.text).then((user) {
                    if (user != null) {
                      print("Login Sucessful");

                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => FinanceScreen()));
                    } else {
                      print("Login Failed");

                    }
                  });
                } else {
                  print("Please fill form correctly");
                }
              }, text: "Sign In"),
            ],
          ),
        ),
      ),
    );
  }
}

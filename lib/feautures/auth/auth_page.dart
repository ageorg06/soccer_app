import 'package:flutter/material.dart';

import 'auth_controller.dart';

class LoginSignupUI extends StatefulWidget {
  const LoginSignupUI({super.key});

  @override
  State<LoginSignupUI> createState() => _LoginSignupUIState();
}

class _LoginSignupUIState extends State<LoginSignupUI> {
  final AuthRequestHandler _requestHandler = AuthRequestHandler();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 900,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 10,),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                const SizedBox(height:20),
                ElevatedButton(
                  onPressed: () async{
                    try {
                      await _requestHandler.login(_emailController.text, _passwordController.text);
                    }catch(e){
                      print("Error in UI: $e");
                    }
                  },
                  child: const Text("Login"),
                ),
                ElevatedButton(
                  onPressed: () async{
                    try {
                      await _requestHandler.signup(_emailController.text, _passwordController.text);
                    }catch(e){
                      print("Error in UI: $e");
                    }
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            )
        ),
      ),
    );
  }
}
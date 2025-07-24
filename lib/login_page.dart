import 'package:flutter/material.dart';
import 'package:ride_mate/widgets/custom_test_feild.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFeild(
                hinttext: "enter email",
                 pIcon: Icons.email, 
                 controller: _email,
                ),
              CustomTextFeild(
                hinttext: "enter your password", 
                pIcon: Icons.security, 
                controller: _pass,
                isPassword: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
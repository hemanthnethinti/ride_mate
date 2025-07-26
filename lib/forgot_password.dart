import 'package:flutter/material.dart';
import 'package:ride_mate/widgets/custom_test_feild.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailPass = TextEditingController();
    final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100,),
            Text('Reset Password',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            Text("Enter the email address or phone number associated with your account. We’ll send you a verification code to reset your password."),
            const SizedBox(height: 25,),
            Form(
              key: _key,
              child: CustomTextFeild(
                label: "Email/Phone Number",
                controller: _emailPass,
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: (){
               if (_key.currentState!.validate()) {
                      debugPrint('Email/Phone Number: ${_emailPass.text}');
                    }
            },style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D2B45),
                minimumSize: const Size(double.infinity, 60),
              ),
             child: Center(child: Text('Continue',style: TextStyle(color: Colors.white, fontSize: 16),)))
          ],
        ),
      ),
    );
  }
}
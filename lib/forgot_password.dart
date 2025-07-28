import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_mate/widgets/custom_test_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_mate/wrapper.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailPass = TextEditingController();
    final _key = GlobalKey<FormState>();
   bool _isloading=false;
    Future<void> sendLink()async{
        setState(() {
          _isloading=true;
        });
        try{
           await  FirebaseAuth.instance.sendPasswordResetEmail(email:_emailPass.text);

           if(mounted){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: 
              Text('Email was sent successfully(Sometimes it will be in spam folder).'),
              backgroundColor: Colors.green,
              )
            );
            Navigator.push(context, MaterialPageRoute(builder: (context)=>Wrapper()));
           }
        }
        on FirebaseAuthException catch(e){
            if(mounted){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:Text(e.code) ,
                  backgroundColor: Colors.red,
                  )
              );
            }
        }catch(e){
            if(mounted){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:Text(e.toString()),
                  backgroundColor: Colors.red,
                   )
              );
            }
        }
        setState(() {
          _isloading=false;
        });
    }
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
                      sendLink();
                    }
               
            },style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D2B45),
                minimumSize: const Size(double.infinity, 60),
              ),
             child: _isloading?CircularProgressIndicator():
             Center(child: Text('Continue',style: TextStyle(color: Colors.white, fontSize: 16),)))
          ],
        ),
      ),
    );
  }
}
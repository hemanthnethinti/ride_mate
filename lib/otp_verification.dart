
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_mate/wrapper.dart';
class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final _phone = TextEditingController();
  final _key = GlobalKey<FormState>();
  sendOtp()async{
     try{
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${_phone.text}',
        verificationCompleted: (PhoneAuthCredential cred){}, 
        verificationFailed: (FirebaseAuthException e){

        }, 
        codeSent: (String vid,int? token){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerificationScreen(vid: vid,)));
        },
         codeAutoRetrievalTimeout:(vid){}
         );
     }
     on FirebaseAuthException catch(e){
      print(e.code);
     }
     catch(e){
      print(e.toString());
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Text(
              'OTP Verification',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              'Enter your phone number to receive a one-time password(OTP).',
            ),
            const SizedBox(height: 25),
            Form(
              key: _key,
              child: TextFormField(
                controller: _phone,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('Phone Number'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the phone number';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    debugPrint('Phone Number: ${_phone.text}');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => OtpVerificationScreen(vid: ,),
                    //   ),
                    // );
                    sendOtp();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D2B45),
                  minimumSize: const Size(double.infinity, 60),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtpVerificationScreen extends StatefulWidget {
  final String vid;
  const OtpVerificationScreen({super.key,required this.vid});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otp = TextEditingController();
  final _key = GlobalKey<FormState>();
  signIn()async{
    PhoneAuthCredential cred=PhoneAuthProvider.credential(
      verificationId: widget.vid, smsCode: _otp.text);
    try{
        await FirebaseAuth.instance.signInWithCredential(cred);
          await Navigator.push(context,MaterialPageRoute(builder: (context)=>Wrapper()));
    }on FirebaseAuthException catch(e){
      print(e.code);
    }
    catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            Text(
              'Verification Code',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text('We have sent the verification code to youe phone number'),
            const SizedBox(height: 25),
            Form(
              key: _key,
              child: TextFormField(
                controller: _otp,
                keyboardType: TextInputType.number,
                maxLength: 4,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                decoration: InputDecoration(
                  label: Text('Enter your 4-digit code'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter thr OTP';
                  } else if (value.length != 5) {
                    return 'OTP must be exactly 4 digits';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_key.currentState!.validate()) {
                  debugPrint('OTP: ${_otp.text}');

                  // Navigate to HomePage
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const MyHome()),
                  // );
                  signIn();
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D2B45),
                minimumSize: const Size(double.infinity, 60),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


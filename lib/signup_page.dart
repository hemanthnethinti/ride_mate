import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ride_mate/login_page.dart';
import 'package:ride_mate/terms_conditions.dart';
import 'package:ride_mate/widgets/custom_test_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_mate/wrapper.dart';
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
    final _phone = TextEditingController();
  final _pass = TextEditingController();
  final _repass = TextEditingController();
  final _key = GlobalKey<FormState>();

  bool isSelected = false;
  bool _isloading=false;
  final List<IconData> iconList = [
    FontAwesomeIcons.google,
    FontAwesomeIcons.facebook,
    FontAwesomeIcons.microsoft,
  ];
  Future<void> reg()async{
   
      setState(() {
        _isloading=true;
      });
      UserCredential? userCred;
        try{
      userCred=await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email.text,
       password: _pass.text);
         if (userCred.user != null && !(userCred.user!.emailVerified))
           {
            await userCred.user!.sendEmailVerification();
           }
         
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification Link Was Sent to ${userCred.user?.email}(Sometimes it will be in spam folder)'
             ),
             backgroundColor: Colors.green,
          )
          
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Wrapper()));
      }
        
      }
      on FirebaseAuthException catch(e){
        String mess;
        switch(e.code){
           case 'weak-password':
             mess='The password provided is too weak.';
             break;
           case 'email-already-in-use':
             mess='An account already exists for that email.';
             break;
           case 'invalid-email':
             mess = 'The email address is not valid.';
             break;
           case 'operation-not-allowed':
             mess = 'Email/password sign-in is not enabled for this project.';
             break;
           case 'network-request-failed':
             mess = 'Network error. Please check your internet connection.';
             break;
           default:
             mess= 'An unknown error occurred: ${e.message}';
             break;
        }
         if(mounted){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(mess),
            backgroundColor: Colors.red,
            )
          );
         }
      }
      catch(e){
        setState(() {
       
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('An unexpected error occurred: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      }
       finally {
      if (mounted) {
        setState(() {
          _isloading = false; 
        });
      }
    }
     print("SignUp Successful");
  }
      
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Create Account',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        leading: const BackButton(),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo or App Icon
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.orange,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_add,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  const Text(
                    'Join RideMate Today',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create your account to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Full Name Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.orange,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CustomTextFeild(
                      label: 'Full Name',
                      pIcon: const Icon(Icons.person, color: Colors.orange),
                      controller: _name,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Email Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.orange,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CustomTextFeild(
                      label: 'Email',
                      pIcon: const Icon(Icons.email, color: Colors.orange),
                      controller: _email,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Phone Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.orange,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _phone,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                           FilteringTextInputFormatter.digitsOnly, 
                           LengthLimitingTextInputFormatter(10),   
                       ],
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone, color: Colors.orange),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(color: Colors.grey[600]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.orange, width: 2),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 1),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.red, width: 2),
                        ),
                      ),
                       validator: (value) {
                         if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                        } else if (value.length != 10) {
                           return 'Phone number must be exactly 10 digits';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.orange,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CustomTextFeild(
                      label: 'Password',
                      pIcon: const Icon(Icons.lock, color: Colors.orange),
                      controller: _pass,
                      isPassword: true,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a new password';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Confirm Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.orange,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CustomTextFeild(
                      label: 'Confirm Password',
                      pIcon: const Icon(Icons.lock_outline, color: Colors.orange),
                      controller: _repass,
                      isPassword: true,
                      validate: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (_pass.text != _repass.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Terms and Conditions
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isSelected,
                          onChanged: (val) {
                            setState(() {
                              isSelected = val!;
                            });
                          },
                          activeColor: Colors.orange,
                        ),
                        Expanded(
                          child: Wrap(
                            children: [
                              const Text('I agree to the '),
                              InkWell(
                                onTap: () async {
                                  final accepted = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const TermsConditions(),
                                    ),
                                  );

                                  if (accepted == true) {
                                    setState(() {
                                      isSelected = true;
                                    });
                                  }
                                },
                                child: const Text(
                                  'Terms and Conditions',
                                  style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        if (!isSelected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('You must accept Terms and Conditions'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          );
                          return;
                        }
                        debugPrint('Full Name: ${_name.text}');
                        debugPrint('Email: ${_email.text}');
                        debugPrint('Password: ${_pass.text}');
                        debugPrint('Confirm Password: ${_repass.text}');
                        reg();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: _isloading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                        : const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  const SizedBox(height: 30),

                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey[400])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Or sign up with',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey[400])),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Social Login Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(iconList.length, (index) {
                      return Container(
                        height: 60,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.orange, width: 2),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 4,
                              color: Colors.orange,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            debugPrint('Tapped on ${iconList[index]}');
                          },
                          icon: Icon(
                            iconList[index],
                            color: Colors.orange,
                            size: 24,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30),

                  // Login Link
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
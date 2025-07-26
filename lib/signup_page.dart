import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ride_mate/login_page.dart';
import 'package:ride_mate/otp_verification.dart';
import 'package:ride_mate/terms_conditions.dart';
import 'package:ride_mate/widgets/custom_test_feild.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _repass = TextEditingController();
  final _key = GlobalKey<FormState>();

  bool isSelected = false;

  final List<IconData> iconList = [
    FontAwesomeIcons.google,
    FontAwesomeIcons.facebook,
    FontAwesomeIcons.github,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 40),
                CustomTextFeild(
                  label: 'Full Name',
                  pIcon: const Icon(Icons.person),
                  controller: _name,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFeild(
                  label: 'Email',
                  pIcon: const Icon(Icons.email),
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
                const SizedBox(height: 15),
                CustomTextFeild(
                  label: 'Password',
                  pIcon: const Icon(Icons.lock),
                  controller: _pass,
                  isPassword: true,
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a new password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextFeild(
                  label: 'Confirm Password',
                  pIcon: const Icon(Icons.lock),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: isSelected,
                      onChanged: (val) {
                        setState(() {
                          isSelected = val!;
                        });
                      },
                    ),
                    const Text('I agree to the'),
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
                        ' Terms and Conditions',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      if (!isSelected) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('You must accept Terms and Conditions'),
                          ),
                        );
                        return;
                      }
                      debugPrint('Full Name: ${_name.text}');
                      debugPrint('Email: ${_email.text}');
                      debugPrint('Password: ${_pass.text}');
                      debugPrint('Confirm Password: ${_repass.text}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OtpVerification(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0D2B45),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                        );
                      },
                      child: const Text(
                        'Login here',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(iconList.length, (index) {
                    return InkWell(
                      onTap: () {
                        debugPrint('Tapped on ${iconList[index]}');
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(iconList[index], size: 25),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
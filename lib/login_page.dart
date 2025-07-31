import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ride_mate/signup_page.dart';
import 'package:ride_mate/forgot_password.dart';
import 'package:ride_mate/widgets/custom_test_feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ride_mate/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool _isloading = false;

  final List<IconData> iconList = [
    FontAwesomeIcons.google,
    FontAwesomeIcons.facebook,
    FontAwesomeIcons.microsoft,
  ];


  Future<Map<String, String>> getUserDetails(String uid) async {
    try {
      final doc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        return {
          'userName': doc[''] ?? '',
          'userEmail': doc['email'] ?? '',
          'userPhone': doc['phone'] ?? '',
        };
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
    return {'userName': 'Arshiya Mohammed', 'userEmail': '', 'userPhone': ''};
  }

  
  Future<void> login() async {
    setState(() => _isloading = true);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pass.text.trim(),
      );

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.reload();
        if (user.emailVerified) {
        
          final details = await getUserDetails(user.uid);

          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHome(
                  userName: details['userName']!,
                  userEmail: details['userEmail']!,
                  userPhone: details['userPhone']!,
                ),
              ),
            );
          }

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Login successful')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please verify your email first'),
              backgroundColor: Colors.orange));
        }
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? e.code), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isloading = false);
    }
  }

 
  Future<void> signInWithGoogle() async {
    try {
      final googleProvider = GoogleAuthProvider();
      final credential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);
      final user = credential.user;

      if (user != null) {
        
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName ?? "Google User",
          'email': user.email ?? "",
          'phone': user.phoneNumber ?? "No Phone",
        }, SetOptions(merge: true));

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHome(
                userName: user.displayName ?? "Google User",
                userEmail: user.email ?? "No Email",
                userPhone: user.phoneNumber ?? "No Phone",
              ),
            ),
          );
        }
      }
    } catch (e) {
      print("Google Sign-In Error: $e");
    }
  }

 
  Future<void> signInWithFacebook() async {
    try {
      final fbProvider = FacebookAuthProvider();
      final credential =
          await FirebaseAuth.instance.signInWithPopup(fbProvider);
      final user = credential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName ?? "Facebook User",
          'email': user.email ?? "",
          'phone': user.phoneNumber ?? "No Phone",
        }, SetOptions(merge: true));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHome(
              userName: user.displayName ?? "Facebook User",
              userEmail: user.email ?? "No Email",
              userPhone: user.phoneNumber ?? "No Phone",
            ),
          ),
        );
      }
    } catch (e) {
      print("Facebook Sign-In Error: $e");
    }
  }

  
  Future<void> signInWithMicrosoft() async {
    try {
      final msProvider = MicrosoftAuthProvider();
      final credential =
          await FirebaseAuth.instance.signInWithPopup(msProvider);
      final user = credential.user;

      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName ?? "Microsoft User",
          'email': user.email ?? "",
          'phone': user.phoneNumber ?? "No Phone",
        }, SetOptions(merge: true));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHome(
              userName: user.displayName ?? "Microsoft User",
              userEmail: user.email ?? "No Email",
              userPhone: user.phoneNumber ?? "No Phone",
            ),
          ),
        );
      }
    } catch (e) {
      print("Microsoft Sign-In Error: $e");
    }
  }

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
              children: [
                const Text('Login',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 40),

                
                CustomTextFeild(
                  label: 'Email',
                  pIcon: const Icon(Icons.mail),
                  controller: _email,
                  validate: (v) =>
                      v == null || v.isEmpty ? 'Enter email' : null,
                ),
                const SizedBox(height: 15),

               
                CustomTextFeild(
                  label: 'Password',
                  pIcon: const Icon(Icons.lock),
                  controller: _pass,
                  isPassword: true,
                  validate: (v) =>
                      v == null || v.isEmpty ? 'Enter password' : null,
                ),
                const SizedBox(height: 10),

                
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => ForgotPassword())),
                      child: const Text('Forgot Password?',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                const SizedBox(height: 20),

                
                ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) login();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D2B45),
                      minimumSize: const Size(double.infinity, 60)),
                  child: _isloading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Login',
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
                const SizedBox(height: 15),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    const SizedBox(width: 5),
                    InkWell(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const SignupPage())),
                      child: const Text('Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 20),

                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _social(iconList[0], signInWithGoogle),
                    _social(iconList[1], signInWithFacebook),
                    _social(iconList[2], signInWithMicrosoft),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _social(IconData icon, VoidCallback onTap) => Container(
        height: 50,
        width: 50,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(8)),
        child: IconButton(onPressed: onTap, icon: Icon(icon)),
      );
}

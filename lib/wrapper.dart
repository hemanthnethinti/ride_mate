import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ride_mate/home_page.dart';
import 'package:ride_mate/login_page.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // ✅ Show loading spinner while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // ✅ If user is logged in
        if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;
          
          if (user.emailVerified) {
            // ✅ Pass user details to MyHome
            return MyHome(
              userName: user.displayName ?? "User",
              userPhone: user.phoneNumber ?? "No Phone",
              userEmail: user.email ?? "No Email",
            );
          } else {
            return const LoginPage();
          }
        }

        // ✅ If user is not logged in
        return const LoginPage();
      },
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:ride_mate/home_page.dart';
// import 'package:ride_mate/login_page.dart';
// class Wrapper extends StatefulWidget {
//   const Wrapper({super.key});

//   @override
//   State<Wrapper> createState() => _WrapperState();
// }

// class _WrapperState extends State<Wrapper> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(), 
//       builder: (context, snapshot) {
//         if(snapshot.hasData){
//         if (snapshot.data!.emailVerified) {
//           return MyHome(
//               userName: user.displayName ?? "User",
//               userPhone: user.phoneNumber ?? "No Phone",
//               userEmail: user.email ?? "No Email",
//             );;
//         } else {
//           return LoginPage();
//         }
//         }
//         else{
//           return LoginPage();
//         }
//       }
//     );
//   }
// }
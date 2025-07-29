import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ride_mate/wrapper.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
    //WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
     await Firebase.initializeApp(
      options: const FirebaseOptions (
    apiKey: "AIzaSyBDYZgPs6or-FE174jwnYD53rgbPkmATBA",
    authDomain: "ridemate-1317d.firebaseapp.com",
    projectId: "ridemate-1317d",
    storageBucket: "ridemate-1317d.firebasestorage.app",
    messagingSenderId: "504709562431",
    appId: "1:504709562431:web:f4e047591db602669cb88a"
      )
     );
     runApp(DevicePreview(builder: (context) => MyApp()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper()
    );
  }
}
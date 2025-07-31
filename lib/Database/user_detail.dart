import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  
 
   static Future<void> storeDetails(User? user)async{
     final uid = user!.uid;
     
     await FirebaseFirestore.instance.collection('user').doc(uid).set({
             'uid': uid,
             'name': user.displayName,
             'email':user.email,
             'createdAt': FieldValue.serverTimestamp()
     });
  } 
}


import 'package:cloud_firestore/cloud_firestore.dart';

class GetRidesOfUser{

  static Future<List<Map<String,dynamic>>>  getRides()async{
    //print('hello');
    List<Map<String,dynamic>> allposts=[];
      final snapshot=await FirebaseFirestore.instance.collection('user').get();
      /// print('${snapshot.docs}docs ');
       for(var user in snapshot.docs){
           print(snapshot.docs.length);
          final uid=user.id;
         // print(user.displayName);
          final postsnapshot=await FirebaseFirestore.instance.collection('user').doc(uid).collection('posts').get();
          for(var posts in postsnapshot.docs){
             FirebaseFirestore.instance.collection('user').doc(uid).collection('posts').doc(posts.id).update({
                    'doc':posts.id
             });
            //posts.data().update('doc',(value)=>posts.id.toString());
          // print(posts.data()['doc']);
               allposts.add(posts.data());
          }
       }
       //print(allposts);
       return allposts;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
class Posts {
    static setPost(final user,String picup,String drop,final start,final end,List<String> days,String charg){
          final uid=user.uid;
       FirebaseFirestore.instance.collection('user').doc(uid).collection('posts').doc().set(
            {
              'userid':uid,
              'PickupLoc':picup,
              'DropLoc':drop,
              'requests':[],
              'accepted':[],
              'Days':days,
              'Charge':charg,
              'doc':'',
              'name':user.displayName
            }
      );
    }
}


// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';

// // class RequestsPage extends StatefulWidget {
// //    String docid;
// //   RequestsPage( {super.key,required this.docid});

// //   @override
// //   State<RequestsPage> createState() => _RequestsPageState();
// // }

// // class _RequestsPageState extends State<RequestsPage> {
// //   @override
// //   void initState(){
// //     super.initState();
// //   }

// //   // void showRequest(){
         
// //   // }
// //   @override
// //   Widget build(BuildContext context) {
// //     User? user=FirebaseAuth.instance.currentUser;
    
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Requests'),),
// //       body: StreamBuilder(
// //         stream: FirebaseFirestore.instance.collection('users').doc(
// //              user?.uid
// //         ).collection('posts').doc(widget.docid).snapshots(),

// //         builder: (context,snapshot){
// //             final rideData=snapshot.data!.data();
// //             List<dynamic> reqIds=rideData?['requests'];
// //             return ListView.builder(
// //               itemCount: reqIds.length,
// //               itemBuilder: (context,index){
// //                    final userId=reqIds[index];
// //                    return FutureBuilder(
// //                     future:FirebaseFirestore.instance.collection('users').doc(userId).get() , 
// //                     builder: (context,usersnapshot){
// //                       final userdata=usersnapshot.data!.data();
// //                       return ListTile(
// //                          title: Text(userdata?['name'] ?? 'Unknown'),
// //                          subtitle: Text(userdata?['email'] ?? ''),
// //                          trailing: ElevatedButton(
// //                           onPressed: ()async{
// //                            await FirebaseFirestore.instance.collection('users').doc(userId).collection('posts').doc(widget.docid).
// //                            update(
// //                             {
// //                               'accepted':FieldValue.arrayUnion([userId]),
// //                               'requests':FieldValue.arrayRemove([userId])
// //                             }
// //                            );
// //                         }
// //                         , child: Text('Accept')
// //                         )
// //                       );
// //                     }
// //                     );
// //               }
// //               );
// //         }),
// //     );
// //   }
// // }


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class RequestsPage extends StatefulWidget {
//   final String docid; // ride document ID

//   const RequestsPage({super.key, required this.docid});

//   @override
//   State<RequestsPage> createState() => _RequestsPageState();
// }

// class _RequestsPageState extends State<RequestsPage> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     User? user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(title: const Text('Requests')),
//       body: StreamBuilder<DocumentSnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('users')
//             .doc(user?.uid)
//             .collection('posts')
//             .doc(widget.docid)
//             .snapshots(),
//         builder: (context, snapshot) {
//           print('tiggered');
//            if (snapshot.connectionState == ConnectionState.waiting) {
//           return CircularProgressIndicator();
//          }
//            if (snapshot.hasError) {
//                 print("🔥 Firestore error: ${snapshot.error}");
//                  return Text("Error loading requests");
//              }
//           if (snapshot.hasData ||snapshot.data!.exists) {
//                 //final rideData = snapshot.data!.data() as Map<String, dynamic>;
//                 print('${widget.docid} doc');
//             //return const Center(child: Text("No requests yet."));
          
         
//           final rideData = snapshot.data!.data() as Map<String, dynamic>;
//           List<dynamic> reqIds = rideData['requests'] ?? [];

//           if (reqIds.isEmpty) {
//             return const Center(child: Text("No join requests."));
//           }

//           return ListView.builder(
//             itemCount: reqIds.length,
//             itemBuilder: (context, index) {
//               final userId = reqIds[index];

//               return FutureBuilder<DocumentSnapshot>(
//                 future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
//                 builder: (context, userSnapshot) {
//                   if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
//                     return const ListTile(title: Text("Loading user..."));
//                   }

//                   final userData = userSnapshot.data!.data() as Map<String, dynamic>;

//                   return ListTile(
//                     title: Text(userData['name'] ?? 'Unknown'),
//                     subtitle: Text(userData['email'] ?? ''),
//                     trailing: ElevatedButton(
//                       onPressed: () async {
//                         final postRef = FirebaseFirestore.instance
//                             .collection('users')
//                             .doc(user!.uid)
//                             .collection('posts')
//                             .doc(widget.docid);

//                         await postRef.update({
//                           'accepted': FieldValue.arrayUnion([userId]),
//                           'requests': FieldValue.arrayRemove([userId]),
//                         });

//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("User accepted")),
//                         );
//                       },
//                       child: const Text('Accept'),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//           }
//           else{
//             return Center(child: Text("No join requests."));
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ride_mate/globals.dart';
import 'package:ride_mate/my_rides.dart';
//import 'package:ride_mate/my_rides.dart';

class RequestsPage extends StatefulWidget {
  
  List<dynamic>? docids;

   RequestsPage( {super.key,  required this.docids});
  
  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  bool _isAccepted=true;
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
   // print(user?.uid.toString());
    return Scaffold(
      appBar: AppBar(title: const Text('Requests')),
      body: ListView.builder
      (
  itemCount: widget.docids?.length ?? 0,
  itemBuilder: (context, index) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(

      stream: FirebaseFirestore.instance
          .collection('user')
          .doc(user?.uid)
          .collection('posts')
          .doc(widget.docids?[index])
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return const ListTile(title: Text("No requests found"));
        }

        final rideData = snapshot.data!.data();
        final List<dynamic> reqIds = rideData?['requests'] ?? [];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: reqIds.map((userId) {
            return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance.collection('user').doc(userId).get(),
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const ListTile(title: Text("Loading user..."));
                }
                if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                  return const ListTile(title: Text("User not found"));
                }
                final userData = userSnapshot.data!.data();
                return ListTile(
                  title: Text(userData?['name'] ?? 'Unknown'),
                  subtitle: Text(userData?['email'] ?? ''),
                  trailing: ElevatedButton(
                    onPressed: () async {
                      _isAccepted = !_isAccepted;
                      final postRef = FirebaseFirestore.instance
                          .collection('user')
                          .doc(user!.uid)
                          .collection('posts')
                          .doc(widget.docids?[index]);
                      await postRef.update({
                        'accepted': FieldValue.arrayUnion([userId]),
                      });
                     
                      final currentUser = FirebaseAuth.instance.currentUser;
                      final Snapshot = await FirebaseFirestore.instance.collection('user').get();
                      for (var doc in Snapshot.docs) {
                        final postsnapshot = await FirebaseFirestore.instance
                            .collection('user')
                            .doc(doc.id)
                            .collection('posts')
                            .where('accepted', arrayContains: currentUser?.uid)
                            .get();
                        for (var post in postsnapshot.docs) {
                          
                          request_list.add(post.data());
                        }
                      }
                      //print(list.length);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MyRides(list: request_list,)));
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Accepted(uid: userId,)));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("User accepted")),
                      );
                    },
                    child: Text(_isAccepted ? 'Accepted' : 'UnAccepted'),
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  },
),
);
}
}



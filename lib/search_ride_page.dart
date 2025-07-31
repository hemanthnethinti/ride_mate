import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:ride_mate/rider_details_page.dart';

class SearchResultsPage extends StatelessWidget {
  List<Map<String,dynamic>>? listlen;
  SearchResultsPage(this.listlen, {super.key});
   
  @override
  Widget build(BuildContext context) {
    
    print(listlen!.length);
    // In real app, this data comes from Firestore or API
    // final rides = [
    //   {
    //     'driver': 'Ramesh',
    //     'from': 'Hyderabad',
    //     'to': 'Warangal',
    //     'price': '₹150',
    //     'seats': 2,
    //   },
    //   {
    //     'driver': 'Sita',
    //     'from': 'Hyderabad',
    //     'to': 'Nalgonda',
    //     'price': '₹120',
    //     'seats': 1,
    //   },
    // ];
    final list=[];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rides'),
        backgroundColor: Colors.orange,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('user').snapshots()
        , builder: (context,snapshot){
          if(!snapshot.hasData) CircularProgressIndicator();
      return ListView.builder(
        itemCount: listlen!.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> ride = listlen![index];
          return Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              title: Text('${ride['PickupLoc']} → ${ride['DropLoc']}'),
              subtitle: Text('Driver: ${ride['name']} | Seats: ${ride['Days']}'),
              onTap: () async{
                print(ride['name']);
                  
                   // Navigator.push(context, MaterialPageRoute(builder: (context)=>RiderDetails(name: ride,)));

                     // list.add(ride['doc']);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => MyHome(),
                  //   ),
                  // );
              },
            ),
          );
        },
      );
        }
      )
    );
  }
}

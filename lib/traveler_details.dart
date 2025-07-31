import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:ride_mate/chat_screen.dart';

// Model to receive ride details
class RideSearchDetails {
  final String from;
  final String to;
  final DateTime? date;
  final TimeOfDay? time;
  final String genderPref;
  final double maxFare;
  final int seats;
  final bool verifiedOnly;

  RideSearchDetails({
    required this.from,
    required this.to,
    required this.date,
    required this.time,
    required this.genderPref,
    required this.maxFare,
    required this.seats,
    required this.verifiedOnly,
  });
}

class TravelerDetails extends StatefulWidget {
  final String userName;
  final RideSearchDetails rideDetails;

  const TravelerDetails({
    super.key,
    required this.userName,
    required this.rideDetails,
  });

  @override
  State<TravelerDetails> createState() => _TravelerDetailsState();
}

class _TravelerDetailsState extends State<TravelerDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        
    
        actions: [
          SizedBox(width: 16,),
          IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen()));
          }, icon: Icon(FontAwesomeIcons.comment,size: 26,)),
          SizedBox(width: 16,),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
                  ),
                  const SizedBox(width: 12),
                  Text('Kavya Vineela',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _buildInlineCard("From", widget.rideDetails.from)),
                const Icon(Icons.arrow_forward, color: Colors.orange),
                Expanded(child: _buildInlineCard("To", widget.rideDetails.to)),
              ],
            ),

            
            _buildCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date: ${widget.rideDetails.date != null ? DateFormat.yMMMd().format(widget.rideDetails.date!) : "Not selected"}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "Time: ${widget.rideDetails.time != null ? widget.rideDetails.time!.format(context) : "Not selected"}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            
            Center(
              child: Text(
                "Seats Required: ${widget.rideDetails.seats}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildCard({required Widget child}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(padding: const EdgeInsets.all(14), child: child),
    );
  }

  
  Widget _buildInlineCard(String label, String value) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        child: Row(
          children: [
            Text("$label: ",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
            Expanded(
              child: Text(value,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}

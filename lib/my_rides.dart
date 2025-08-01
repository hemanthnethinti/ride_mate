import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRides extends StatefulWidget {
  final List<Map<String,dynamic>>? list;
  const MyRides({required this.list, super.key});
  
  @override
  State<MyRides> createState() => _MyRidesState();
}

class _MyRidesState extends State<MyRides> {
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> acceptedRides = [];
  bool isLoading = true;
  
  @override
  void initState() {
    super.initState();
    _fetchAcceptedRides();
  }

  Future<void> _fetchAcceptedRides() async {
    try {
      setState(() {
        isLoading = true;
      });

      List<Map<String, dynamic>> rides = [];
      final currentUser = FirebaseAuth.instance.currentUser;
      
      if (currentUser != null) {
        // Get all users
        final allUsersSnapshot = await FirebaseFirestore.instance.collection('user').get();
        
        for (var userDoc in allUsersSnapshot.docs) {
          // Get posts for each user where current user is accepted
          final postsSnapshot = await FirebaseFirestore.instance
              .collection('user')
              .doc(userDoc.id)
              .collection('posts')
              .where('accepted', arrayContains: currentUser.uid)
              .get();
          
          for (var postDoc in postsSnapshot.docs) {
            Map<String, dynamic> rideData = postDoc.data();
            rideData['postId'] = postDoc.id;
            rideData['ownerId'] = userDoc.id;
            
            // Get owner's details
            final ownerData = userDoc.data();
            rideData['ownerName'] = ownerData['name'] ?? 'Unknown';
            rideData['ownerEmail'] = ownerData['email'] ?? 'Unknown';
            rideData['ownerPhone'] = ownerData['phone'] ?? 'N/A';
            
            rides.add(rideData);
          }
        }
      }

      setState(() {
        acceptedRides = rides;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching accepted rides: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Accepted Rides'),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchAcceptedRides,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : acceptedRides.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions_car_outlined,
                        size: 80,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No accepted rides found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Rides you\'ve been accepted for will appear here',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _fetchAcceptedRides,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: acceptedRides.length,
                    itemBuilder: (context, index) {
                      final ride = acceptedRides[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              colors: [Colors.orange.shade50, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Ride Route
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.trip_origin,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        ride['PickupLoc'] ?? 'Unknown pickup',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        ride['DropLoc'] ?? 'Unknown destination',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(height: 20),
                                
                                // Ride Details
                                Row(
                                  children: [
                                    // Owner Info
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ride Owner',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            ride['ownerName'] ?? 'Unknown',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            ride['ownerPhone'] ?? 'N/A',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    
                                    // Fare
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Fare',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '₹${ride['Charge'] ?? 'N/A'}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                
                                // Travel Days
                                if (ride['Days'] != null && ride['Days'].isNotEmpty) ...[
                                  const SizedBox(height: 12),
                                  Text(
                                    'Travel Days',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Wrap(
                                    spacing: 4,
                                    children: (ride['Days'] as List<dynamic>)
                                        .map((day) => Chip(
                                              label: Text(
                                                day.toString(),
                                                style: const TextStyle(fontSize: 10),
                                              ),
                                              backgroundColor: Colors.orange.shade100,
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ))
                                        .toList(),
                                  ),
                                ],
                                
                                // Status Badge
                                const SizedBox(height: 12),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle,
                                        size: 16,
                                        color: Colors.green.shade700,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Accepted',
                                        style: TextStyle(
                                          color: Colors.green.shade700,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
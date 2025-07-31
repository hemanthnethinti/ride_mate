import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ride_mate/find_ride_page.dart';
import 'package:ride_mate/post_ride_page.dart';
import 'package:ride_mate/traveler_details.dart';
import 'package:ride_mate/widgets/app_drawer.dart';

class MyHome extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userPhone;

  final RideSearchDetails? rideDetails;

  const MyHome({
    super.key,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    this.rideDetails, 
  });

  @override
  State<MyHome> createState() => _MyHomeState();
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}


class _MyHomeState extends State<MyHome> {
  int _selectedIndex = 0;


class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {

    
    RideSearchDetails rideData = widget.rideDetails ??
        RideSearchDetails(
          from: "Coimbator",
          to: "Munnar",
          date: DateTime.now(),
          time: const TimeOfDay(hour: 10, minute: 0),
          genderPref: "Any",
          maxFare: 500,
          seats: 1,
          verifiedOnly: false,
        );

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: AppDrawer(
        userName: widget.userName,
        userEmail: widget.userEmail,
        userPhone: widget.userPhone,
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(

        title: const Text(
          'Ride Mate',
          style: TextStyle(
            fontSize: 30,
            color: Color(0xFFA34820),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          const SizedBox(width: 16),
          IconButton(
            onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TravelerDetails(
                    userName: widget.userName,
                    rideDetails: rideData,
                  ),
                ),
              );
            },
            icon: const Icon(FontAwesomeIcons.bell, size: 27),
          ),
          const SizedBox(width: 16),
        ],
        backgroundColor: Colors.orange,
      ),

      body:
          _selectedIndex == 0
              ? Padding(
                padding: const EdgeInsets.all(14.0),

      body: Padding(

        padding: const EdgeInsets.all(16),

        padding: const EdgeInsets.all(14.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'What are you\nLooking for?',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),


          
            _buildRideOption(
              title: "Offer A Ride",
              subtitle: "I need to fill empty seats",
              imageUrl:
                  "https://www.shutterstock.com/image-vector/happy-couple-young-people-rides-600nw-1619620189.jpg",
              buttonText: "Offer A Ride",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PostRidePage()));
              },
            ),

            const SizedBox(height: 20),

            
            _buildRideOption(
              title: "Find A Ride",
              subtitle: "I need a ride",
              imageUrl:
                  "https://png.pngtree.com/png-vector/20221129/ourmid/pngtree-illustration-of-a-vector-icon-for-a-ridesharing-app-or-taxi-cab-app-vector-png-image_42258176.jpg",
              buttonText: "Need A Ride",
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const FindRidePage()));
              },

            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),

                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const SafeArea(
                        child: Text(
                          'What are you\nLooking for?',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Offer A Ride',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'I need to fill empty seats',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Image.network(
                                    "https://www.shutterstock.com/image-vector/happy-couple-young-people-rides-600nw-1619620189.jpg",
                                    height: 130,
                                    width: 130,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const PostRidePage(),
                                    transitionsBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.ease;

                                      final tween = Tween(
                                        begin: begin,
                                        end: end,
                                      ).chain(CurveTween(curve: curve));
                                      final offsetAnimation = animation.drive(
                                        tween,
                                      );
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Offer A Ride',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 6,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Find A Ride',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'I need a ride',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  Image.network(
                                    "https://png.pngtree.com/png-vector/20221129/ourmid/pngtree-illustration-of-a-vector-icon-for-a-ridesharing-app-or-taxi-cab-app-vector-png-image_42258176.jpg",
                                    height: 150,
                                    width: 150,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const FindRidePage(),
                                    transitionsBuilder: (
                                      context,
                                      animation,
                                      secondaryAnimation,
                                      child,
                                    ) {
                                      const begin = Offset(1.0, 0.0);
                                      const end = Offset.zero;
                                      const curve = Curves.easeInOut;

                                      final tween = Tween(
                                        begin: begin,
                                        end: end,
                                      ).chain(CurveTween(curve: curve));

                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                    transitionDuration: const Duration(
                                      milliseconds: 250,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                minimumSize: const Size(double.infinity, 50),
                              ),
                              child: const Text(
                                'Need A Ride',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : Center(
                child: Text(
                  _selectedIndex == 1
                      ? 'My Posts (Coming Soon)'
                      : 'My Rides (Coming Soon)',
                  style: const TextStyle(fontSize: 18),
                ),
              ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'My Posts',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'My Rides'),
        ],
      ),
    );
  }


            ),
          ],
        ),
      ),
    );
  }

  
  Widget _buildRideOption({
    required String title,
    required String subtitle,
    required String imageUrl,
    required String buttonText,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(subtitle, style: const TextStyle(fontSize: 16)),
                ],
              ),
              Image.network(imageUrl, height: 150, width: 130),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(buttonText, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

}

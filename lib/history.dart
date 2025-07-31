import 'package:flutter/material.dart';
// import 'ride_details_page.dart';

class RideHistoryPage extends StatefulWidget {
  const RideHistoryPage({super.key});

  @override
  State<RideHistoryPage> createState() => _RideHistoryPageState();
}

class _RideHistoryPageState extends State<RideHistoryPage> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? selectedDate;

  final List<Map<String, dynamic>> rideHistory = [
    {
      "date": "2025-07-28",
      "from": "Hyderabad",
      "to": "Bangalore",
      "fare": "₹1200",
      "status": "Completed"
    },
    {
      "date": "2025-07-25",
      "from": "Chennai",
      "to": "Pondicherry",
      "fare": "₹500",
      "status": "Cancelled"
    },
    {
      "date": "2025-07-20",
      "from": "Delhi",
      "to": "Agra",
      "fare": "₹900",
      "status": "Completed"
    },
  ];

  List<Map<String, dynamic>> filteredRides = [];

  @override
  void initState() {
    super.initState();
    filteredRides = rideHistory;
  }

  void _filterRides(String query) {
    final results = rideHistory.where((ride) {
      final from = ride['from'].toLowerCase();
      final to = ride['to'].toLowerCase();
      final date = ride['date'].toLowerCase();
      final search = query.toLowerCase();

    
      final matchesSearch = from.contains(search) || to.contains(search) || date.contains(search);
      final matchesDate = selectedDate == null ||
          ride['date'] == _formatDate(selectedDate!);

      return matchesSearch && matchesDate;
    }).toList();

    setState(() {
      filteredRides = results;
    });
  }

  Future<void> _pickDate() async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      _filterRides(_searchController.text);
    }
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  void _clearDateFilter() {
    setState(() {
      selectedDate = null;
      _filterRides(_searchController.text);
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "Completed":
        return Colors.green;
      case "Cancelled":
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Ride History",style: TextStyle(fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        children: [
        
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterRides,
              decoration: InputDecoration(
                hintText: "Search by city or date...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today),
                  label: Text(selectedDate == null
                      ? "Filter by Date"
                      : "Date: ${_formatDate(selectedDate!)}",style: TextStyle(color: Colors.white,fontSize: 16),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange),
                ),
                if (selectedDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.red),
                    onPressed: _clearDateFilter,
                  ),
              ],
            ),
          ),
          SizedBox(height: 20,),
         
          Expanded(
            child: filteredRides.isEmpty
                ? const Center(child: Text("No rides found"))
                : ListView.builder(
                    itemCount: filteredRides.length,
                    itemBuilder: (context, index) {
                      final ride = filteredRides[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          leading: const Icon(Icons.directions_car, color: Colors.blue),
                          title: Text("${ride['from']} → ${ride['to']}"),
                          subtitle: Text("Date: ${ride['date']}"),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                ride['fare'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ride['status'],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: _getStatusColor(ride['status']),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => RideDetailsPage(ride: ride),
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
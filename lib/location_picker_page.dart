import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class LocationPickerPage extends StatefulWidget {
  const LocationPickerPage({super.key});

  @override
  _LocationPickerPageState createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  GoogleMapController? mapController;
  LatLng _selectedLatLng = const LatLng(20.5937, 78.9629); // Default: India
  String _address = "Move map to select location";

  void _onCameraIdle() async {
    if (mapController == null) return;

    final screenCenter = await mapController!.getLatLng(
      const ScreenCoordinate(x: 200, y: 300), // Adjust if needed
    );
    _selectedLatLng = screenCenter;

    try {
      final placemarks = await placemarkFromCoordinates(
        screenCenter.latitude,
        screenCenter.longitude,
      );
      final place = placemarks.first;
      setState(() {
        _address =
            "${place.name ?? ''}, ${place.locality ?? ''}, ${place.administrativeArea ?? ''}, ${place.country ?? ''}";
      });
    } catch (e) {
      setState(() {
        _address = "Unable to get address";
      });
    }
  }

  void _confirmLocation() {
    Navigator.pop(context, {
      'latLng': _selectedLatLng,
      'address': _address,
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Location"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _confirmLocation,
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _selectedLatLng,
              zoom: 14,
            ),
            onMapCreated: (controller) => mapController = controller,
            onCameraIdle: _onCameraIdle,
            onCameraMove: (position) {
              _selectedLatLng = position.target;
            },
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),

          // 📍 Pin Icon Fixed to Center
          Center(
            child: Icon(Icons.location_pin, size: 50, color: Colors.red),
          ),

          // 🗺️ Address Display Card
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _address,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

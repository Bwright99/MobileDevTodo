import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart' as places;

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? _mapController;
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();

  @override
  void dispose() {
    _mapController?.dispose();
    _originController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _calculateDirections() async {
    // You can also use the Places API here
    final places.GoogleMapsPlaces placesApi = places.GoogleMapsPlaces(
        apiKey: 'AIzaSyCsPydp8_-KDN2DrLMI5v8K2jUXxd-y5gg');

    // Get places details from the origin and destination text fields
    places.PlacesSearchResponse originResponse =
        await placesApi.searchByText(_originController.text);
    places.PlacesSearchResponse destinationResponse =
        await placesApi.searchByText(_destinationController.text);

    if (originResponse.status == "OK" && destinationResponse.status == "OK") {
      // Do something with the places details if needed
      // ...
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Unable to get places details')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Page with Places API')),
      body: Column(
        children: [
          // Input fields for origin and destination
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _originController,
              decoration: InputDecoration(labelText: 'Origin'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _destinationController,
              decoration: InputDecoration(labelText: 'Destination'),
            ),
          ),
          // Google Maps widget
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749,
                    -122.4194), // Set initial map position (San Francisco, CA)
                zoom: 12.0, // Initial zoom level
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _calculateDirections,
        child: Icon(Icons.directions),
      ),
    );
  }
}

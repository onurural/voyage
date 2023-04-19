import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ContactUsPage extends StatefulWidget {
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  late GoogleMapController mapController;
  final LatLng officeLocation = LatLng(40.7128, -74.0060); // Replace with your office coordinates

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            TypewriterAnimatedTextKit(
              text: ['Our Office Location'],
              textStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              speed: Duration(milliseconds: 200),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 250.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: officeLocation,
                  zoom: 14.0,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId('officeMarker'),
                    position: officeLocation,
                    infoWindow: InfoWindow(title: 'Voyage Office'),
                  ),
                },
              ),
            ),
            SizedBox(height: 30.0),
            TypewriterAnimatedTextKit(
              text: ['Phone Numbers'],
              textStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              speed: Duration(milliseconds: 200),
            ),
            SizedBox(height: 10.0),
            Text(
              '+90 (555) 555-5555\n+90 (444) 444-4444',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 30.0),
            TypewriterAnimatedTextKit(
              text: ['Email Address'],
              textStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              speed: Duration(milliseconds: 200),
            ),
            SizedBox(height: 10.0),
            Text(
              'info@voyage.com',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

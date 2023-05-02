// ignore_for_file: deprecated_member_use, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  late GoogleMapController mapController;
  final LatLng officeLocation = const LatLng(40.7128, -74.0060); // Replace with your office coordinates

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            TypewriterAnimatedTextKit(
              text: const ['Our Office Location'],
              textStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              speed: const Duration(milliseconds: 200),
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              height: 250.0,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: officeLocation,
                  zoom: 14.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('officeMarker'),
                    position: officeLocation,
                    infoWindow: const InfoWindow(title: 'Voyage Office'),
                  ),
                },
              ),
            ),
            const SizedBox(height: 30.0),
            TypewriterAnimatedTextKit(
              text: const ['Phone Numbers'],
              textStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              speed: const Duration(milliseconds: 200),
            ),
            const SizedBox(height: 10.0),
            const Text(
              '+90 (555) 555-5555\n+90 (444) 444-4444',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 30.0),
            TypewriterAnimatedTextKit(
              text: const ['Email Address'],
              textStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              speed: const Duration(milliseconds: 200),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'info@voyage.com',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

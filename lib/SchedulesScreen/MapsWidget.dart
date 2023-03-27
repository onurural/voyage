import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({Key? key}) : super(key: key);

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final LatLng _center = const LatLng(37.7749, -122.4194);
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    return  GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 10.0,
        ),

    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
  }
}
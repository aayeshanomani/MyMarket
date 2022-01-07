import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Map extends StatefulWidget {
  const Map();

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    print("location = "+_location.toString());
    _location.onLocationChanged.listen((l) {
      setState(() {
        _initialcameraposition = LatLng(l.latitude, l.longitude);
        print(l.latitude);
      });
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
        initialCameraPosition:
            CameraPosition(target: _initialcameraposition),
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        myLocationEnabled: true,
        markers: [
          Marker(
              markerId: MarkerId("01"),
              position: _initialcameraposition,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue))
        ].toSet()
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:mymarket/services/database.dart';
import 'package:mymarket/services/widgets.dart';

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
    print("location = " + _location.toString());
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
    return StreamBuilder(
        stream: Database().getApprovedSellers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: CircularProgressIndicator(
              color: Color(0xffDF3B57),
            ));
          return GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              markers: [
                for (int i = 0; i < snapshot.data.documents.length; i++)
                  Marker(
                      markerId: MarkerId(i.toString()),
                      position: LatLng(snapshot.data.documents[i]["shopLat"],snapshot.data.documents[i]["shopLong"]),
                      onTap: () {
                        showMyDialog(
                            context,
                            snapshot.data.documents[i]["shopName"],
                            snapshot.data.documents[i]["shopAddress"],
                            "\n"+snapshot.data.documents[i]["name"]);
                      },
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue))
              ].toSet());
        });
  }
}

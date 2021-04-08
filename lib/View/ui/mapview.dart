import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart' as geoco;
import 'package:google_maps_flutter/google_maps_flutter.dart';




class MymapPage extends StatefulWidget {
  @override
  _MymapPageState createState() => _MymapPageState();
}

class _MymapPageState extends State<MymapPage> {


  var adress;
  var country;
  var postal;


  GoogleMapController googleMapController;
  Map<MarkerId,Marker> marker = <MarkerId,Marker>{};
  Position position;

  void getMarker(double lat,double long){
    MarkerId markerId = MarkerId((lat.toString() + long.toString()));

    Marker markers = Marker(
        markerId: markerId,
        position: LatLng(lat,long),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        infoWindow: InfoWindow(snippet: "Address")
    );
    setState(() {
      marker[markerId]= markers;
    });

  }

  void getcurrentLocation() async{

    Position currentposition = await Geolocator().getCurrentPosition();
    setState(() {

      position=currentposition;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentLocation();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: GoogleMap(
                onTap: (tapped) async{
                  final coordinates = geoco.Coordinates(tapped.latitude,tapped.longitude);
                  print(coordinates.toString());
                  var address = await geoco.Geocoder.local.findAddressesFromCoordinates(coordinates);
                  var firstadress = address.first;
                  print(firstadress.addressLine);
                  getMarker(tapped.latitude, tapped.longitude);
                  setState(() {
                    adress = firstadress.addressLine;
                    country = firstadress.countryCode;
                    postal = firstadress.postalCode;
                  });
                  await FirebaseFirestore.instance.collection("location").add(
                      {
                        "latitude":tapped.latitude,
                        "longitude":tapped.longitude,
                        "Adress":firstadress.addressLine,
                        "country":firstadress.countryCode,
                        "postalcode":firstadress.postalCode
                      });
                },
                mapType: MapType.normal,
                compassEnabled: true,
                trafficEnabled: true,
                onMapCreated: (GoogleMapController controller){
                  setState(() {
                    googleMapController = controller;
                  });
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(position.latitude.toDouble(),position.longitude.toDouble()),
                    zoom: 15.0
                ),
                markers: Set<Marker>.of(
                    marker.values
                ) ,
              ),
            ),
            Text(
                "Address : $adress"
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart' as geoco;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rantal/View/ui/postproperties.dart';




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
  Position position = Position(latitude: 21.233612281366966,longitude:72.82677624374628);

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
    var status = await Permission.location.status;
    if (!status.isGranted) {
      await Permission.location.request();
    }
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
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: GoogleMap(
            onTap: (tapped) async{
              final coordinates = geoco.Coordinates(tapped.latitude,tapped.longitude);
              print(coordinates.toString());
              var address = await geoco.Geocoder.local.findAddressesFromCoordinates(coordinates);
              var firstadress = address.first;
              print(firstadress.addressLine);

              showDialog(context: context, builder:(context){
                return AlertDialog(
                  title: Text("Conform Address"),
                  content:Text(
                      "Address : $adress"
                  ) ,
                  actions: [
                    ElevatedButton(
                        onPressed: ()async{
                          getMarker(tapped.latitude, tapped.longitude);
                          await FirebaseFirestore.instance.collection("location").add(
                              {
                                "latitude":tapped.latitude,
                                "longitude":tapped.longitude,
                                "Adress":firstadress.addressLine,
                                "country":firstadress.countryCode,
                                "postalcode":firstadress.postalCode
                              });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PostProperties()));
                        },
                        child: Text("Confirm")),
                    TextButton(onPressed:()=> Navigator.pop(context), child: Text("Cancel")),
                  ],
                );
              });

              setState(() {
                adress = firstadress.addressLine;
                country = firstadress.countryCode;
                postal = firstadress.postalCode;
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
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}

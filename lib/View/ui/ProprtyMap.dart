import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController googleMapController;
  Map<MarkerId,Marker> markers = <MarkerId,Marker>{};


  void initMarker(specify,specifyId){
    var markerIdval=specifyId;
    final MarkerId markerId=MarkerId(markerIdval);
    final Marker marker=Marker(markerId: markerId,
        position: LatLng(specify['latitude'],specify['longitude']),
        infoWindow: InfoWindow(title: "property",snippet: specify['Adress'])
    );
    setState(() {
      markers[markerId]=marker;
    });
  }


  getMarkerData() async{
   await FirebaseFirestore.instance.collection('location').get().then((value){
      if(value.docs.isNotEmpty){
        for(int i=0;i<value.docs.length;i++){
            initMarker(value.docs[i].data(), value.docs[i].id);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMarkerData();
  }

  @override
  Widget build(BuildContext context) {

    Set<Marker> getMarker(){
      return <Marker>[Marker(
        markerId: MarkerId('My home'),
        position: LatLng(22.1205, 72.823212),
        infoWindow: InfoWindow(title: "Property"),
        icon: BitmapDescriptor.defaultMarker,
      ),].toSet();
    }
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(markers.values),
        mapType: MapType.normal,
        compassEnabled: true,
        trafficEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          setState(() {
            googleMapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
            target: LatLng(
               22.1205, 72.823212),
            zoom: 15.0),

      ),
    );
  }
}

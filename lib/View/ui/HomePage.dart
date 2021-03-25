import 'dart:async';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rantal/View/ui/Home.dart';
import 'package:rantal/View/ui/disconnectedPage.dart';
import 'package:rantal/View/ui/postproperties.dart';
import 'package:rantal/View/util/utisUi.dart';
import '../ui/Favorites.dart';
import '../ui/user.dart';
import 'Search.dart';


class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  //for connection
  //ConnectivityResult _connectionStatus = ConnectivityResult.none;
  //final Connectivity _connectivity = Connectivity();
 // StreamSubscription<ConnectivityResult> _connectivitySubscription;

  SolidController _controller = SolidController();


  @override
  void initState() {
    super.initState();
    //initConnectivity();

  //  _connectivitySubscription =
     //   _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }
 /* Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }
*/
  /*Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }*/
  int _selectedTab = 0;
  final _pageOptions = [
    Home(),
    PostProperties(),
    FavoritesPage(),

  ];
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: BackdropScaffold(
        frontLayerBorderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),),
        resizeToAvoidBottomInset: false,
        backLayerBackgroundColor: AppbarIconColor,

        headerHeight: 300.0,
        backgroundColor: Colors.white,

        appBar: BackdropAppBar(
          primary: false,
          //r automaticallyImplyLeading: true,
          backgroundColor: AppbarIconColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const Text("Current Location",style: TextStyle(
                        fontSize: 10.0
                    ),),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        Text("Surat")
                      ],
                    )
                  ],
                ),

              ),
             IconButton(icon: Icon(Icons.search_rounded), onPressed: (){
               _controller.isOpened ? _controller.hide() : _controller.show();
             })
             /* InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PostProperties()));
                },
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: colorlist[7],
                  ),

                  height: 40,
                  width: 80,
                  child: Center(child: Text("Post",style:GoogleFonts.robotoSlab(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
                  ),
                  ),*/
            ],
          ),
        ),
        frontLayer:
             Stack(
              children: <Widget>[
                _pageOptions[_selectedTab],
                Container(
                    child: Align(
                      alignment: Alignment(0.0, 1.0),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20,left: 20, right: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          child: BottomNavigationBar(
                            type: BottomNavigationBarType.fixed,
                            showSelectedLabels: false,
                            showUnselectedLabels: false,
                            backgroundColor: colorlist[1],
                            elevation: 0,
                            currentIndex: _selectedTab,
                           // fixedColor: AppbarIconColor,
                            selectedItemColor: Colors.white,
                            unselectedItemColor: Colors.grey,
                            onTap: (int index) {
                              setState(() {
                                _selectedTab = index;
                              });
                            },

                            items: [
                              BottomNavigationBarItem(
                                icon: Icon(Icons.home),
                                label:
                                  'Home',
                              ),
                              BottomNavigationBarItem(
                                icon: Icon(Icons.add_rounded),

                                label:
                                  'Inbox',

                              ),

                              BottomNavigationBarItem(
                                icon: Icon(Icons.favorite_rounded),
                                label:
                                  'Profile',
                              ),


                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            ),
        bottomSheet: SolidBottomSheet(
          controller: _controller,
          draggableBody: true,
          maxHeight: MediaQuery.of(context).size.height - 119,
          body: SingleChildScrollView(child: searchPage()),
        ),
      ),
    );
  }
}

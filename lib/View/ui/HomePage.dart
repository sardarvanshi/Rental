import 'dart:async';
import 'package:rantal/Provider/AuthProvider.dart';
import 'package:rantal/View/auth/auth.dart';
import 'package:rantal/config/palette.dart';
import 'package:rantal/model/admindata.dart';
import 'package:rantal/model/userinfo_model.dart';
import 'package:rantal/post/Personal_details.dart';
import 'package:rantal/post/THEMES.dart';
import 'package:rantal/post/postHome.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rantal/View/ui/Home.dart';
import 'package:rantal/View/ui/disconnectedPage.dart';
import 'package:rantal/View/ui/postproperties.dart';
import 'package:rantal/View/util/utisUi.dart';
import '../ui/Favorites.dart';
import '../ui/user.dart';
import 'ProprtyMap.dart';
import 'Search.dart';
import 'mapview.dart';


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

  List<String> mycity = [
    "surat",
    "katargam",
    "varachha",
    "vesu",
    "sarthana"
        "Kerla"
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedTab = 0;
  final _pageOptions = [
    Home(),
    FavoritesPage(),
    Post(),
    // Properties(),
    //PostProperties(),
    ProfilePage(),
  ];

  void _openDrawer() {}

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<userinfo>(create: (_) => userinfo(context)),
          Provider<adminData>(create: (_) => adminData()),
        ],
        builder: (context, child) {
          return SafeArea(
            child: Scaffold(
              primary: false,
              key: _scaffoldKey,
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                primary: false,
                //r automaticallyImplyLeading: true,
                backgroundColor: Color(0XFFEEF3F7),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                              ),
                              Text("Surat",
                                  style: GoogleFonts.robotoSlab(
                                      color: Colors.white))
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: IconButton(
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            /*Navigator.push(context, MaterialPageRoute(
                            builder: (context) => searchPage()));*/
                          }),
                    )
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
              /*backLayer: Column(
              children: [
                Center(

                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: colorlist[2],
                      ),
                      onPressed: () async {
                        context.read<AuthenticationProvider>().signOut();
                        Navigator.pushReplacement(context, (MaterialPageRoute(
                            builder: (context) => AuthScreen())));
                      },
                      child: Text("Log out"),
                    ),
                  ),
                ),
                Center(

                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: colorlist[2],
                      ),
                      onPressed: () async {
                        await Future.delayed(Duration(seconds: 5));
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => MymapPage()), (
                            Route<dynamic> route) => false);
                      },
                      child: Text("Map"),
                    ),
                  ),
                ),
              ],
            ),*/
              body: Stack(
                children: <Widget>[
                  _pageOptions[_selectedTab],
                  Container(
                      child: Align(
                    alignment: Alignment(0.0, 1.0),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          backgroundColor: AppbarIconColor,
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
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.favorite),
                              label: 'Home',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.add_rounded),
                              label: 'Inbox',
                            ),
                            BottomNavigationBarItem(
                              icon: Icon(Icons.account_circle_outlined),
                              label: 'Profile',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ))
                ],
              ),
              drawer: Drawer(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('This is the Drawer'),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Close Drawer'),
                      ),
                    ],
                  ),
                ),
              ),
              // Disable opening the drawer with a swipe gesture.
            ),
          );
        });
  }
}

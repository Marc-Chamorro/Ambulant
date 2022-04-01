import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import '../home/home_screen.dart' as s_home;
//import '../favourites/favourites_screen.dart';
//import '../scan/scan_screen.dart';
import '../map/map_screen.dart' as s_map;
//import '../settings/settings_screen.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../settings/settings_screen.dart' as s_settings;
import '../favourites/favourites_screen.dart' as s_favorites;
import '../scan/scan_screen.dart' as s_scan;

import 'package:ambulant_project/widget/main_body/bottom_buttons.dart';
import 'package:ambulant_project/widget/appbar/default_appbar.dart';
import '../../widget/geolocation/get_user_position.dart';

//
class AppBody extends StatefulWidget {
  const AppBody({Key? key}) : super(key: key);

  @override
  State<AppBody> createState() => _ChooseType();
}

class _ChooseType extends State<AppBody> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    checkPosition();
    setState(() {  });
    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(constant.window),
      backgroundColor: constant.ColorSecondBackground,
      body: _body(constant.window),
      bottomNavigationBar: BottomButtons(notifyParent: refresh,),//_bottomButtons(),
    );
  }

  refresh() {
    setState(() {});
  }

  _body(String window) {
    if (window == "home_screen") {
      setState(() {  });
      return s_home.HomeScreen(values: window);
    } else if (window == "favorite_screen") {
      setState(() {  });
      return s_favorites.FavouritesScreen(values: window);
    } else if (window == "scan_screen") {
      setState(() {  });
      return s_scan.Scanscreen(values: window);
    } else if (window == "map_screen") {
      setState(() {  });
      return s_map.MapScreen(values: window);
    } else if (window == "settings_screen") {
      return s_settings.SettingsScreen(values: window);
    }
  }

  _appBar(String window) {
    setState(() {  });
    
    if (window == "settings_screen" || window == "map_screen") {
      return new DefaultAppBar().Appbar();
    }
  }

  // _checkPosition() async {
  //   Location location = new Location();
  //   //bool _serviceEnabled;
  //   //PermissionStatus _permissionGranted;
  //   LocationData _locationData;
  //   constant.serviceEnabled = await location.serviceEnabled() as bool;
  //   if (!constant.serviceEnabled) {
  //     constant.serviceEnabled = await location.requestService() as bool;
  //     if (!constant.serviceEnabled) {
  //       _returnLastPosition();
  //       return;
  //     }
  //   }
  //   constant.permissionGranted = await location.hasPermission() as PermissionStatus;
  //   if (constant.permissionGranted == PermissionStatus.denied) {
  //     constant.permissionGranted = await location.requestPermission() as PermissionStatus;
  //     if (constant.permissionGranted != PermissionStatus.granted) {
  //       _returnLastPosition();
  //       return;
  //     }
  //   }
  //   _locationData = await location.getLocation() as LocationData;
  //   constant.lat = _locationData.latitude!;
  //   constant.long = _locationData.longitude!;
  //   //setState(() { lat = _locationData.latitude!; long = _locationData.longitude!; });
  //   print(_locationData.toString());

  //   // location.onLocationChanged.listen((LocationData currentLocation) async {
  //   //   _locationData = await location.getLocation() as LocationData;
  //   //   lat = _locationData.latitude!;
  //   //   long = _locationData.longitude!;
  //   //   print(_locationData);
  //   // });
  // }

  // _initialCameraPosition() {
  //   constant.kGooglePlex = CameraPosition(
  //     target: LatLng(constant.lat, constant.long),
  //     zoom: 14.4746,
  //   );
  // }

  // _returnLastPosition() async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   var collection = FirebaseFirestore.instance.collection('users').doc(constant.user_id); //.where("password", isEqualTo: "12345aA");
  //   var querySnapshots = await collection.get();

  //   constant.lat = querySnapshots['geoposition'].latitide;
  //   constant.long = querySnapshots['geoposition'].longitude;

  //   //setState(() { lat = querySnapshots['geoposition'].latitide; long = querySnapshots['geoposition'].longitude; });

  //   print(constant.lat);
  //   print(constant.long);
  // }

  // _body(String window) {
  //   if (window == "home_screen") {
  //     setState(() {  });
  //     return s_home.HomeScreen(values: window);
  //   } else if (window == "favorite_screen") {
  //   } else if (window == "scan_screen") {
  //     //return _scanScreen();
  //   } else if (window == "map_screen") {
  //     setState(() {  });
  //     return s_map.MapScreen(values: window);
  //   } else if (window == "settings_screen") {
  //     return s_settings.SettingsScreen(values: window);
  //   }
  // }

  // _bottomButtons() {
  //   return Row(
  //       mainAxisSize: MainAxisSize.max,
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         // BoxDecoration(
  //         //     border: Border(
  //         //     top: BorderSide(width: 2.0, color: Colors.lightBlue.shade600),
  //         //     //bottom: BorderSide(width: 16.0, color: Colors.lightBlue.shade900),
  //         //   ),
  //         // )
  //         // new Divider(
  //         //   color: Colors.red,
  //         // ),
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.2,
  //           height: 60,
  //           decoration: BoxDecoration(
  //             color: Color(0xFFFFFFFF),
  //             //border: Border.all(color: Colors.blueAccent),
  //             border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
  //           ),
  //           child: InkWell(
  //             onTap: () async {
  //               setState(() {
  //                 constant.window = "home_screen";
  //               });
  //             },
  //             child: const Icon(
  //               Icons.home,
  //               color: Colors.black,
  //               size: 24,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.2,
  //           height: 60,
  //           decoration: BoxDecoration(
  //             color: Color(0xFFFFFFFF),
  //             border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
  //           ),
  //           child: InkWell(
  //             onTap: () async {
  //               setState(() {
  //                 constant.window = "favorite_screen";
  //               });
  //             },
  //             child: const Icon(
  //               Icons.favorite_border,
  //               color: Colors.black,
  //               size: 24,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.2,
  //           height: 60,
  //           decoration: BoxDecoration(
  //             color: Color(0xFFFFFFFF),
  //             border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
  //           ),
  //           child: InkWell(
  //             onTap: () async {
  //               setState(() {
  //                 constant.window = "scan_screen";
  //               });
  //             },
  //             child: const Icon(
  //               Icons.qr_code_scanner,
  //               color: Colors.black,
  //               size: 24,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.2,
  //           height: 60,
  //           decoration: BoxDecoration(
  //             color: Color(0xFFFFFFFF),
  //             border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
  //           ),
  //           child: InkWell(
  //             onTap: () async {
  //               setState(() {
  //                 constant.window = "map_screen";
  //               });
  //             },
  //             child: const Icon(
  //               Icons.room,
  //               color: Colors.black,
  //               size: 24,
  //             ),
  //           ),
  //         ),
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.2,
  //           height: 60,
  //           decoration: BoxDecoration(
  //             color: Color(0xFFFFFFFF),
  //             border: Border(top: BorderSide(width: 2.0, color: constant.ColorSecondTextColor)),
  //           ),
  //           child: InkWell(
  //             onTap: () async {
  //               setState(() {
  //                 constant.window = "settings_screen";
  //               });
  //             },
  //             child: const Icon(
  //               Icons.settings,
  //               color: Colors.black,
  //               size: 24,
  //             ),
  //           ),
  //         )
  //       ]);
  // }

  // _settingsScreen() {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return SettingsScreen();
  //     }),
  //     (route) => false,
  //   );
  // }

  // _mapScreen() {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return MapScreen();
  //     }),
  //     (route) => false,
  //   );
  // }

  // _scanScreen() {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return ScanScreen();
  //     }),
  //     (route) => false,
  //   );
  // }

  // _favoriteScreen() {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) {
  //       return FavouritesScreen();
  //     }),
  //     (route) => false,
  //   );
  // }

  // _homeScreen() {
  //Navigator.pushAndRemoveUntil(
  //context,
  // MaterialPageRoute(builder: (context) {
  // return HomeScreen();
  // });//,
  //(route) => false,
  //);
  // }
}

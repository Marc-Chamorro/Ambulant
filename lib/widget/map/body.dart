import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../constant/constant.dart' as constant;
import 'package:location/location.dart';
import 'dart:math';
import '../../widget/geolocation/get_user_position.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
//import 'package:geolocator/geolocator.dart';

class LocalMapScreen extends StatefulWidget {
  final Function() notifyParent;
  LocalMapScreen({Key? key, required this.notifyParent}) : super(key: key);


  @override
  _LocalMapScreen createState() => _LocalMapScreen();
}

class _LocalMapScreen extends State<LocalMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int numberOfMarkers = 0;
  bool firstTimeUserMarker = false;
  bool firstTimeInitialCameraPosition = false;
  bool firstTimeGetShops = false;
  late Timer mytimer, time;
  var querySnapshotsLocals;

  String LocalEscollitNom = "";
  String LocalEscollitID = "";
  double LocalLat = 0;
  double LocalLon = 0;
  // String LocalDistancia = "";
  // String LocalPrice = "";
  // String LocalDescription = "";
  // String LocalImg = "";
  // bool   LocalState = true;


  @override
  void initState() {
    mytimer = Timer.periodic(
      const Duration(seconds: 5), (timer) {
        DateTime timenow = DateTime.now();  //get current date and time
        print(timenow.hour.toString() + ":" + timenow.minute.toString() + ":" + timenow.second.toString()); 
      
        _getUserPosition();
        _userMarker();
      }
    );
    time = Timer.periodic(
      const Duration(seconds: 300), (timer) {
        DateTime timenow = DateTime.now();  //get current date and time
        print(timenow.hour.toString() + ":" + timenow.minute.toString() + ":" + timenow.second.toString()); 
      
        _saveDataPosition();
        _getShop();
      }
    );

    if (constant.window == "home_screen") {
      LocalEscollitNom = constant.nomLocalEscollit;
      LocalEscollitID = constant.localEscollitID;
      LocalLat = constant.localLat;
      LocalLon = constant.localLon;
      // LocalDistancia = "";
      // LocalPrice = "";
      // LocalDescription = "";
      // LocalImg = "";
      // LocalState = true;
    } else if (constant.window == "favorite_screen") {
      LocalEscollitNom = constant.fnomLocalEscollit;
      LocalEscollitID = constant.flocalEscollitID;
      LocalLat = constant.flocalLat;
      LocalLon = constant.localLon;
      // LocalDistancia = "";
      // LocalPrice = "";
      // LocalDescription = "";
      // LocalImg = "";
      // LocalState = true;
    }
  }

  @override
  void dispose() {
    mytimer.cancel();
    time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    //getUserNearbyPosition();

    if (!firstTimeInitialCameraPosition) {
      _initialCameraPosition();
      firstTimeInitialCameraPosition = true;
    }

    if (!firstTimeUserMarker) {
      _userMarker();
      _createPolylines(constant.lat, constant.long, LocalLat, LocalLon);
      firstTimeUserMarker = true;
    }

    if (!firstTimeGetShops) {
      _add(LocalEscollitID, LocalEscollitNom, LocalLat, LocalLon);
      firstTimeGetShops = true;
    }


  return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      _appBarBackButton(LocalEscollitNom, "local_escollit"),
        Expanded(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child:
                    Stack(
                      children: <Widget>[
                        GoogleMap(
                          mapType: MapType.normal,
                          initialCameraPosition: constant.kGooglePlex,
                          markers: Set<Marker>.of(markers.values),
                          compassEnabled: true,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,

                          polylines: Set<Polyline>.of(polylines.values),
                          
                          onMapCreated: (GoogleMapController controller){
                            _controller.complete(controller);
                          },
                        ),
                      ]
                    ),
                  ),
                ],
              ),
            ]
          )
        )
      ]
    );
  }

  _appBarBackButton(String text, String page_to_open) {
    if (constant.window == "home_screen") {
      return AppBar(
        backgroundColor: Color(0xFFFFB300),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () { 
            setState(() { constant.homeScreenChoosenType = page_to_open; });
            widget.notifyParent();
          },
          child: Icon(
            Icons.keyboard_backspace,
          ),
        ),
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
          child: Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Lexend Deca',
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      );
    } else {
      return AppBar(
        backgroundColor: Color(0xFFFFB300),
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () { 
            setState(() { constant.favoriteScreenChoosenType = page_to_open; });
            widget.notifyParent();
          },
          child: Icon(
            Icons.keyboard_backspace,
          ),
        ),
        title: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 10),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Lexend Deca',
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      );
    }
    
  }

  _initialCameraPosition() {
    constant.kGooglePlex = CameraPosition(
      target: LatLng(constant.lat, constant.long),
      zoom: 14.4746,
    );
  }

  _userMarker() async {
    var markerIdVal = "user";
    MarkerId markerId = MarkerId(markerIdVal.toString());

    Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        constant.lat,
        constant.long,
      ),
      onTap: () {
        _showInfo(markerId);
      },
      icon: //BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 1.0, size: Size(30, 50)), 'assets/images/icon-yellow-position.png'),
    );
    
    setState(() {
      markers[markerId] = marker;
      numberOfMarkers++;
    });
  }

  _showInfo(markerId) {
    print(markerId);
    return AlertDialog(
      content: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
                setState(() {
                  
                });
              },
              child: const CircleAvatar(
                child: const Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          // Form(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: TextFormField(),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: TextFormField(),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: RaisedButton(
          //           child: const Text("Submitß"),
          //           onPressed: () {
          //             print('it was clicked');
          //           },
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  _getUserPosition() async {
    Location location = new Location();
    LocationData _locationData;
    _locationData = await location.getLocation() as LocationData;
    constant.lat = _locationData.latitude!;
    constant.long = _locationData.longitude!;
    print(constant.lat);
    print(constant.long);
  }

  _saveDataPosition() async {
    FirebaseFirestore.instance.collection('users')
    .doc(constant.user_id)
    .update(
      {
        'geoposition': GeoPoint(constant.lat, constant.long)
      }
    );
  }

  _getShop() async {
    querySnapshotsLocals = await FirebaseFirestore.instance.collection('local').doc(constant.localEscollitID).get();

    double Qlon = querySnapshotsLocals.data['location'].longitude;
    double Qlat = querySnapshotsLocals.data['location'].latitude;

    _add(LocalEscollitID, LocalEscollitNom, Qlat, Qlon);
  }

  void _add(String QdocumentID, String Qname, double Qlat, double Qlon) {
    var markerIdVal = Qname;
    final MarkerId markerId = MarkerId(QdocumentID);
    
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(
        Qlat,
        Qlon,
      ),
      infoWindow: InfoWindow(
        title: markerIdVal,/*, snippet: 'More details here'*/
        onTap: () {
          if (constant.window == "home_screen") {
            setState(() { constant.homeScreenChoosenType = "local_escollit"; });
            widget.notifyParent();
          } else {
            setState(() { constant.favoriteScreenChoosenType = "local_escollit"; });
            widget.notifyParent();
          }
        },
      ),
      onTap: () {
        _showInfo(markerId);
      },
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );

    //AIXO HA PETAT
    setState(() {
      markers[markerId] = marker;
      numberOfMarkers++;
    });
  }

  ////////////////////////LINE BETWEEN THE POINTS
  // Object for PolylinePoints
  late PolylinePoints polylinePoints;
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];
  // Map storing polylines created by connecting two points
  Map<PolylineId, Polyline> polylines = {};

  // Create the polylines for showing the route between two places

  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    // Initializing PolylinePoints
    polylinePoints = PolylinePoints();

    ////////////////////////////////////// GTE THE GOOGLE MAPS API KEY

    //////////////////////////////////////

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      constant.google_maps_apikey, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    PolylineId id = PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );

    // Adding the polyline to the map
    polylines[id] = polyline;

    setState(() {
      
    });
  }
}
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
//import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key, required String values}) : super(key: key);

  @override
  State<MapScreen> createState() => MapSampleState();
}

class MapSampleState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  int numberOfMarkers = 0;
  bool firstTimeUserMarker = false;
  bool firstTimeInitialCameraPosition = false;
  bool firstTimeGetShops = false;
  late Timer mytimer, time;
  var querySnapshotsLocals;
  // late GeoPoint lesserGeopoint;
  // late GeoPoint greaterGeopoint;

  @override
  void initState() {
    mytimer = Timer.periodic(
      const Duration(seconds: 15), (timer) {
        DateTime timenow = DateTime.now();  //get current date and time
        print(timenow.hour.toString() + ":" + timenow.minute.toString() + ":" + timenow.second.toString()); 
      
        _getUserPosition();
        _saveDataPosition();
        _userMarker();
      }
    );
    time = Timer.periodic(
      const Duration(seconds: 60), (timer) {
        DateTime timenow = DateTime.now();  //get current date and time
        print(timenow.hour.toString() + ":" + timenow.minute.toString() + ":" + timenow.second.toString()); 
      
        _getShops();
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }

    getUserNearbyPosition();

    if (!firstTimeInitialCameraPosition) {
      _initialCameraPosition();
      firstTimeInitialCameraPosition = true;
    }

    if (!firstTimeUserMarker) {
      _userMarker();
      firstTimeUserMarker = true;
    }

    if (!firstTimeGetShops) {
      _getShops();
      firstTimeGetShops = true;
    }

    return Column(
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
                
                onMapCreated: (GoogleMapController controller){
                  _controller.complete(controller);
                },
              ),

            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20.0),
                  height: 150.0,
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance.collection('local').where("location", isGreaterThan: constant.lesserGeopoint).where("location", isLessThan: constant.greaterGeopoint).where("open", isEqualTo: true).get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if (snapshot.hasData) {
                        //if (snapshot.data.docs.length > 0)
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: constant.ColorPrimary)
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (BuildContext context, int index){
                              //return _returnBoxes(snapshot, index);
                              String QdocumentID = snapshot.data.docs[index].id;
                              String Qname = snapshot.data.docs[index]['name'].toString();
                              double Qlat = snapshot.data.docs[index]['location'].latitude;
                              double Qlon = snapshot.data.docs[index]['location'].longitude;
                              String Qimg = snapshot.data.docs[index]['image'].toString();
                              String Qinx = snapshot.data.docs[index]['index'].toString();

                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: _boxes(Qimg, Qlat, Qlon, Qname, Qinx),
                              );
                            }
                          ),
                        );
                      }
                      return Center(child: Container(child: CircularProgressIndicator()));
                    }
                  )
                )
              ),
            ]
          ),
        ),
      ],
    );
    
  }

  @override
  void dispose() {
    mytimer.cancel();
    time.cancel();
    super.dispose();
  }

  _returnBoxes(snapshot, int index) async {

    String QdocumentID = snapshot.data.docs[index].id;
    String Qname = snapshot.data.docs[index]['name'].toString();
    double Qlat = snapshot.data.docs[index]['location'].latitude;
    double Qlon = snapshot.data.docs[index]['location'].longitude;
    String Qimg = snapshot.data.docs[index]['image'].toString();
    String Qinx = snapshot.data.docs[index]['index'].toString();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: _boxes(Qimg, Qlat, Qlon, Qname, Qinx),
    );
  }

  Widget _boxes(String image, double lat, double lon, String restaurantName, String indx) {
    return GestureDetector(
      onTap: () {print('A LOCAL HAS BEEN SELECTED'); _gotoLocation(lat, lon);},
      child: Container(
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        child: new FittedBox(
          child: Material(
            color: Colors.white.withOpacity(0.5),
            elevation: 14.0,
            borderRadius: BorderRadius.circular(28.0),
            shadowColor: Colors.transparent,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 250,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: new BorderRadius.circular(28.0),
                    child: Image(fit: BoxFit.fill, image: NetworkImage(image)),
                  ),
                ),
                Container(
                  width: 250,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          indx.capitalize(),
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          restaurantName,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Distance: " + _returnDistance(constant.lat, constant.long, lat, lon).toString(),
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ]
                    ),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  String _returnDistance(double lat1, double lon1, double lat2, double lon2) {
    double distancia = _calculateDistanceMeters(lat1, lon1, lat2, lon2);

    if (distancia > 1) {
      return distancia.toStringAsFixed(2) + " km";
    } else
    distancia = distancia * 1000;
    return distancia.toStringAsFixed(0) + " m";
  }

  double _calculateDistanceMeters(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> _gotoLocation(double lat, double lon) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lon), zoom: 18)));
  }

  _getShops() async {
    var collection = FirebaseFirestore.instance.collection('local').where("location", isGreaterThan: constant.lesserGeopoint);
    collection = collection.where("location", isLessThan: constant.greaterGeopoint);
    collection = collection.where("open", isEqualTo: true);
    querySnapshotsLocals = await collection.get();

    for (var snapshot in querySnapshotsLocals.docs) {
      String QdocumentID = snapshot.id;
      String Qname = snapshot['name'].toString();
      double Qlat = snapshot['location'].latitude;
      double Qlon = snapshot['location'].longitude;
      String description = snapshot['description'].toString();
      String type = snapshot['index'].toString();

      print(QdocumentID);
      print(Qname);
      print(Qlat + Qlon);

      _add(QdocumentID, Qname, Qlat, Qlon, description, type);
    }
  }

  void _add(String QdocumentID, String Qname, double Qlat, double Qlon, String description, String type) {
      var markerIdVal = Qname;
      final MarkerId markerId = MarkerId(QdocumentID);
      
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          Qlat,
          Qlon,
        ),
        infoWindow: InfoWindow(
          title: markerIdVal,
          snippet: 'Press for more',
          onTap: () {
            _popUpMoreDetails(context, Qname, description, type);
          }
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

  _popUpMoreDetails(BuildContext context, String name, String description, String type) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            height: 275,
            child: Column(
              children: [
                // Expanded(
                //   child: 
                  Container(
                    height: 50,
                    color: Colors.white70,
                    child: //Text(name),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                      child: Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                      
                  ),
                // ),
                Expanded(
                  child: Container(
                    color: Color(0xFFFFB300),
                    child: SizedBox.expand(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            Container(
                              height: 125,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Text(
                                      type.replaceFirst(type[0], type[0].toUpperCase()),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Text(description),
                                  ],
                                ),
                              ),
                            ),
                            
                            
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF595858),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
    
    // return showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Container(
    //       height: 350,
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         shape: BoxShape.rectangle,
    //         borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
    //       ),
    //       child: Column(
    //         children: <Widget> [
    //           Container(
    //             child: Padding(
    //               padding: const EdgeInsets.all(12.0),
    //               child: Text('Local Name'), //or image or whatever
    //             ),
    //             width: double.infinity,
    //             decoration: BoxDecoration(
    //               color: Colors.yellow,
    //               shape: BoxShape.rectangle,
    //               borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
    //             ),
    //           ),
    //           SizedBox(height: 24,),
    //           Text('General local data in here, title style'),
    //           SizedBox(height: 8,),
    //           Padding(
    //             padding: const EdgeInsets.only(right: 16, left: 16),
    //             child: Text('local description in here beybe, ABCDEFGHIJKLMNOPQRSTUWXYZ ABCDEFGHIJKLMNOPQRSTUVWXYZ'),
    //           ),
    //           SizedBox(height: 24,),
    //           Row(
    //             mainAxisSize: MainAxisSize.min,
    //             children: [
    //               //ADD THE CUSTOM BUTTON THAT FOUND ON YOUTUBE THAT WAS COOL LOOKING
    //               Text('Close button'),
    //             ],
    //           ),
    //         ],
    //       ),
    //       // backgroundColor: Colors.transparent,
    //       // body: Container(
    //       //   child: Column(
    //       //     children: [
    //       //       Text('Test'),
    //       //       IconButton(
    //       //                   icon: Icon(Icons.ac_unit),
    //       //                   onPressed: () {
    //       //                     Navigator.pop(context);
    //       //                   },
    //       //                 ),
                
    //       //     ],
    //       //   ),
    //       // ),
    //     );
    //   },
    // );
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
      icon: await BitmapDescriptor.fromAssetImage(const ImageConfiguration(devicePixelRatio: 1.0, size: Size(30, 50)), 'assets/images/icon-yellow-position.png'),
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
              },
              child: const CircleAvatar(
                child: const Icon(Icons.close),
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: const Text("Submitß"),
                    onPressed: () {
                      print('it was clicked');
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
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

  _getUserPosition() async {
    Location location = new Location();
    LocationData _locationData;
    _locationData = await location.getLocation() as LocationData;
    constant.lat = _locationData.latitude!;
    constant.long = _locationData.longitude!;
    print(constant.lat);
    print(constant.long);
  }

  _returnLastPosition() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var collection = FirebaseFirestore.instance.collection('users').doc(constant.user_id); //.where("password", isEqualTo: "12345aA");
    var querySnapshots = await collection.get();

    constant.lat = querySnapshots['geoposition'].latitide;
    constant.long = querySnapshots['geoposition'].longitude;

    setState(() { constant.lat = querySnapshots['geoposition'].latitide; constant.long = querySnapshots['geoposition'].longitude; });

    print(constant.lat);
    print(constant.long);
  }

  _checkPosition() async {
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled() as bool;
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService() as bool;
      if (!_serviceEnabled) {
        _returnLastPosition();
        return;
      }
    }
    _permissionGranted = await location.hasPermission() as PermissionStatus;
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission() as PermissionStatus;
      if (_permissionGranted != PermissionStatus.granted) {
        _returnLastPosition();
        return;
      }
    }
    if (constant.serviceEnabled && constant.permissionGranted == PermissionStatus.granted) {
      _locationData = await location.getLocation() as LocationData;
      constant.lat = _locationData.latitude!;
      constant.long = _locationData.longitude!;
      setState(() { constant.lat = _locationData.latitude!; constant.long = _locationData.longitude!; });
      print(_locationData.toString());
    }
  }

  _initialCameraPosition() {
    constant.kGooglePlex = CameraPosition(
      target: LatLng(constant.lat, constant.long),
      zoom: 14.4746,
    );
  }
}

extension StringExtension on String {
    String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
    }
}
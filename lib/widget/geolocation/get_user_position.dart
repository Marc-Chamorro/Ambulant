import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';


checkPosition() async {
  Location location = new Location();
  LocationData _locationData;
  constant.serviceEnabled = await location.serviceEnabled() as bool;
  if (!constant.serviceEnabled) {
    constant.serviceEnabled = await location.requestService() as bool;
    if (!constant.serviceEnabled) {
      returnLastPosition();
      return;
    }
  }
  constant.permissionGranted = await location.hasPermission() as PermissionStatus;
  if (constant.permissionGranted == PermissionStatus.denied) {
    constant.permissionGranted = await location.requestPermission() as PermissionStatus;
    if (constant.permissionGranted != PermissionStatus.granted) {
      returnLastPosition();
      return;
    }
  }
  _locationData = await location.getLocation() as LocationData;
  constant.lat = _locationData.latitude!;
  constant.long = _locationData.longitude!;
  print(_locationData.toString());
}

returnLastPosition() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var collection = FirebaseFirestore.instance.collection('users').doc(constant.user_id); //.where("password", isEqualTo: "12345aA");
  var querySnapshots = await collection.get();

  constant.lat = querySnapshots['geoposition'].latitide;
  constant.long = querySnapshots['geoposition'].longitude;

  print(constant.lat);
  print(constant.long);
}

getUserNearbyPosition() {
  double lat = 0.0144927536231884;
  double lon = 0.0181818181818182;
  double distance = 10; //zoom

  double lowerLat = constant.lat - (lat * distance);
  double lowerLon = constant.long - (lon * distance);

  double greaterLat = constant.lat + (lat * distance);
  double greaterLon = constant.long + (lon * distance);

  constant.lesserGeopoint = GeoPoint(lowerLat, lowerLon);
  constant.greaterGeopoint = GeoPoint(greaterLat, greaterLon);
}
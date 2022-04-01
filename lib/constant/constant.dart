library constant;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Color ColorPrimaryBackground = Color(0xFFD6D6D6);
Color ColorPrimary = Color(0xFFFFB300); //Color(0xFFFFD100);
Color ColorPrimaryTextColor = Color(0xFF202020);

Color ColorSecondBackground = Color(0xFFFCFCFC);
Color ColorSecond = Color(0xFFFFEE32);
Color ColorSecondTextColor = Color(0xFF333533);

Color backgroundText = Color(0xFF595858);

String user_id = "";

FirebaseAuth auth = FirebaseAuth.instance;
GoogleSignIn googleSignIn = GoogleSignIn();

double lat = 0.0;
double long = 0.0;
bool serviceEnabled = false;
PermissionStatus permissionGranted = false as PermissionStatus;
late CameraPosition kGooglePlex;
late BitmapDescriptor mapMarker;
late GeoPoint lesserGeopoint;
late GeoPoint greaterGeopoint;
//LocationData _locationData;

String choosenTag = "";
String homeScreenChoosenType = "home_screen";
String window = "home_screen";
String settingsScreenChoosenType = "user";
String shopTypeName = "";

String localEscollitID = "";
String nomLocalEscollit = "";
double localLat = 0;
double localLon = 0;
String localDistancia = "";
String localPrice = "";
String localDescription = "";
String localImg = "";
String localStreet = "";
bool localState = true;

var queryUserFavourites;
var userLastDiscount;
int userTotalDiscount = 0;
String userShopID = "";
bool userHasShop = false;

// also from here android/app/src/main/AndroidManifest.xml
String google_maps_apikey = "AIzaSyCUQW9PniJ1pFfB1bikguwvPqQ-3HYcVlM";

String favoriteScreenChoosenType = "filter_applied";

// int globalInt = 0;
// bool globalBoolean = true;
// String globalString = "";
// double globalDouble= 10.0;

String fnomLocalEscollit = "";
String flocalEscollitID = "";
double flocalLat = 0;
double flocalLon = 0;
String flocalDistancia = "";
String flocalPrice = "";
String flocalDescription = "";
String flocalImg = "";
bool   flocalState = true;

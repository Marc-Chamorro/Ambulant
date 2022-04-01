import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'package:ambulant_project/widget/map/body.dart';

import 'package:ambulant_project/widget/images/images.dart';
import 'package:ambulant_project/widget/images/list_images.dart';

import 'package:geocoding/geocoding.dart';

//
class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key, String? values}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreen();
}

class _FavouritesScreen extends State<FavouritesScreen> {
  //late final String values;

  //HomeScreen({required this.values});

  late GeoPoint lesserGeopoint;
  late GeoPoint greaterGeopoint;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (constant.favoriteScreenChoosenType == "filter_applied") {
      setState(() {  });
      return _returnFilterShops();
    } else if (constant.favoriteScreenChoosenType == "local_escollit") {
      setState(() {  });
      return _returnSelectedShop();
    } else  if (constant.favoriteScreenChoosenType == "map_local") {
      setState(() {  });
      return LocalMapScreen(notifyParent: refresh,);
    }

    return Center(child: const CircularProgressIndicator());
  }

  refresh() {
    setState(() {});
  }

  _returnFilterShops() {

    var queryFavourites = FirebaseFirestore.instance.collection('users').doc(constant.user_id).collection('favourites').get();
    //var queryLocal = FirebaseFirestore.instance.collection('local').doc(constant.localEscollitID).get();
    // if (textController.text.isEmpty) {

    //   queryLocal = FirebaseFirestore.instance.collection('local').where("location", isGreaterThan: lesserGeopoint).where("location", isLessThan: greaterGeopoint).where("open", isEqualTo: true).where("index", isEqualTo: constant.choosenTag).get();
    // } else {
    //   String text_to_search = textController.text + "\uf7ff";
    //   queryLocal = FirebaseFirestore.instance.collection('local').where("location", isGreaterThan: lesserGeopoint).where("location", isLessThan: greaterGeopoint).where("open", isEqualTo: true).where("index", isEqualTo: constant.choosenTag).where("name", whereIn: [textController.text]).get();                                
    // }
    setState(() {  });

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      //_appBarBackButton("Ambulant: " + constant.shopTypeName, "home_screen"),
        _appBarNormal(),
        Expanded(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB300),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: const Color(0xFFEEEEEE),
                                  width: 2,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          4, 0, 4, 0),
                                      child: const Icon(
                                        Icons.search_rounded,
                                        color: const Color(0xFF95A1AC),
                                        size: 24,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            4, 0, 0, 0),
                                        child: TextFormField(
                                          cursorColor: constant.ColorPrimary,
                                          controller: textController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            //fillColor: constant.ColorPrimary,
                                            labelText: 'Search favorites here...',
                                            labelStyle: TextStyle(
                                              color: const Color(0xFF95A1AC),
                                            ),
                                            enabledBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: const TextStyle(
                                            fontFamily: 'Lexend Deca',                       
                                            color: Color(0xFF95A1AC),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: AlignmentDirectional(0.95, 0),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {  });
                                          },
                                          icon: Icon(
                                            Icons.sync,//cosas
                                            //IconData(0xf0590, fontFamily: 'MaterialIcons'),
                                            color: Color(0xFF95A1AC),
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: _returnBodyCards(queryFavourites),
                    )
                  ),
                ],
              ),
            ]
          )
        )
      ]
    );
  }

    _checLocalFolderAndCrete() async {
    //query
      //text == "Delete shop"
      var query = await FirebaseFirestore.instance.collection('local').doc(constant.flocalEscollitID).collection('image').get();
      try {
        if (query.docs.isEmpty) {
          FirebaseFirestore.instance
          .collection("local")
          .doc(constant.flocalEscollitID)
          .collection("image")
          .add({
            'user_id': 'default_id',
            'image': 'default_image',
          }).catchError((error) => print("Failed to add image path: $error"));
        }
      } catch (e) {
        FirebaseFirestore.instance
          .collection("local")
          .doc(constant.flocalEscollitID)
          .collection("image")
          .add({
            'user_id': 'default_id',
            'image': 'default_image',
          }).catchError((error) => print("Failed to add image path: $error"));
      }
  }

  _returnBodyCards(var queryFavourites) {
    return FutureBuilder<QuerySnapshot>(
      future: queryFavourites,
      builder: (BuildContext context, AsyncSnapshot snapshotFavorite){
        if (snapshotFavorite.hasData) {
          if (snapshotFavorite.data.docs.length > 1) {
            return Theme(
              //Inherit the current Theme and override only the accentColor property
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.fromSwatch().copyWith(secondary: constant.ColorPrimary)
              ),
              child:
                ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshotFavorite.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  String idLocal = snapshotFavorite.data.docs[index]['local'].toString();
                  var queryLocal = FirebaseFirestore.instance.collection('local').doc(idLocal).get();

                  return FutureBuilder(
                    future: queryLocal,
                    builder: (BuildContext context, AsyncSnapshot snapshot){
                      if (snapshot.hasData) {
                        if (snapshot.data.id != "default local id") {
                    
                          String QdocumentID = snapshot.data.id;
                          String Qname = snapshot.data['name'].toString();
                          double Qlat = snapshot.data['location'].latitude;
                          double Qlon = snapshot.data['location'].longitude;
                          String Qimg = snapshot.data['image'].toString();

                          String price = snapshot.data['price'].toString();
                          String description = snapshot.data['description'].toString();
                          bool state = snapshot.data['open'];

                          if (Qname.toUpperCase().contains(textController.text.toUpperCase())) {
                            return _bodyCards(context, QdocumentID, Qname, Qimg, Qlat, Qlon, price, description, state);
                          } else {
                            return SizedBox(height: 0);
                          }
                        } else {
                          //remember that the id is default local id, so at least one will always be executed
                          return SizedBox(height: 0);
                        }
                      }
                      return Container(child: Center(child: const CircularProgressIndicator()));
                    }
                  );
                }
              ),
            );
          }
          return Center(child: Container(child: 
            //const Text("No data found")
            Image.asset(
              'assets/images/DataNotFound.png',
              color: constant.ColorPrimary,
              height: MediaQuery.of(context).size.width * 0.3,
              width: MediaQuery.of(context).size.width * 0.3,
            )
          ));
        }
        return Container(child: Center(child: const CircularProgressIndicator()));
      }
    );
  }

  _appBarBackButton(String text, String page_to_open) {
    return AppBar(
      backgroundColor: Color(0xFFFFB300),
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () { setState(() { constant.favoriteScreenChoosenType = page_to_open; });},
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
  }

    _appBarNormal() {
    return AppBar(
      backgroundColor: Color(0xFFFFB300),
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(100, 10, 0, 10),
        child: Text(
          'Ambulant',
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

  _bodyCards(context, String QdocumentID, String Qname, String Qimg, double Qlat, double Qlon, String price, String description, bool state) {
    bool _isElevated = false;
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Material(
        color: Colors.white,
        elevation: 14.0,
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Color(0xFFFFB300),
        child: Row(
          mainAxisAlignment:MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.38,
              height: 110,
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(10.0),
                child: Image(fit: BoxFit.fill, image: NetworkImage(Qimg)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(Qname),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _returnCardStateOrDistance(Qlat, Qlon),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: 110,
              child: ElevatedButton(
                onPressed: () async { 

                  // String fnomLocalEscollit = "";
                  // String flocalEscollitID = "";
                  // double flocalLat = 0;
                  // double flocalLon = 0;

                  // String flocalDistancia = "";
                  // String flocalPrice = "";
                  // String flocalDescription = "";
                  // String flocalImg = "";
                  // bool   flocalState = true;

                  constant.favoriteScreenChoosenType = "local_escollit";
                  constant.fnomLocalEscollit = Qname;
                  constant.flocalEscollitID = QdocumentID;
                  constant.flocalLat = Qlat;
                  constant.flocalLon = Qlon;

                  constant.flocalDistancia = _returnDistance(constant.lat, constant.long, Qlat, Qlon).toString();
                  constant.flocalPrice = price;
                  constant.flocalDescription = description;
                  constant.flocalImg = Qimg;
                  constant.flocalState = state;

                  setState(() {  });
                  return print("local selected");
                }, 
                child: Icon(Icons.add_circle_outline),
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.transparent,
                  primary: Color(0xFFFFB300),
                  padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  _returnCardStateOrDistance(double Qlat, double Qlon) {
    if (constant.flocalState == true) {
      return Text("Distance: " + _returnDistance(constant.lat, constant.long, Qlat, Qlon).toString());
    } else {
      return Text("Local Closed");
    }
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

  _returnSelectedShop() {
    _checLocalFolderAndCrete();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _appBarBackButton(constant.fnomLocalEscollit, "filter_applied"),
        Expanded(
          child: Theme(
                                //Inherit the current Theme and override only the accentColor property
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch().copyWith(secondary: constant.ColorPrimary)
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 320,
                        decoration: BoxDecoration(
                          color: Color(0xFFDBE2E7),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  constant.flocalImg,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  16, 16, 16, 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Card(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        color: Color(0x3A000000),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: FutureBuilder<QuerySnapshot>(
                                          future: FirebaseFirestore.instance.collection('users').doc(constant.user_id).collection('favourites').where('local', isEqualTo: constant.flocalEscollitID).get(),
                                          builder:(context, AsyncSnapshot snapshot) {
                                            constant.queryUserFavourites = snapshot.data;

                                            if(snapshot.hasData){
                                              if(snapshot.connectionState == ConnectionState.waiting){
                                                return Container(
                                                width: 46,
                                                height: 46,
                                                child: ElevatedButton(
                                                  onPressed: () async { 

                                                  }, 
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    size: 24.0,
                                                    color: Colors.white,
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    shadowColor: Colors.transparent,
                                                    primary: Colors.transparent,
                                                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                                    ),
                                                  ),
                                                ),
                                              );
                                              }else{

                                                constant.queryUserFavourites = snapshot.data;

                                                bool localLoved;
                                                if (constant.queryUserFavourites.docs.length == 0) {
                                                  localLoved = false;
                                                } else {
                                                  localLoved = true;
                                                }
                                                
                                                Icon favourites;
                                                if (!localLoved) {
                                                  favourites = Icon(Icons.favorite_border, size: 24.0, color: Colors.white,);
                                                } else {
                                                  favourites = Icon(Icons.favorite, size: 24.0, color: Colors.white,);
                                                }

                                                return Container(
                                                  width: 46,
                                                  height: 46,
                                                  child: ElevatedButton(
                                                    onPressed: () async { 

                                                      await _updateFavourite();

                                                      setState(() {  });
                                                      print("local love");

                                                      return setState(() {  });
                                                    }, 
                                                    child: favourites,
                                                    style: ElevatedButton.styleFrom(
                                                      shadowColor: Colors.transparent,
                                                      primary: Colors.transparent,
                                                      padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            }else if (snapshot.hasError){
                                              return Container(
                                                width: 46,
                                                height: 46,
                                                child: ElevatedButton(
                                                  onPressed: () async { 

                                                  }, 
                                                  child: Icon(
                                                    Icons.error,
                                                    size: 24.0,
                                                    color: Colors.white,
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    shadowColor: Colors.transparent,
                                                    primary: Colors.transparent,
                                                    padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            return Container(
                                              width: 46,
                                              height: 46,
                                              child: ElevatedButton(
                                                onPressed: () async { 

                                                }, 
                                                child: Icon(
                                                  Icons.favorite_border,
                                                  size: 24.0,
                                                  color: Colors.white,
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  shadowColor: Colors.transparent,
                                                  primary: Colors.transparent,
                                                  padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 20, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        constant.fnomLocalEscollit,
                        style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF090F13),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _returnDistantOrState(),
                      // Text(
                      //   "Position: " + constant.localLat.toString() + ", " + constant.localLon.toString(),
                      //   style:
                      //       TextStyle(
                      //             fontFamily: 'Lexend Deca',
                      //             color: Color(0xFF8B97A2),
                      //             fontSize: 12,
                      //             fontWeight: FontWeight.normal,
                      //           ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 8, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.attach_money_rounded),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                        child: Text(
                          constant.flocalPrice,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF8B97A2),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 16, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'DESCRIPTION',
                        style:
                            TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF262D34),
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24, 4, 24, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                          child: Text(
                            constant.flocalDescription,
                            style: TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF8B97A2),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ImageList(notifyParent: () { refresh(); },),
                ),
                

                ImageCollection(notifyParent: () { refresh(); },),


              ],
            ),
          ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Color(0xFF14181B),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x55000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 16),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          constant.flocalDistancia,
                          style:
                              TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10, height: 4), 
                      FutureBuilder<List<Placemark>>(
                        future: placemarkFromCoordinates(constant.flocalLat, constant.flocalLon),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<Placemark> placemarks = snapshot.data ?? [];
                            constant.localStreet = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
                            return 
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4, // Some height
                              child: Text(
                                constant.localStreet,
                                style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF8B97A2),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                ),
                              ),
                            );
                          } else {
                            return Text(
                              '---',
                              style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF8B97A2),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                              ),
                            );
                          }
                        }
                      ),
                    // ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    print('Button pressed ...');
                    setState(() {
                      constant.favoriteScreenChoosenType = "map_local";
                    });
                  },
                  child: Text(
                    'Veure en Mapa',
                    style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 0.4, 50),
                    backgroundColor: Color(0xFF4B39EF),
                    elevation: 3,
                    side: BorderSide(width:1, color:Colors.transparent),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  _returnDistantOrState() {
    if (constant.flocalState == true) {
      return Text(
        "Position: " + constant.flocalLat.toString() + ", " + constant.flocalLon.toString(),
        style:
          TextStyle(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF8B97A2),
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
      );
    } else {
      return Text(
        "Last position: " + constant.flocalLat.toString() + ", " + constant.flocalLon.toString(),
        style:
          TextStyle(
                fontFamily: 'Lexend Deca',
                color: Color(0xFF8B97A2),
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
      );
    }
  }

  _updateFavourite() async {
    //constant.queryUserFavourites = await FirebaseFirestore.instance.collection('users').doc(constant.user_id).collection('favourites').where('local', isEqualTo: constant.localEscollitID.toString()).get();

    var queryUser = await FirebaseFirestore.instance.collection('users').doc(constant.user_id).collection('favourites').where('local', isEqualTo: constant.flocalEscollitID.toString()).get();
    
    if (queryUser.docs.length == 0) {
      FirebaseFirestore.instance
        .collection("users")
        .doc(constant.user_id)
        .collection("favourites")
        .add({'local': constant.flocalEscollitID,})
        .catchError((error) => print("Failed to add local (" + constant.flocalEscollitID + ") as favourite: $error"));
    } else {
      var documentID = null;
      for (var snapshot in queryUser.docs) {
        documentID = snapshot.id; // <-- Document ID

        FirebaseFirestore.instance
        .collection("users")
        .doc(constant.user_id)
        .collection("favourites")
        .doc(documentID)
        .delete()
        .catchError((error) => print("Failed to delete local (" + constant.flocalEscollitID + ") as non favourite: $error"));

      }
    }
  }
}
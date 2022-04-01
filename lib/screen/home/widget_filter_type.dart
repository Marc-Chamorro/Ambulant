import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import '../login&singup/loginsingup_screen.dart';
import '../../constant/constant.dart' as constant;
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../login&singup/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home/home_screen.dart' as s_home;
import '../main_body/mainbody_screen.dart' as s_mbody;
import 'dart:math';

class remove extends StatefulWidget{
  const remove({Key? key, String? values}) : super(key: key);

  @override
  _FilterScreen createState()=> _FilterScreen();
}

class _FilterScreen extends State<remove> {
  //final String values;
  late GeoPoint lesserGeopoint;
  late GeoPoint greaterGeopoint;

  //FilterScreen({required this.values});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    _buildVairables();
    setState(() {  });
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      _appBarBackButton(),
        Expanded(
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 108,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFB300),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
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
                                          controller: textController,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            labelText: 'Search events here...',
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
                                    const Expanded(
                                      child: Align(
                                        alignment: AlignmentDirectional(0.95, 0),
                                        child: Icon(
                                          Icons.tune_rounded,
                                          color: Color(0xFF95A1AC),
                                          size: 24,
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
                    // child: SingleChildScrollView(
                    //   child: FutureBuilder(

                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: FutureBuilder<QuerySnapshot>(
                        future: FirebaseFirestore.instance.collection('local').where("location", isGreaterThan: lesserGeopoint).where("location", isLessThan: greaterGeopoint).where("open", isEqualTo: true).where("index", isEqualTo: constant.choosenTag).get(),
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length > 0) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //return _returnBoxes(snapshot, index);
                                  String QdocumentID = snapshot.data.docs[index].id;
                                  String Qname = snapshot.data.docs[index]['name'].toString();
                                  double Qlat = snapshot.data.docs[index]['location'].latitude;
                                  double Qlon = snapshot.data.docs[index]['location'].longitude;
                                  String Qimg = snapshot.data.docs[index]['image'].toString();

                                  return _bodyCards(context, QdocumentID, Qname, Qimg, Qlat, Qlon);
                                }
                              );
                            }
                            return Container(child: const Text("No data found"));
                          }
                          return Container(child: const CircularProgressIndicator());
                        }
                      )
                      // Column(
                      //   mainAxisSize: MainAxisSize.max,
                      //   children: [
                      //     _buildBody(context),
                      //   ],
                      // )
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

  _appBarBackButton() {
    setState(() {});
    return Container(
        margin: const EdgeInsets.all(50.0),
        color: Color(0xFFFFB300),
        //automaticallyImplyLeading: false,
        /*leading:*/child:  GestureDetector(
          onTap: () { setState(() { constant.homeScreenChoosenType = "home_screen"; });
            setState(() { constant.window = "home_screen"; });
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) {
            //     return s_mbody.AppBody();
            //   }),
            //   (route) => false,
            // );
            
          },
          child: Icon(
            Icons.menu,
          ),
        ),
        // title: const Padding(
        //   padding: EdgeInsetsDirectional.fromSTEB(100, 10, 0, 10),
        //   child: Text(
        //     'APP BAR 2',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       fontFamily: 'Lexend Deca',
        //       color: Colors.white,
        //       fontSize: 32,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
        // actions: [],
        // centerTitle: false,
        // elevation: 0,
    );
  }

  _buildVairables () {
    //from the constant variable filter locals AND THAT ARE NEARBY
    // for each local print them in the list
    double lat = 0.0144927536231884;
    double lon = 0.0181818181818182;
    double distance = 10; //zoom

    double lowerLat = constant.lat - (lat * distance);
    double lowerLon = constant.long - (lon * distance);

    double greaterLat = constant.lat + (lat * distance);
    double greaterLon = constant.long + (lon * distance);

    lesserGeopoint = GeoPoint(lowerLat, lowerLon);
    greaterGeopoint = GeoPoint(greaterLat, greaterLon);
  }

  _bodyCards(context, String QdocumentID, String Qname, String Qimg, double Qlat, double Qlon) {
    // return Padding(
    //   padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
    //   child: Row(
    //     mainAxisSize: MainAxisSize.max,
    //     children: [
    //       Container(
    //         width: MediaQuery.of(context).size.width,
    //         height: 90,
    //         decoration: BoxDecoration(
    //           color: Colors.white,
    //         ),
    //         child: Row(
    
    return Container(
      padding: const EdgeInsets.all(8.0),
        //child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(10.0),
            shadowColor: const Color(0x802196F3),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,//MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 150,
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
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(Qname),
                      ),
                    ),
                    Container(
                      width: 150,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_calculateDistanceMeters(constant.lat, constant.long, Qlat, Qlon).toString()),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 40,
                  height: 110,
                  //color: Colors.lightGreen,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),//BorderRadius.circular(10.0),
                    color: Colors.lightGreen,
                    //boxShadow: [
                    //  BoxShadow(color: Colors.green, spreadRadius: 3),
                    //],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.add_circle_outline),
                    //borderRadius: new BorderRadius.circular(10.0),
                    onPressed: () { 
                      print("local selected");
                    },
                    //child: Image(fit: BoxFit.fill, image: NetworkImage(Qimg)),
                  ),
                ),
              ],
            ),
          )
        //),
      );
  }

  double _calculateDistanceMeters(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
}
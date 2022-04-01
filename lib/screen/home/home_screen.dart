import 'package:ambulant_project/screen/main_body/mainbody_screen.dart';
import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import '../login&singup/loginsingup_screen.dart';
import '../../constant/constant.dart' as constant;
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../login&singup/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../home/widget_filter_type.dart' as s_filteredShops;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ambulant_project/widget/map/body.dart';
import 'package:ambulant_project/widget/images/images.dart';
import 'package:ambulant_project/widget/images/list_images.dart';

import 'package:geocoding/geocoding.dart';

import 'dart:math';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key, String? values}) : super(key: key);

  @override
  _HomeScreen createState()=> _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  //late final String values;

  //HomeScreen({required this.values});

  late GeoPoint lesserGeopoint;
  late GeoPoint greaterGeopoint;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (constant.homeScreenChoosenType == "home_screen") {
      setState(() {  });
      return _returnHomeScreen();
    } else if (constant.homeScreenChoosenType == "filter_applied") {
      setState(() {  });
      return _returnFilterShops();
    } else if (constant.homeScreenChoosenType == "local_escollit") {
      setState(() {  });
      return _returnSelectedShop();
    } else  if (constant.homeScreenChoosenType == "map_local") {
      setState(() {  });
      return LocalMapScreen(notifyParent: refresh,);
    }

    return Center(child: const CircularProgressIndicator());
  }

  refresh() {
    setState(() {});
  }

  _returnHomeScreen() {
    setState(() {  });
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        _appBarNormal(),
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: //_returnTargetes(context),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance.collection('index').get(),
                builder:(context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.hasData){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else{
                      //print(snapshot.data.toString());
                      return Theme(
                        //Inherit the current Theme and override only the accentColor property
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: constant.ColorPrimary)
                        ),
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder:(BuildContext context, int Index) {
                            //using the index, get the position of the data
                              String name = snapshot.data!.docs[Index]['name'].toString();
                              String tag = snapshot.data!.docs[Index]['tag'].toString();
                              String img = snapshot.data!.docs[Index]['image'].toString();
                              return _shopBox(context, name, img, tag);
                            //return Text('VALUES HERE');
                          }
                        )
                      );
                    }
                  }else if (snapshot.hasError){
                    return Text('no data');
                  }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                },
              ),
          )
        ),
      ],
    );
  }

  // _getQuery() async {
  //   var query = await FirebaseFirestore.instance.collection('index').get();
  //   return query;
  // }

  _shopBox(context, String nombre_recuadro, String foto, String tag) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 184,
        decoration: BoxDecoration(
          color: Color(0xFF090F13),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: Image.network(foto).image,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Color(0x65090F13),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Text(
                        nombre_recuadro,
                        style: const TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          print('Button-Reserve pressed ...');
                          //extract the tag, introduce it here, filter later by locals using this tag
                          _filterLocal(tag);
                          setState(() {
                            constant.choosenTag = tag;
                            constant.shopTypeName = tag.replaceFirst(tag[0], tag[0].toUpperCase());;
                            constant.homeScreenChoosenType = "filter_applied";
                            return print(tag + " es la tag del local");
                            //window = "favorite_screen";
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'GO',
                              style: TextStyle(color: Colors.white, fontSize: 20,)
                            ),
                          ],
                        ),

                        style: TextButton.styleFrom(
                          //primary: Colors.orange,
                          fixedSize: Size(120, 40),
                          backgroundColor: Colors.orange,
                          elevation: 3,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))
                          ),
                          //side: BorderSide(color: Colors.teal, width: 2),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _filterLocal(String tag) {
    constant.choosenTag = tag;
    constant.homeScreenChoosenType = "filter_applied";
    return print(tag + " es la tag del local / s'ha de filtrar per la tag del local / obrir finestra amb el filtre dels locals");
  }

  // _appBarSelected() {
  //   if (constant.homeScreenChoosenType == "filter_applied") {
  //     setState(() {  });
  //     return _appBarBackButton();
  //   } else if (constant.homeScreenChoosenType == "local_escollit") {
  //     setState(() {  });
  //     return _appBarBackButton();
  //   }
  //   setState(() {  });
  //   return _appBarNormal();
  // }

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

  _appBarBackButton(String text, String page_to_open) {
    return AppBar(
      backgroundColor: Color(0xFFFFB300),
      automaticallyImplyLeading: false,
      leading: GestureDetector(
        onTap: () { setState(() { constant.homeScreenChoosenType = page_to_open; });},
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










  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////          LOCALS FILTER SCREEN          ////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////










  _returnFilterShops() {

    _buildVairables();

    // var queryLocal;
    // if (textController.text.isEmpty) {
      var queryLocal = FirebaseFirestore.instance.collection('local').where("location", isGreaterThan: lesserGeopoint).where("location", isLessThan: greaterGeopoint).where("open", isEqualTo: true).where("index", isEqualTo: constant.choosenTag).get();
    // } else {
    //   String text_to_search = textController.text + "\uf7ff";
    //   queryLocal = FirebaseFirestore.instance.collection('local').where("location", isGreaterThan: lesserGeopoint).where("location", isLessThan: greaterGeopoint).where("open", isEqualTo: true).where("index", isEqualTo: constant.choosenTag).where("name", whereIn: [textController.text]).get();                                

    // }
    setState(() {  });
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
      _appBarBackButton("Ambulant: " + constant.shopTypeName, "home_screen"),
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
                                          decoration: InputDecoration(
                                            labelText: 'Search shops here...',
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
                                            Icons.sync,
                                            color: Color(0xFF95A1AC),
                                            size: 24,
                                          ),
                                        ),
                                        // Icon(
                                        //   Icons.tune_rounded,
                                        //   color: Color(0xFF95A1AC),
                                        //   size: 24,
                                        // ),
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
                      child: FutureBuilder<QuerySnapshot>(
                        future: queryLocal,
                        builder: (BuildContext context, AsyncSnapshot snapshot){
                          if (snapshot.hasData) {
                            if (snapshot.data.docs.length > 0) {
                              return Theme(
                                //Inherit the current Theme and override only the accentColor property
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: constant.ColorPrimary)
                                ),
                                child:
                                ListView.builder(
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

                                    String price = snapshot.data.docs[index]['price'].toString();
                                    String description = snapshot.data.docs[index]['description'].toString();
                                  
                                    if (Qname.toUpperCase().contains(textController.text.toUpperCase())) {
                                      return _bodyCards(context, QdocumentID, Qname, Qimg, Qlat, Qlon, price, description);
                                    } else {
                                      return SizedBox(height: 0);
                                    }

                                    //return _bodyCards(context, QdocumentID, Qname, Qimg, Qlat, Qlon, price, description);
                                  }
                                ),
                              );
                            }
                            return Container(child: const Text("No data found"));
                          }
                          return Container(child: Center(child: const CircularProgressIndicator()));
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

  _bodyCards(context, String QdocumentID, String Qname, String Qimg, double Qlat, double Qlon, String price, String description) {
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
    bool _isElevated = false;
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        //child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(10.0),
            shadowColor: Color(0xFFFFB300),
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,//MainAxisAlignment.spaceBetween,
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
                        child: Text("Distance: " + _returnDistance(constant.lat, constant.long, Qlat, Qlon).toString()),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: 110,
                  child: ElevatedButton(
                    onPressed: () async { 
                      //constant.queryUserFavourites = await FirebaseFirestore.instance.collection('user').doc(constant.user_id).collection('favourites').where('local', isEqualTo: constant.localEscollitID).get();
                      //await _checkFavotites();

                      constant.homeScreenChoosenType = "local_escollit";
                      constant.nomLocalEscollit = Qname;
                      constant.localEscollitID = QdocumentID;
                      constant.localLat = Qlat;
                      constant.localLon = Qlon;
                      constant.localDistancia = _returnDistance(constant.lat, constant.long, Qlat, Qlon).toString();
                      constant.localPrice = price;
                      constant.localDescription = description;
                      constant.localImg = Qimg;

                      //THIS LINE IS NEW
                      //constant.queryUserFavourites = await FirebaseFirestore.instance.collection('user').doc(constant.user_id).collection('favourites').where('local', isEqualTo: constant.localEscollitID).get();
    
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
                /*Container(
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
                  padding: EdgeInsets.zero,
                  child: button

                  IconButton(
                    highlightColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.add_circle_outline),
                    //borderRadius: new BorderRadius.circular(10.0),
                    onPressed: () { 
                      print("local selected");
                    },
                    //child: Image(fit: BoxFit.fill, image: NetworkImage(Qimg)),
                  ),
                ),*/
              ],
            ),
          )
        //),
      );
  }

  // _checkFavotites() async {
  //   constant.queryUserFavourites = await FirebaseFirestore.instance.collection('user').doc(constant.user_id).collection('favourites').where('local', isEqualTo: constant.localEscollitID).get();
  //   setState(() {  });
  // }

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










  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////          LOCALS FILTER SCREEN          ////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////










  _returnSelectedShop() {
    //get local data
    // var query = await FirebaseFirestore.instance.collection('local').doc(constant.localEscollitID).get();
    // String image_local = query['image'];
    // String price = query['price'];
    // String description = query['description'];

    //_checkFavotites();

    //if local is in favourites then return new icon

    _checLocalFolderAndCrete();

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _appBarBackButton(constant.nomLocalEscollit, "filter_applied"),
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
                                  constant.localImg,
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
                                          future: FirebaseFirestore.instance.collection('users').doc(constant.user_id).collection('favourites').where('local', isEqualTo: constant.localEscollitID).get(),
                                          builder:(context, AsyncSnapshot snapshot) {
                                            //print(snapshot.data.toString());
                                            constant.queryUserFavourites = snapshot.data;

                                            // NO opcio 1, el future builder que en ves de tornar el iconde de carrega torni la mateixa finestra
                                            // SI opcio 2, tan sols el future builder en el boto POTSER MILLOR AQUESTA
                                            // LATER opcio 3, deixar-ho com abans del future builder i probar una altra cosa
                                            // NOopcio 4, tota la finestra que sigui el que retorni el future builder i a chuparla i en cas de carrega la mateixa finestra originallment

                                            //FUTURE BUILDER ONLY RETURNS THE ICON, BY DEFAULT WHEN LOADING IT WILL RETURN THE PREVIOUS SAVED ICON

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
                                                      //UPLOAD CHANGES WITH AWAIT

                                                      await _updateFavourite();

                                                      setState(() {  });
                                                      print("local love");

                                                      return setState(() {  });
                                                    }, 
                                                    child: favourites,//Icon(
                                                    //   Icon(Icons.favourites),
                                                    //   size: 24.0,
                                                    //   color: Colors.white,
                                                    // ),
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
                        constant.nomLocalEscollit,
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
                      Text(
                        "Position: " + constant.localLat.toString() + ", " + constant.localLon.toString(),
                        style:
                            TextStyle(
                                  fontFamily: 'Lexend Deca',
                                  color: Color(0xFF8B97A2),
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                      ),
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
                          constant.localPrice,
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
                            constant.localDescription,
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
                  child: ImageList(notifyParent: () { _refreshParent(); },),
                ),
                

                ImageCollection(notifyParent: () { _refreshParent(); },),













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
                          //DISTANCE
                          constant.localDistancia,
                          style:
                              TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        // Padding(
                        //   padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                        //   child: Text(

                        //     '+ taxes',
                        //     style: TextStyle(
                        //           fontFamily: 'Lexend Deca',
                        //           color: Color(0xFF8B97A2),
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.normal,
                        //         ),
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(width: 10, height: 4),
                    // Padding(
                    //   padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    //   child: 
                      FutureBuilder<List<Placemark>>(
                        future: placemarkFromCoordinates(constant.localLat, constant.localLon),
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
                            // Row( children: <Widget>[ Container( width: 70.0, ), Flexible( child: Text("Hi"), ) ], );
                            
                            // Flexible (
                            //       child: Text(
                            //             constant.localStreet,
                            //             style: TextStyle(
                            //                   fontFamily: 'Lexend Deca',
                            //                   color: Color(0xFF8B97A2),
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.normal,
                            //             ),
                            //           ),
                                    
                            //       );
                                
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
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //       fixedSize: Size(150, 50),
                //       primary: Color(0xFF4B39EF), //background color of button
                //       side: BorderSide(width:1, color:Colors.transparent), //border width and color
                //       elevation: 3, //elevation of button
                //       padding: EdgeInsets.all(20) //content padding inside button
                //   ),
                //   onPressed: () {
                //     print('Button pressed ...');
                //   },
                //   child: Text(
                //     'Veure en Mapa',
                //     style: TextStyle(
                //       fontFamily: 'Lexend Deca',
                //       color: Colors.white,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500,
                //     ),
                //   ),
                // ),
                TextButton(
                  onPressed: () {
                    print('Button pressed ...');
                    setState(() {
                      constant.homeScreenChoosenType = "map_local";
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

  _checLocalFolderAndCrete() async {
    //query
      //text == "Delete shop"
      var query = await FirebaseFirestore.instance.collection('local').doc(constant.localEscollitID).collection('image').get();
      try {
        if (query.docs.isEmpty) {
          FirebaseFirestore.instance
          .collection("local")
          .doc(constant.localEscollitID)
          .collection("image")
          .add({
            'user_id': 'default_id',
            'image': 'default_image',
          }).catchError((error) => print("Failed to add image path: $error"));
        }
      } catch (e) {
        FirebaseFirestore.instance
          .collection("local")
          .doc(constant.localEscollitID)
          .collection("image")
          .add({
            'user_id': 'default_id',
            'image': 'default_image',
          }).catchError((error) => print("Failed to add image path: $error"));
      }
  }

  _refreshParent() {
    setState(() {  });
  }

  _updateFavourite() async {
    //constant.queryUserFavourites = await FirebaseFirestore.instance.collection('users').doc(constant.user_id).collection('favourites').where('local', isEqualTo: constant.localEscollitID.toString()).get();

    var queryUser = await FirebaseFirestore.instance.collection('users').doc(constant.user_id).collection('favourites').where('local', isEqualTo: constant.localEscollitID.toString()).get();
    
    if (queryUser.docs.length == 0) {
      FirebaseFirestore.instance
        .collection("users")
        .doc(constant.user_id)
        .collection("favourites")
        .add({'local': constant.localEscollitID,})
        .catchError((error) => print("Failed to add local (" + constant.localEscollitID + ") as favourite: $error"));
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
        .catchError((error) => print("Failed to delete local (" + constant.localEscollitID + ") as non favourite: $error"));

      }
    }
  }

  _returnStreet() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(constant.localLat, constant.localLon);
    String palcename = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();

    constant.localStreet = palcename;
  }
}
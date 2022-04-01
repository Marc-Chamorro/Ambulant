import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';

import '../../widget/geolocation/get_user_position.dart';

class ConfigShopPageWidget extends StatefulWidget {
  final Function() notifyParent;
  ConfigShopPageWidget({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _ConfigShopPageWidgetState createState() => _ConfigShopPageWidgetState();
}

class _ConfigShopPageWidgetState extends State<ConfigShopPageWidget> {
  late String dropDownValue1;
  late TextEditingController textController1;
  late bool switchListTileValue;
  late TextEditingController textController2;
  late String dropDownValue2;
  late TextEditingController textController3;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late bool importFirstTime;

  late var documentID;

  final List<String> shopType = ['Food', 'Drinks', 'Clothes', 'Music'];
  late String selectedValue;
  late String selectedValueLocal;

  List<DropdownMenuItem<String>> dropdownItems = [];
  List<DropdownMenuItem<String>> dropdownItemsPrice = [];

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: '');
    textController2 = TextEditingController(text: '');
    textController3 = TextEditingController(text: '');

    switchListTileValue = false;
    importFirstTime = false;
    
    selectedValue = "Food";
    dropdownItems.add(DropdownMenuItem(child: Text("Food", overflow: TextOverflow.ellipsis,),value: "Food"),);
    dropdownItems.add(DropdownMenuItem(child: Text("Drinks", overflow: TextOverflow.ellipsis,),value: "Drinks"),);
    dropdownItems.add(DropdownMenuItem(child: Text("Clothes", overflow: TextOverflow.ellipsis,),value: "Clothes"),);
    dropdownItems.add(DropdownMenuItem(child: Text("Music", overflow: TextOverflow.ellipsis,),value: "Music"),);

    selectedValueLocal = "Cheap";
    dropdownItemsPrice.add(DropdownMenuItem(child: Text("Cheap"),value: "Cheap"),);
    dropdownItemsPrice.add(DropdownMenuItem(child: Text("Moderate"),value: "Moderate"),);
    dropdownItemsPrice.add(DropdownMenuItem(child: Text("Expensive"),value: "Expensive"),);
  }

  @override
  Widget build(BuildContext context) {

    _getTextBoxData();

    return 
             Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 20),
                  child: 
                  // ListView(
                  //   padding: EdgeInsets.zero,
                  //   scrollDirection: Axis.vertical,
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //SizedBox(height: 30,),

                      // Padding(
                      //   padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                      //   child: 

                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [



                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget> [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.31,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEEEEEE),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          print('Button pressed ...');
                                          _popUpMoreDetails(context);
                                        },
                                        child: Text(
                                          'Create Qr',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          elevation: MaterialStateProperty.all<double>(3),
                                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF595858)),
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                              side: BorderSide(color: Colors.transparent, width: 1,)
                                            )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width * 0.31,
                                      height: MediaQuery.of(context).size.height * 0.05,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEEEEEE),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          print('Button pressed ...');
                                          _checkDate(context);
                                        },
                                        child: Text(
                                          'Scan Qr',
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        style: ButtonStyle(
                                          elevation: MaterialStateProperty.all<double>(3),
                                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF595858)),
                                          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.0),
                                              side: BorderSide(color: Colors.transparent, width: 1,)
                                            )
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),


                      _dropDown(),
                      
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController1,
                                cursorColor: constant.ColorPrimary,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Your Shop',
                                  labelStyle: TextStyle(
                                    color: const Color(0xFF95A1AC),
                                  ),
                                  hintText: 'Enter shop name',
                                  hintStyle: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 16, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: constant.ColorPrimary,
                                controller: textController2,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: const Color(0xFF95A1AC),
                                  ),
                                  labelText: 'Your shop image',
                                  hintText: 'Enter url image',
                                  hintStyle: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 16, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController3,
                                cursorColor: constant.ColorPrimary,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: const Color(0xFF95A1AC),
                                  ),
                                  labelText: 'Shop description',
                                  hintText: 'Enter shop description',
                                  hintStyle: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFDBE2E7),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                style: TextStyle(
                                      fontFamily: 'Lexend Deca',
                                      color: Color(0xFF090F13),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                maxLines: 10,
                                keyboardType: TextInputType.multiline,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: MediaQuery.of(context).size.height * 0.05,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  print('Button_Secondary pressed ...');
                                  _saveChanges();
                                },
                                child: Text(
                                  'Save Changes',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                style: ButtonStyle(
                                  elevation: MaterialStateProperty.all<double>(3),
                                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF595858)),
                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(8)),
                                  //foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                      side: BorderSide(color: Colors.transparent, width: 1,)
                                    )
                                  ),
                                ),
                              ),
                            ),
                            // ////////

                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                        //width: 220,
                        width: MediaQuery.of(context).size.width,
                        //height: 60,
                        height: MediaQuery.of(context).size.height * 0.12,
                        child:
                          Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              height: MediaQuery.of(context).size.height * 0.08,
                              decoration: BoxDecoration(
                                color: Color(0x00EEEEEE),
                              ),
                              child: SwitchListTile(
                                value: switchListTileValue,// ??= true,
                                onChanged: (bool newValue) { 
                                  setState(() => switchListTileValue = newValue);
                                  _openShop(switchListTileValue);
                                  _updatePosition();
                                },
                                title: Text(
                                  'Open Shop',
                                  style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF151B1E),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                subtitle: Text(
                                  'Open geocalization for cliens',
                                  style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF8B97A2),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                ),
                                activeColor: constant.backgroundText,
                                //activeTrackColor: Color(0x8D4B39EF),
                                dense: false,
                                controlAffinity: ListTileControlAffinity.trailing,
                                tileColor: Color(0xFFF5F5F5),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.14,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                color: Color(0x00EEEEEE),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [

                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.transparent, width: 1),
                                      color: constant.ColorPrimary,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 50,
                                    width: 50,
                                    child: IconButton(
                                      color: Color(0xFF595858),
                                      icon: Icon(
                                        Icons.autorenew,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                        _updatePosition();
                                      },
                                    ),
                                  )
                                  // IconButton(
                                  //   icon: const Icon( Icons.autorenew),
                                  //   borderColor: Colors.transparent,
                                  //   borderRadius: 100,
                                  //   borderWidth: 1,
                                  //   buttonSize: 50,
                                  //   fillColor: Color(0xFF595858),
                                  //   icon: Icon(
                                  //     Icons.autorenew,
                                  //     color: Colors.white,
                                  //     size: 20,
                                  //   ),
                                  //   onPressed: () {
                                  //     print('IconButton pressed ...');
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
    //       ],
    //     ),
    //   ),
    // );
  }

  _getTextBoxData() async {
    if (!importFirstTime) {
      importFirstTime = true;
      var query = await FirebaseFirestore.instance.collection('local').where('owner', isEqualTo: constant.user_id).get(); //constant.user_id
      if (!query.docs.isEmpty) {
        for (var snapshot in query.docs) {
          documentID = snapshot.id;
          //var name = snapshot['name'].toString();
          // FirebaseFirestore.instance.collection('local').doc(documentID).delete()
          // .then((value) => print("Local Deleted"))
          // .catchError((error) => print("Failed to delete local: $error"));

          var consulta = await FirebaseFirestore.instance
            .collection('local')
            .doc(documentID)
            .get(); //constant.user_id
          if (consulta.exists) {
            constant.userShopID = documentID;
            textController1 = TextEditingController(text: consulta['name'].toString());
            textController2 = TextEditingController(text: consulta['image'].toString());
            textController3 = TextEditingController(text: consulta['description'].toString());
            String valor = consulta['index'].toString();
            try {
              selectedValue = valor[0].toUpperCase() + valor.substring(1).toLowerCase();
            } catch (e) {
              print(e);
            }
            // selectedValue = valor[0].toUpperCase() + valor.substring(1).toLowerCase();
            if (consulta['price'].toString() != "") {
              selectedValueLocal = consulta['price'].toString();
            }
            if (switchListTileValue = consulta['open']) {
              switchListTileValue = consulta['open'];
            }
            setState(() {  });
          }
        }
      }
    }
  }

  _updatePosition() {
    if (switchListTileValue) {
      checkPosition();
      FirebaseFirestore.instance
          .collection("local")
          .doc(documentID)
          .update({
            'location': GeoPoint(constant.lat, constant.long),
          });

      print(constant.lat.toString() + " - " + constant.long.toString());
    } else {
      print("The local is now closed");
    }
  }

  _dropDown() {
    return Container(
      height: 172,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 12),
            //width: 220,
            width: MediaQuery.of(context).size.width,
            //height: 70,
            //height: MediaQuery.of(context).size.height * 0.07,
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              elevation: 8,
              hint: Text('Please select shop type'),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF595858), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF595858), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              dropdownColor: Colors.white,
              value: selectedValue,
              style: TextStyle(color: Color(0xFF595858), fontFamily: 'Poppins', /*fontSize: 30*/),
              onChanged: (String? newValue){
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: dropdownItems.toList(),
            ),
          ),
          Container(
            margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
            //width: 220,
            width: MediaQuery.of(context).size.width,
            //height: 70,
            //height: MediaQuery.of(context).size.height * 0.07,
            child: DropdownButtonFormField(
              icon: Icon(Icons.arrow_drop_down),
              elevation: 2,
              hint: Text('Please select shop price'),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF595858), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF595858), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              dropdownColor: Colors.white,
              value: selectedValueLocal,
              style: TextStyle(color: Color(0xFF595858), fontFamily: 'Poppins', /*fontSize: 30*/),
              onChanged: (String? newValue){
                setState(() {
                  selectedValueLocal = newValue!;
                });
              },
              items: dropdownItemsPrice,
            ),
          ),
        ],
      ),
    );
  }

  _openShop(bool open) {
    //true then open
    //false then close
      FirebaseFirestore.instance
        .collection("local")
        .doc(documentID)
        .update({
          'open': open,
        });
  }

  _saveChanges() async {

    bool userExists = false;
    // bool emailExists = false;

    var query = await FirebaseFirestore.instance
            .collection('local')
            .where('name', isEqualTo: textController1.text)
            .get();
    // if (query.docs.isEmpty) {
    //   userExists = true;
    // }

    // var documentID = snapshot.id;
    //   var name = snapshot['name'].toString();
    for (var snapshot in query.docs) {
      
      if (snapshot['owner'] != constant.user_id) {
        userExists = true;
      }
    }

    if (userExists) {
      return _showAlertDialog(
        context,
        "Unavailable Name",
        "The name introduced is already being used by another user"
      );
    } else if (!userExists) {// && !emailExists) {
      FirebaseFirestore.instance
        .collection("local")
        .doc(documentID)
        .update({
          'description': textController3.text,
          'name': textController1.text,
          'image': textController2.text,
          'price': selectedValueLocal,
          'index': selectedValue.toLowerCase(),
        });
      return _showAlertDialog(
        context,
        "Success!",
        "Changes where applied successfully"
      );
    }
  }

  _showAlertDialog(BuildContext context, String title, String message) {

  // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        setState(() {  });
        widget.notifyParent();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _updateParent() {
    setState(() {});
  }

  _popUpMoreDetails(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              height: 400,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      color: Colors.white70,
                      child: _checkIfDiscount(context),
                    ),
                  ),
                  //Expanded(
                  Container(
                    height: 68,
                    color: Colors.white,
                    child: SizedBox.expand(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
                        child: Column(
                          children: [
                            //Text('shop details'),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        //constant.ColorSecond
                                        Color(0xFFFFB300)),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                setState(() {
                                  
                                });
                              },
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                    color: Color(0xFFFFB300),
                  ),
                  //),
                ],
              ),
            ),
          );
        });
  }

  _checkIfDiscount(BuildContext context) {
    // return FutureBuilder(
        // future: FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(constant.user_id)
        //     .get(),
        // builder: (BuildContext context, AsyncSnapshot snapshot) {
        //   if (snapshot.hasData) {
        //     int Udiscount = snapshot.data['descompte'];
        //     constant.userTotalDiscount = Udiscount;
        //     if (constant.userTotalDiscount <= 0) {
        //       return Center(child: Text('No discount available'));
        //     }
        //     return QrImage(
        //         data: 
        //             "shop" + 
        //             "'" +
        //             constant.userShopID + //shop id
        //             "'" +
        //             "5" + // constant.userTotalDiscount.toString() + //5 (discount to acumulate)
        //             "'" +
        //             DateTime.now().toString(),  //same
        //         size: 275.0);
        //   }
        //   return Center(child: CircularProgressIndicator());
        // });

    return QrImage(
                data: 
                    "shop" + 
                    "'" +
                    constant.userShopID + //shop id
                    "'" +
                    "5" + // constant.userTotalDiscount.toString() + //5 (discount to acumulate)
                    "'" +
                    DateTime.now().toString(),  //same
                size: 275.0);
  }

  _checkDate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => QRViewExample(
        notifyParentQR: () {
          _updateParent();
        },
      ),
    ));
  }
}

class QRViewExample extends StatefulWidget {
  final Function() notifyParentQR;
  const QRViewExample({Key? key, required this.notifyParentQR})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  bool find_img = false;
  int descompte = 0;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFB300),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 5,),
                  if (result != null)
                    Text('QR scanned!', //'Codigo: ${result!.code}',
                        style: TextStyle(fontSize: 5.0, color: Colors.white))
                  else
                    const Text('Scan the QR discount',
                        style: TextStyle(fontSize: 5.0, color: Colors.white)),
                  Container(
                    height: 20,
                    width: 50,
                      margin: const EdgeInsets.all(8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF595858),
                          ),
                          onPressed: () async {
                            setState(() {});
                            Future.delayed(Duration.zero, () {
                              Navigator.pop(context);
                            });
                            widget.notifyParentQR();
                          },
                          child: const Text('Exit', style: TextStyle(fontSize: 5.0, color: Colors.white))
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 225.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Color(0xFFFFB300),
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      if (!find_img) {
        find_img = true;
        //setState(() {
          result = scanData;
        //});
        print(result);
        // _addDiscount(result!.code.toString());
        // deleteOldDiscounts();
        
        _eliminarValorUsuari(result!.code.toString());
        
        var idx = result!.code.toString().split("'");
        try {
          if (idx[0].trim() == "client") {
          String idUser = idx[1].trim();
          // _popUpDescompte(discount);
        }
        } catch (e) {
        print(e);
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  _eliminarValorUsuari(String s) {
    var idx = s.split("'");
    try {
      if (idx[0].trim() == "client") {
        String idUser = idx[1].trim(); //s.substring(0, idx).trim();
        print(idUser);
        descompte = int.parse(idx[2].trim()); //int.parse(s.substring(idx + 1).trim());
        print(descompte);
        DateTime data = DateTime.parse(idx[3].trim());
        print(data);

        if (descompte > 0) {
          _deleteDiscountUser(idUser, descompte, data);
          _popUpDescompte(descompte);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _deleteDiscountUser(String idUser, int descompte, DateTime data) async {
    String id_fav;

    var query = await FirebaseFirestore.instance
        .collection("users")
        .doc(idUser)
        .get();

    if (query['descompte'] > 0) {
      await FirebaseFirestore.instance
        .collection("users")
        .doc(idUser)
        .collection("discounts")
        .add({
          'date': data, // 2022-03-07 17:37:58
          'discount': -query['descompte'], // 15
          'local': constant.userShopID, // 0Bbpz3qnmz3UEQkfhj3b
        })
        .then((value) => (
          id_fav = value.id
        ),
        )
        .catchError((error) => print("Failed to add user: $error"));

      
        descompte = int.parse(query['descompte'].toString());

      await FirebaseFirestore.instance
                .collection("users")
                .doc(idUser)
                .update({'descompte': 0});
      }

      //descompte = int.parse(value['descompte'].toString())
      //        _popUpDescompte();
      // setState(() {});
      // Future.delayed(Duration.zero, () {
      //   Navigator.pop(context);
      // });
  }

  // _returnPopUp(String idUser) {
  //   return FutureBuilder/*<DocumentSnapshot<Map<String, dynamic>>>*/(
  //       future: FirebaseFirestore.instance.collection('users').doc(idUser).get(),
  //       builder: (BuildContext context, AsyncSnapshot snapshot) {
  //         //if (snapshot.connectionState == ConnectionState.done) {
  //         if (!snapshot.hasError && snapshot.connectionState == ConnectionState.done) {
  //           if (snapshot.hasData) {
  //             //IF FALSE THEN THE USER HAS A SHOP
  //             int discount = int.parse(snapshot.data!['descompte'].toString());
  //             if (discount > 0) {
  //               return _popUpDescompte(discount, 'Ammount of discount:');
  //             }
  //             return _popUpDescompte(0, 'User has no discounts');
  //           }
  //           //text = "";
  //           return _popUpDescompte(0, 'No data');
  //         } else {
  //           //text = "";
  //           return _popUpDescompte(0, 'Loading');
  //         }
  //       }
  //     );
  // }

  String _textToReturn(int disc) {
    if (disc > 0) {
      return disc.toString() + '%';
    } else {
      return '';
    }
  }

  String _labelToReturn(int disc) {
    if (disc > 0) {
      return 'Ammount of discount:';
    } else {
      return 'User has no discounts';
    }
  }

  _popUpDescompte(int disc) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Container(
            height: 400,
            child: Column(
              children: [
                Expanded(
                  //child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          color: Colors.white70,
                          child: Text(
                            _labelToReturn(disc),
                            style: new TextStyle(
                              fontSize: 20.0,
                              //fontFamily: 'Roboto',
                              color: new Color(0xFF212121),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          color: Colors.white70,
                          child: Text(
                            _textToReturn(disc),
                            style: new TextStyle(
                              fontSize: 30.0,
                              //fontFamily: 'Roboto',
                              color: new Color(0xFF212121),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  //),
                ),
                //Expanded(
                Container(
                  height: 68,
                  color: Colors.white,
                  child: SizedBox.expand(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 5.0),
                      child: Column(
                        children: [
                          //Text('shop details'),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(
                                      //constant.ColorSecond
                                      Color(0xFFFFB300)),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                
                              });
                              widget.notifyParentQR();

                              setState(() {});
                              Future.delayed(Duration.zero, () {
                                Navigator.pop(context);
                              });
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 10,
                  color: Color(0xFFFFB300),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

  // _deleteOldDiscounts() async {
  //   var discountsQuery = await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(constant.user_id)
  //       .collection("discounts")
  //       .orderBy('date', descending: true)
  //       .get();

  //   int contador = 0, total_descompte = 0;
  //   bool restar = true;

  //   for (var snapshot in discountsQuery.docs) {
  //     contador++;

  //     if (contador > 10) {
  //       var documentID = snapshot.id;
  //       // var password = snapshot['password'].toString();

  //       print(documentID);

  //       FirebaseFirestore.instance
  //           .collection("user")
  //           .doc(constant.user_id)
  //           .collection("discounts")
  //           .doc(documentID)
  //           .delete();
  //     }

  //     if (contador <= 10 && restar) {
  //       int discount = snapshot['discount'];

  //       if (discount > 0) { //add maximum lines available
  //         total_descompte = total_descompte + discount;
  //       } else {
  //         FirebaseFirestore.instance
  //             .collection("users")
  //             .doc(constant.user_id)
  //             .update({'descompte': total_descompte});
  //         restar = false;
  //       }
  //     }
  //   }

    
  //       setState(() {});
  //       Future.delayed(Duration.zero, () {
  //         Navigator.pop(context);
  //       });

  //       widget.notifyParentQR();
  // }
}

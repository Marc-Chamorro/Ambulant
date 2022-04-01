import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsUserBody extends StatefulWidget {
  final Function() notifyParent;
  SettingsUserBody({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _SettingsUserBody createState() => _SettingsUserBody();
}

class _SettingsUserBody extends State<SettingsUserBody> {

  //widget.notifyParent();

  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  late bool passwordVisibility;
  late bool passwordRepeatVisibility;

  late bool importFirstTime;


  String text = "";

  @override
  void initState() {
    super.initState();

    textController1 = TextEditingController(text: '');
    textController2 = TextEditingController(text: '');
    textController3 = TextEditingController(text: '');
    textController4 = TextEditingController(text: '');

    passwordVisibility = false;
    passwordRepeatVisibility = false;

    importFirstTime = false;

    // textController1 = TextEditingController(text: '[User Name]');
    // textController2 = TextEditingController(text: '[New Password]');
    // textController3 = TextEditingController(text: '[New Password]');
    // textController4 = TextEditingController(text: '[User Email]');
  }

  @override
  Widget build(BuildContext context) {
    _getTextBoxData();
    return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 16, 8, 20),
                  child: 
                  // ListView(
                  //   padding: EdgeInsets.zero,
                  //   scrollDirection: Axis.vertical,
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'User Configuration',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF595858),
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ]
                        )
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(8, 16, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: constant.ColorPrimary,
                                controller: textController1,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    color: const Color(0xFF95A1AC),
                                  ),
                                  hintText: 'Introduce your name',
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
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: constant.ColorPrimary,
                                controller: textController2,
                                obscureText: !passwordVisibility,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: const Color(0xFF95A1AC),
                                  ),
                                  hintText: 'Enter a new password',
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
                                  suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordVisibility = !passwordVisibility,
                                  ),
                                  child: Icon(
                                    passwordVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: //const Color(0xFF595858),
                                      passwordVisibility
                                        ? constant.ColorPrimary
                                        : Color(0xFF595858),
                                    size: 20,
                                  ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: textController3,
                                cursorColor: constant.ColorPrimary,
                                obscureText: !passwordRepeatVisibility,
                                decoration: InputDecoration(
                                  labelStyle: TextStyle(
                                    color: const Color(0xFF95A1AC),
                                  ),
                                  labelText: 'Repeat password',
                                  hintText: 'Repeat the new password',
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
                                  suffixIcon: InkWell(
                                  onTap: () => setState(
                                    () => passwordRepeatVisibility = !passwordRepeatVisibility,
                                  ),
                                  child: Icon(
                                    passwordRepeatVisibility
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                    color: //const Color(0xFF595858),
                                      passwordRepeatVisibility
                                        ? constant.ColorPrimary
                                        : Color(0xFF595858),
                                    size: 20,
                                  ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: constant.ColorPrimary,
                                controller: textController4,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  labelStyle: TextStyle(
                                    color: const Color(0xFF95A1AC),
                                  ),
                                  hintText: 'Enter a your email',
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
                                  print('Button pressed ...');
                                  _saveUser();
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
                      ////////////////////////////////////
             
                      ////////////////////////////////////
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
                                    _logOut();
                                  },
                                  child: Text(
                                    'Log out',
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
                            _manageShop(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ); 
  } 

  _getTextBoxData() async {
    if (!importFirstTime) {
    importFirstTime = true;
    var query = await FirebaseFirestore.instance
            .collection('users')
            .doc(constant.user_id)
            .get(); //constant.user_id
          if (query.exists) {
            textController1 = TextEditingController(text: query['name'].toString());
            textController2 = TextEditingController(text: query['password'].toString());
            textController3 = TextEditingController(text: query['password'].toString());
            textController4 = TextEditingController(text: query['email'].toString());
            setState(() {  });
          }
    }
  }

  _manageShop() {

    //var consulta = 
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>/*<DocumentSnapshot<Map<String, dynamic>>>*/(
      future: FirebaseFirestore.instance.collection('users').doc(constant.user_id).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //if (snapshot.connectionState == ConnectionState.done) {
        if (!snapshot.hasError && snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            //IF FALSE THEN THE USER HAS A SHOP
            constant.userHasShop = !snapshot.data!['client'];
            if (constant.userHasShop) {
              text = "Delete shop";
              return _localButton(text);
            } else {
              text = "Create shop";
              return _localButton(text);
            }
          }
          //text = "";
          return _localButton(text);
        } else {
          //text = "";
          return _localButton(text);
        }
      }
    );

    // if (!importFirstTime) {
    //   importFirstTime = true;
    //   var query = await FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(constant.user_id)
    //         .get(); //constant.user_id
      
    // }
    //get user shop
    //change label according
      //create shop
        //validation pop up
        //change screen
      //delete shop
        //validation pop up
    
  }

  _localButton(String text) {
    return Padding(
      padding:
          EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.31,
        height: MediaQuery.of(context).size.height * 0.05,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
        ),
        child: TextButton(
          onPressed: () {
            print('Button pressed ...');
            setState(() {  });
            _buttonAction();
            setState(() {  });
          },
          child: Text(
            text,
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
    );
  }

  _buttonAction() async {
    if (constant.userHasShop)  {
      //text == "Delete shop"
      var query = await FirebaseFirestore.instance.collection('local').where('owner', isEqualTo: constant.user_id).get(); //constant.user_id
      if (!query.docs.isEmpty) {
        for (var snapshot in query.docs) {
          var documentID = snapshot.id;
          //var name = snapshot['name'].toString();
          
          var consulta = await FirebaseFirestore.instance.collection('local').doc(documentID).collection('tags').get(); //constant.user_id
          if (!consulta.docs.isEmpty) {
            for (var valor in consulta.docs) {
              var tagID = valor.id;
              //var name = snapshot['name'].toString();

              FirebaseFirestore.instance.collection('local').doc(documentID).collection('tag').doc(tagID).delete()
              .then((value) => print("Local Deleted"))
              .catchError((error) => print("Failed to delete local: $error"));
            }
          }

          FirebaseFirestore.instance.collection('local').doc(documentID).delete()
          .then((value) => print("Local Deleted"))
          .catchError((error) => print("Failed to delete local: $error"));
        }
        FirebaseFirestore.instance.collection('users')
        .doc(constant.user_id)
        .update({'client': true})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
      }
      setState(() {  });
    } else if (!constant.userHasShop) {
      String id = "";
      //text == "Create shop"
      //change user bool
      FirebaseFirestore.instance.collection('users')
        .doc(constant.user_id)
        .update({'client': false})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));

      //create structure
      FirebaseFirestore.instance.collection("local").add({
        'description': '',
        'image': '',
        'index': '',
        'location': GeoPoint(0, 0),
        'name': '',
        'open': false,
        'owner': constant.user_id,
        'price': '',
      })
      .then((value) =>(
        FirebaseFirestore.instance
        .collection("local")
        .doc(value.id)
        .collection("tags")
        .add({
          'tag_id': "default_id",
        }).catchError((error) => print("Failed to add local tag: $error"))
      ))
      .then((value) => (
        FirebaseFirestore.instance
          .collection("local")
          .doc(value.id)
          .collection("image")
          .add({
            'user_id': 'default_id',
            'image': 'default_image',
          }).catchError((error) => print("Failed to add image path: $error"))
      ))
      .catchError((error) => print("Failed to add local: $error"));
      
      //change screen
      constant.settingsScreenChoosenType = "local";

      setState(() {  });
    } else {
      //do nothing
    }
  }

  _saveUser() async {

    bool userExists = false;
    bool emailExists = false;

    var query = await FirebaseFirestore.instance
            .collection('users')
            .where('name', isEqualTo: textController1.text)
            .get();
    // if (query.docs.isEmpty) {
    //   userExists = true;
    // }

    // var documentID = snapshot.id;
    //   var name = snapshot['name'].toString();
    for (var snapshot in query.docs) {
      
      if (snapshot.id != constant.user_id) {
        userExists = true;
      }
    }

    query = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: textController4.text)
            .get();
    for (var snapshot in query.docs) {
      if (snapshot.id != constant.user_id) {
        emailExists = true;
      }

    }

    if (textController2.text != textController3.text) {
      return _showAlertDialog(
        context,
        "Incorrect Password",
        "Both passwords needs to be the same"
      );
    } else if (userExists && emailExists) {
      return _showAlertDialog(
        context,
        "Unavailable Values",
        "Both the name and email introduced are being used by another user"
      );
    } else if (emailExists) {
      return _showAlertDialog(
        context,
        "Unavailable Email",
        "The email introduced is already being used by another user"
      );
    } else if (userExists) {
      return _showAlertDialog(
        context,
        "Unavailable Name",
        "The name introduced is already being used by another user"
      );
    } else if (!userExists && !emailExists) {
      FirebaseFirestore.instance
        .collection("users")
        .doc(constant.user_id)
        .update({
          'name': textController1.text,
          'password': textController2.text,
          'email': textController4.text,
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

  static void _logOut() async {
    try {
      constant.auth.signOut();
      constant.googleSignIn.signOut();
      await FirebaseFirestore.instance.clearPersistence();
      return  FirebaseAuth.instance.signOut();
    } on Exception catch(_) {
      print('El usuari no ha iniciat la sessió');
    }
  }
}
import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:ambulant_project/widget/settings/botons_superiors.dart';
import 'package:ambulant_project/widget/settings/settings_user_body.dart';
import 'package:ambulant_project/widget/settings/settings_local_body.dart';

//
// class SettingsScreen extends StatefulWidget {
//   const SettingsScreen({Key? key, String? values}) : super(key: key);

//   @override
//   State<SettingsScreen> createState() => _SettingsScreen();
// }

// class _SettingsScreen extends State<SettingsScreen> {

//   @override
//   Widget build(BuildContext context) {
//     //return Text(constant.user_id);
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Text('settings screen'),
//         IconButton(
//           onPressed: ()=>_logOut(),
//           icon: Icon(Icons.delete),
//         ),
//       ]
//     );
//   }

//   static void _logOut() async {
//     try {
//       constant.auth.signOut();
//       constant.googleSignIn.signOut();
//       await FirebaseFirestore.instance.clearPersistence();
//       return  FirebaseAuth.instance.signOut();
//     } on Exception catch(_) {
//       print('El usuari no ha iniciat la sessió');
//     }
//   }
// }

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, String? values}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  // late TextEditingController textController1;
  // late TextEditingController textController2;
  // late TextEditingController textController3;
  // late TextEditingController textController4;
  // late bool passwordVisibility;
  // late bool passwordRepeatVisibility;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _getIfUserHasData();

    //   for (var snapshot in query.docs) {
    //   name = snapshot['name'].toString();
    //   email = snapshot['email'].toString();
    //   if (name == nameController.text || email == emailAddressController.text) {
    //     validacio = false;
    //   }
    // }

    //         constant.userHasShop = !query.data['client'];

    // textController1 = TextEditingController(text: '');
    // textController2 = TextEditingController(text: '');
    // textController3 = TextEditingController(text: '');
    // textController4 = TextEditingController(text: '');

    // passwordVisibility = false;
    // passwordRepeatVisibility = false;

    // textController1 = TextEditingController(text: '[User Name]');
    // textController2 = TextEditingController(text: '[New Password]');
    // textController3 = TextEditingController(text: '[New Password]');
    // textController4 = TextEditingController(text: '[User Email]');
  }

  // static void _logOut() async {
  //   try {
  //     constant.auth.signOut();
  //     constant.googleSignIn.signOut();
  //     await FirebaseFirestore.instance.clearPersistence();
  //     return  FirebaseAuth.instance.signOut();
  //   } on Exception catch(_) {
  //     print('El usuari no ha iniciat la sessió');
  //   }
  // }

  _updateParent() {
    setState(() {});
  }

  _getIfUserHasData() async {
    var query = await FirebaseFirestore.instance.collection('users').doc(constant.user_id).get();
    constant.userHasShop = query['client'];

    _updateParent();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body:
      // Column(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [

      //       //MediaQuery.of(context).size.width * 0.75,
      //       SettingsButtons(notifyParent: () { _updateParent(); },),
      //       SingleChildScrollView(
      //         child: 
      //          _returnBody(),
      //       ),

      //     ],
      //   ), 

      Container(
        child: Column(
          children: <Widget>[
            Container(
              child: SettingsButtons(notifyParent: () { _updateParent(); },),
            ),
            Expanded(
              child: Theme(
                //Inherit the current Theme and override only the accentColor property
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: constant.ColorPrimary)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      // All your scroll views
                      _returnBody(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    
      // SingleChildScrollView(
      //   child: 
      //   Column(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.start,
      //     children: [
            
      //       SettingsButtons(notifyParent: () { _updateParent(); },),
            
      //       _returnBody(),

      //     ],
      //   ),
      // ),
    );
  }

  _returnBody() {
    if (constant.settingsScreenChoosenType == "user") {
      return SettingsUserBody(notifyParent: () { _updateParent(); },);
    } else {
      //not yet created();
      return ConfigShopPageWidget(notifyParent: () { _updateParent(); },);
    }
  }
}

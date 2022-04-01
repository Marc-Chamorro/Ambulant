import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import '../main_body/mainbody_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../login&singup/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  //const ({ Key? key }) : super(key: key);

  // late TextEditingController emailAddressController;
  // late TextEditingController passwordController;
  // late bool passwordVisibility;
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  //@override
  @override
  _LoginSignupScreen createState() => _LoginSignupScreen();
}

class _LoginSignupScreen extends State<LoginSignupScreen> {
  late TextEditingController emailAddressController;
  late TextEditingController passwordController;
  late TextEditingController nameController;
  late bool passwordVisibility;
  late bool switchListTileValue;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late bool incorrect_values = false, available_user = true;
  //FocusNode FocusName = new FocusNode();

  // ignore: non_constant_identifier_names
  bool inici_sessio = true;

  @override
  void initState() {
    super.initState();
    emailAddressController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    passwordVisibility = false;
    switchListTileValue = false;
  }

  @override
  Widget build(BuildContext context) {
    //final EstatBotons = estatBotons(inici_sessio: true);
    // incorrect_values = false;
    // available_user = true;
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        // if (snapshot.hasError) {
        //   print("error");
        // }

        // if (snapshot.connectionState == ConnectionState.done) {

        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: scaffoldKey,
          backgroundColor: constant.ColorPrimary, //Color(0xFFFFB300),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      stops: const [
                        0,
                        0.45,
                        //0.90,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [constant.ColorSecond, constant.ColorPrimary],
                    )),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 70, 0, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 24, 0, 60),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Ambulant ',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFFFEFEFE),
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 0, 0),
                                    child: Image.asset(
                                      /*Image.network(
                                        'https://cdn.discordapp.com/attachments/788107244973719632/934127911315836928/LogoSinFondoRECORTADO.png',*/
                                      'assets/images/LogoSinFondoRECORTADO.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //botons(inici_sessio),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  20, 0, 20, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start, //MainAxisSize.max,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: SizedBox(
                                          width: 100,
                                          height: 50,
                                          child: TextButton(
                                            onPressed: () => setState(
                                              () => inici_sessio = true,
                                            ),
                                            child: Text(
                                              'Sign In',
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color:
                                                    _canviarEstatBotonPrimari(
                                                        inici_sessio),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0x004B39EF),
                                                side: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 12, 0, 0),
                                        //EdgeInsets.fromLTRB(5, 1, 5, 5),
                                        child: Container(
                                          width: 90,
                                          height: 3,
                                          //margin: EdgeInsets.fromLTRB(1, 1, 1, 1),
                                          decoration: BoxDecoration(
                                            color:
                                                _canviarEstatBotonPrimariBarra(
                                                    inici_sessio),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(1),
                                        child: SizedBox(
                                          width: 100,
                                          height: 50,
                                          child: TextButton(
                                            onPressed: () => setState(
                                              () => inici_sessio = false,
                                            ),
                                            child: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                fontFamily: 'Lexend Deca',
                                                color:
                                                    _canviarEstatBotonPrimari(
                                                        !inici_sessio),
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0x004B39EF),
                                                side: const BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                )),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0, 12, 0, 0),
                                        child: Container(
                                          width: 90,
                                          height: 3,
                                          decoration: BoxDecoration(
                                            color:
                                                _canviarEstatBotonPrimariBarra(
                                                    !inici_sessio),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            _cosAPP(inici_sessio),
                            /*Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                                    child: TextFormField(
                                      controller: emailAddressController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Email Address',
                                        //alignLabelWithHint: true,
                                        labelStyle: const TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0x98FFFFFF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          height: 5
                                        ),
                                        hintText: 'Enter your email...',
                                        hintStyle: const TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0x98FFFFFF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF595858),
                                        contentPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                20, 24, 20, 24),
                                      ),
                                      style: const TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: !passwordVisibility,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        labelStyle:
                                            TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0x98FFFFFF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                          height: 5
                                        ),
                                        hintText: 'Enter your password...',
                                        hintStyle:
                                            TextStyle(
                                          fontFamily: 'Lexend Deca',
                                          color: Color(0x98FFFFFF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFF595858),
                                        contentPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                20, 24, 20, 24),
                                        suffixIcon: InkWell(
                                          onTap: () => setState(
                                            () => passwordVisibility =
                                                !passwordVisibility,
                                          ),
                                          child: Icon(
                                            passwordVisibility
                                                ? Icons.visibility_outlined
                                                : Icons.visibility_off_outlined,
                                            color: Color(0x98FFFFFF),
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontFamily: 'Lexend Deca',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
                                    child: SizedBox(
                                      width: 230,
                                      height: 60,
                                      child: TextButton(
                                        onPressed: () {
                                          print('Button-Login pressed ...');
                                        },
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            fontFamily: 'Lexend Deca',
                                            color: Color(0xFF010101),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        style: TextButton.styleFrom(
                                          elevation: 3,
                                          backgroundColor: Colors.white,
                                          side: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ), */
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
        //};
      },
    );
  }

  // ignore: non_constant_identifier_names
  _cosAPP(bool inici_sessio) {
    if (inici_sessio) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _returnTextBoxName(),
          _returnTextBoxPassword(),
          _returnButtonLogin(),
          _returnVerificationMessage(),
          _returnGoogleLogin(),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _returnTextBoxName(),
          _returnTextBoxEmail(),
          _returnTextBoxPassword(),
          _returnUserType(),
          _returnButtonSignup(),
          _returnVerificationSignUp(),
        ],
      );
    }
  }

  _returnGoogleLogin() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
      child: IconButton(
        //borderColor: Colors.transparent,
        splashRadius: 30,
        //borderWidth: 1,
        iconSize: 60,
        color: Colors.white,
        icon: const FaIcon(
          FontAwesomeIcons.google,
          color: Colors.black,
          size: 30,
        ),
        onPressed: () {
          _googleLogin();
          //googleLogin(),
          print('IconButton pressed ...');
        },
      ),
    );
  }

  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final GoogleSignIn googleSignIn = GoogleSignIn();

  _googleLogin() async {
    //  final FirebaseAuth auth = FirebaseAuth.instance;
    //  final GoogleSignIn googleSignIn = GoogleSignIn();

    constant.auth = FirebaseAuth.instance;
    constant.googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount = await constant.googleSignIn.signIn();
 
    //Future<void> signup(BuildContext context) async {

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken
      );
      
      // Getting users credential
      UserCredential result = await constant.auth.signInWithCredential(authCredential); 

      // String name = result.additionalUserInfo!.profile!.values.
      // String email = result.additionalUserInfo!.profile.toString();
      // String additional = result.credential.toString();
      
      if (result != null) {
        User? user = result.user;
        String email = result.user!.email.toString();
        String name = result.user!.displayName.toString();
        _createAndCheckUserGoogle(email, name);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => AppBody()));
      }  // if result not null we simply call the MaterialpageRoute,
        // for go to the HomePage screen

      //   Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return AppBody();
      //   }),
      //   (route) => false,
      // );
    }
    //}

    //CHECK IF USER EXISTS WITH EMAIL
    //IF EXISTS EXTRACT USER ID
    //IF IT DOES NO EXIST CREATE THE USER WITH THE USER INFO AND GOODBYE
  }

    //CHECK IF USER EXISTS WITH EMAIL
    //IF EXISTS EXTRACT USER ID
    //IF IT DOES NO EXIST CREATE THE USER WITH THE USER INFO AND GOODBYE

  Future<String> _checkvailableUserName(String username) async {
    bool user_exists = true;
    String name = username;
    int i = 0;
    while (user_exists) {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      //unencrypt password in the future here (use the name as the key to unencrypt)
      var collection = FirebaseFirestore.instance.collection('users').where(
          "name",
          isEqualTo:
              username); //.where("password", isEqualTo: "12345aA");
      var querySnapshots = await collection.get();

      if (querySnapshots.docs.isEmpty) {
         
        incorrect_values = false;
        return name;
      } else {
        name = username + i.toString();
        i++;
      }
    }
  }

  _createAndCheckUserGoogle(String emailValue, String nameValue) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var collection = FirebaseFirestore.instance.collection('users').where("email", isEqualTo: emailValue);/*.where("name", isEqualTo: nameValue)*/
    var querySnapshots = await collection.get();

    bool validacio = true;
    for (var snapshot in querySnapshots.docs) {
      // name = snapshot['name'].toString();
      String email = snapshot['email'].toString();
      if (/*nameValue == nameController.text && */email == emailValue) {
        validacio = false;
        constant.user_id = snapshot.id;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            return AppBody();
          }),
          (route) => false,
        );
      }
    }

    if (validacio) {
      //CollectionReference users = FirebaseFirestore.instance.collection('users');

      //IF USER DOES NOT EXIST, CREATE IT, GIVING IT A NAME OF A NON EXISTING USER

      //CHECK USER EXISTS
      
      String user = await _checkvailableUserName(nameValue) as String;

      firestore.collection("users").add({
        // "name" : "john",
        // "age" : 50,
        // "email" : "example@example.com",
        // "address" : {
        //   "street" : "street 24",
        //   "city" : "new york"
        // }
        'name': user, // John Doe
        'email': emailValue, // Stokes and Sons
        'client': false, //
        'shop': "shop id",
        'password': "default" + user, //// 42

        'descompte': 0,
        'date': DateTime.now().subtract(const Duration(days: 1)),

        'geoposition': GeoPoint(0, 0),

        //'geoposition.lat': "0.000000",
        //'geoposition.lon': "0.000000",
      })
          //.then((value) =>(constant.user_id = value.id))
          .catchError((error) =>
              available_user = false /*print("Failed to add user: $error")*/);

      var collection = FirebaseFirestore.instance.collection('users').where(
          "name",
          isEqualTo:
              user); //.where("password", isEqualTo: "12345aA");
      var querySnapshots = await collection.get();
      incorrect_values = false;
      
      String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());

      for (var snapshot in querySnapshots.docs) {
        constant.user_id = snapshot.id;

        firestore
            .collection("users")
            .doc(constant.user_id)
            .collection("favourites")
            .add({
          'local': "default local id",
        }).catchError((error) => print("Failed to add user: $error"));

        firestore
            .collection("users")
            .doc(constant.user_id)
            .collection("discounts")
            .add({
          'date': FieldValue.serverTimestamp(),
          'discount': 0,
          'local':  "default local id",
        }).catchError((error) => print("Failed to add user: $error"));

        // Firestore.instance.runTransaction((Transaction tx) {
        //     tx.set(Firestore.instance.collection('path').document('documentPath')
        //         .collection('subCollectionPath').document(), {'TestData', 'Data'});
        // })

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            return AppBody();
          }),
          (route) => false,
        );

        // Future<void> registerUser() {
        // // Call the user's CollectionReference to add a new user
        //   return users.add({
        //     'name': nameController.text, // John Doe
        //     'email': emailAddressController.text, // Stokes and Sons
        //     'client': false,//
        //     'password': passwordController.text,//// 42
        //   })
        //       .then((value) =>(constant.user_id = value.id))
        //       .catchError((error) => available_user = false/*print("Failed to add user: $error")*/);
        // }
        //encrypt in the future here

      }
    } else {
      available_user = false;
    }
  }

  _returnUserType() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
      child: SwitchListTile(
        value: switchListTileValue /*??= false*/,
        onChanged: (newValue) => setState(() => switchListTileValue = newValue),
        title: Text(
          '¿Do you have a shop?',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
          ),
        ),
        tileColor: Color(0xFFF5F5F5),
        activeColor: constant.backgroundText,
        dense: false,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  _returnButtonSignup() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: SizedBox(
        width: 230,
        height: 60,
        child: TextButton(
          onPressed: () {
            // ignore: avoid_print
            print('Button-SignUp pressed ...' +
                emailAddressController.text.toString() +
                passwordController.text.toString());
            _createUser();
            setState(() {incorrect_values = true;});
          },
          child: const Text(
            'Create',
            style: TextStyle(
              fontFamily: 'Lexend Deca',
              color: Color(0xFF010101),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: TextButton.styleFrom(
              elevation: 3,
              backgroundColor: Colors.white,
              side: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
      ),
    );
  }

  _returnButtonLogin() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
      child: SizedBox(
        width: 230,
        height: 60,
        child: TextButton(
          onPressed: () {
            // ignore: avoid_print
            print('Button-Login pressed ...' +
                emailAddressController.text.toString() +
                passwordController.text.toString());
            _loginCheck();
            setState(() {incorrect_values = true;});
          },
          child: const Text(
            'Login',
            style: TextStyle(
              fontFamily: 'Lexend Deca',
              color: Color(0xFF010101),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: TextButton.styleFrom(
              elevation: 3,
              backgroundColor: Colors.white,
              side: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
        ),
      ),
    );
  }

  _returnTextBoxName() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: nameController,
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'Name',
          //alignLabelWithHint: true,
          labelStyle: const TextStyle(
              fontFamily: 'Lexend Deca',
              color: Color(0x98FFFFFF),
              fontSize: 14,
              fontWeight: FontWeight.normal,
              height: 5),
          hintText: 'Enter your name...',
          hintStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0x98FFFFFF),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color(0xFF595858),
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
        ),
        style: const TextStyle(
          fontFamily: 'Lexend Deca',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  _returnTextBoxPassword() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: passwordController,
        obscureText: !passwordVisibility,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: const TextStyle(
              fontFamily: 'Lexend Deca',
              color: Color(0x98FFFFFF),
              fontSize: 14,
              fontWeight: FontWeight.normal,
              height: 5),
          hintText: 'Enter your password...',
          hintStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0x98FFFFFF),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color(0xFF595858),
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
          suffixIcon: InkWell(
            onTap: () => setState(
              () => passwordVisibility = !passwordVisibility,
            ),
            child: Icon(
              passwordVisibility
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: const Color(0x98FFFFFF),
              size: 20,
            ),
          ),
        ),
        style: const TextStyle(
          fontFamily: 'Lexend Deca',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  _returnTextBoxEmail() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
      child: TextFormField(
        cursorColor: Colors.white,
        controller: emailAddressController,
        obscureText: false,
        decoration: InputDecoration(
          labelText: 'Email Address',
          //alignLabelWithHint: true,
          labelStyle: const TextStyle(
              fontFamily: 'Lexend Deca',
              color: Color(0x98FFFFFF),
              fontSize: 14,
              fontWeight: FontWeight.normal,
              height: 5),
          hintText: 'Enter your email...',
          hintStyle: const TextStyle(
            fontFamily: 'Lexend Deca',
            color: Color(0x98FFFFFF),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color(0xFF595858),
          contentPadding: const EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
        ),
        style: const TextStyle(
          fontFamily: 'Lexend Deca',
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  _returnVerificationMessage() {
    String text = '';
    if (incorrect_values) {
      text = 'Incorrect user or Password';
    }

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }

  _returnVerificationSignUp() {
    String text = '';
    if (!available_user) {
      text = 'User already exists!';
    }

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: Colors.white,
        ),
      ),
    );
  }

  _createUser() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var collection = FirebaseFirestore.instance.collection('users').where(
        "name",
        isEqualTo:
            nameController.text); //.where("password", isEqualTo: "12345aA");
    var querySnapshots = await collection.get();
    var name = "";
    var email = "";
    bool validacio = true;
    for (var snapshot in querySnapshots.docs) {
      name = snapshot['name'].toString();
      email = snapshot['email'].toString();
      if (name == nameController.text || email == emailAddressController.text) {
        validacio = false;
      }
    }
    //here check if user exists and if not create it
    if (validacio && nameController.text != "" && emailAddressController.text != "" && passwordController.text != "") {
      //CollectionReference users = FirebaseFirestore.instance.collection('users');

      firestore.collection("users").add({
        // "name" : "john",
        // "age" : 50,
        // "email" : "example@example.com",
        // "address" : {
        //   "street" : "street 24",
        //   "city" : "new york"
        // }
        'name': nameController.text, // John Doe
        'email': emailAddressController.text, // Stokes and Sons
        'client': !switchListTileValue, //
        'shop': "shop id",
        'password': passwordController.text, //// 42

        'descompte': 0,
        'date': DateTime.now().subtract(const Duration(days: 1)),

        'geoposition': GeoPoint(0, 0),

        // 'geoposition.lat': "0.000000",
        // 'geoposition.lon': "0.000000",
      })
          //.then((value) =>(constant.user_id = value.id))
          .catchError((error) =>
              available_user = false /*print("Failed to add user: $error")*/);

      var collection = FirebaseFirestore.instance.collection('users').where(
          "name",
          isEqualTo:
              nameController.text); //.where("password", isEqualTo: "12345aA");
      var querySnapshots = await collection.get();
      incorrect_values = false;

      String cdate = DateFormat("yyyy-MM-dd").format(DateTime.now());

      for (var snapshot in querySnapshots.docs) {
        constant.user_id = snapshot.id;

        firestore
            .collection("users")
            .doc(constant.user_id)
            .collection("favourites")
            .add({
          'local': "default local id",
        }).catchError((error) => print("Failed to add user: $error"));

        firestore
            .collection("users")
            .doc(constant.user_id)
            .collection("discounts")
            .add({
          'date': FieldValue.serverTimestamp(),
          'discount': 0,
          'local':  "default local id",
        }).catchError((error) => print("Failed to add user: $error"));

        // Firestore.instance.runTransaction((Transaction tx) {
        //     tx.set(Firestore.instance.collection('path').document('documentPath')
        //         .collection('subCollectionPath').document(), {'TestData', 'Data'});
        // })

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            return AppBody();
          }),
          (route) => false,
        );

        // Future<void> registerUser() {
        // // Call the user's CollectionReference to add a new user
        //   return users.add({
        //     'name': nameController.text, // John Doe
        //     'email': emailAddressController.text, // Stokes and Sons
        //     'client': false,//
        //     'password': passwordController.text,//// 42
        //   })
        //       .then((value) =>(constant.user_id = value.id))
        //       .catchError((error) => available_user = false/*print("Failed to add user: $error")*/);
        // }
        //encrypt in the future here

      }
    } else {
      available_user = false;
    }
  }

  _loginCheck() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    //unencrypt password in the future here (use the name as the key to unencrypt)
    var collection = FirebaseFirestore.instance.collection('users').where(
        "name",
        isEqualTo:
            nameController.text); //.where("password", isEqualTo: "12345aA");
    var querySnapshots = await collection.get();
    incorrect_values = false;
    if (querySnapshots.docs.isEmpty) {
      incorrect_values = true;
    }
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id;
      var name = snapshot['name'].toString();
      var password = snapshot['password'].toString();

      print(name);
      print(password);
      print(documentID);

      constant.user_id = documentID;

      if (name == nameController.text &&
          password == passwordController.text &&
          !incorrect_values) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            return AppBody();
          }),
          (route) => false,
        );
      } else {
        incorrect_values = true;
      }
    }

    // var doc_ref = await FirebaseFirestore.instance.collection('users').doc().collection("Dates").getDocuments();
    // doc_ref.documents.forEach((result) {
    // print(result.documentID);
    // });

    // FirebaseFirestore.instance
    // .collection('users')
    // .get()
    // .doc(userId)
    // .get()
    // .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     print('Document exists on the database');
    //   }
    // });
  }

  // ignore: non_constant_identifier_names
  _canviarEstatBotonPrimari(bool inici_sessio) {
    if (inici_sessio) {
      return Colors.white;
    } else {
      return const Color(0x98FFFFFF);
    }
  }

  // _canviarEstatBotonSecundari(bool inici_sessio) {
  //     if (inici_sessio) {
  //       return Color(0x98FFFFFF);
  //     } else {
  //       return Colors.white;
  //     }
  // }

  // ignore: non_constant_identifier_names
  _canviarEstatBotonPrimariBarra(bool inici_sessio) {
    if (inici_sessio) {
      return Colors.white;
    } else {
      return const Color(0xFF252427);
    }
  }
}
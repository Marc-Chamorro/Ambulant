import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:ambulant_project/widget/scan/targeta_user.dart';
import 'package:ambulant_project/widget/scan/historial.dart';
import 'package:ambulant_project/widget/scan/generate_qr.dart';
import 'package:ambulant_project/widget/scan/read_qr.dart';

class Scanscreen extends StatefulWidget {
  const Scanscreen({Key? key, String? values}) : super(key: key);

  @override
  _Scanscreen createState() => _Scanscreen();
}

class _Scanscreen extends State<Scanscreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

   @override
  void initState() {
    super.initState();

    _deleteOldDiscounts();
  }

  @override
  Widget build(BuildContext context) {
    _getLastUsedDiscount();
    _checkDate();

    return Scaffold(
      key: scaffoldKey,
      appBar: _appBarScan(),
      backgroundColor: Color(0xFFF5F5F5),
      body: Theme(
        //Inherit the current Theme and override only the accentColor property
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: constant.ColorPrimary)
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ScanTargetauser(
                notifyParent: () {
                  _updateParent();
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x39000000),
                        offset: Offset(0, -1),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 16, 20, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Quick Service',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF090F13),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ReadQR(
                              notifyParent: () {
                                _updateParent();
                              },
                            ),
                            GenerateQR(
                              notifyParent: () {
                                _updateParent();
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Transaction',
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF090F13),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      HistorialUser(
                        notifyParent: () {
                          _updateParent();
                        },
                      ),
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

  _appBarScan() {
    return AppBar(
      backgroundColor: Color(0xFFFFB300),
      automaticallyImplyLeading: false,
      title: const Padding(
        padding: EdgeInsetsDirectional.fromSTEB(100, 10, 0, 10),
        child: Text(
          'Discounts',
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

  _updateParent() {
    setState(() {});
  }

  _getLastUsedDiscount() async {
    var query = await FirebaseFirestore.instance
        .collection('users')
        .doc(constant.user_id)
        .collection('discounts')
        .orderBy('date', descending: true)
        .get(); //constant.user_id

    bool primer_valor = false;
    for (var snapshot in query.docs) {
      if (!primer_valor) {
        var date = snapshot['date'].toString();

        print(date);
      }
    }
  }

  _checkDate() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(constant.user_id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        try {
          dynamic nested = documentSnapshot.get(FieldPath(['date']));
          constant.userLastDiscount = documentSnapshot.get(FieldPath(['date']));
          print(nested);
        } on StateError catch (e) {
          constant.userLastDiscount = DateTime.now();
          print('No nested field exists!');
        }
      }
    });
  }

  _deleteOldDiscounts() async {
    var discountsQuery = await FirebaseFirestore.instance
        .collection("users")
        .doc(constant.user_id)
        .collection("discounts")
        .orderBy('date', descending: true)
        .get();

    int historial_nombre = discountsQuery.docs.length;

    while (historial_nombre > 10) {
      FirebaseFirestore.instance
      .collection("users")
      .doc(constant.user_id)
      .collection("discounts")
      .doc(discountsQuery.docs[historial_nombre - 1].id)
      .delete()
      .then((_) => print('Local deleted: ' + discountsQuery.docs[historial_nombre - 1].id))
      .catchError((error) => print('Delete failed: $error'));;
      historial_nombre--;
    }

    setState(() {});
    

    // int contador = 0, total_descompte = 0, total_a_eliminar = 0;
    // bool restar = true;

    // for (var snapshot in discountsQuery.docs) {
    //   contador++;

    //   if (contador > 10) {
    //     total_a_eliminar++;
    //   }

    //   // if (contador <= 10 && restar) {
    //   //   int discount = snapshot['discount'];

    //   //   if (discount > 0) { //add maximum lines available
    //   //     total_descompte = total_descompte + discount;
    //   //   } else {
    //   //     FirebaseFirestore.instance
    //   //         .collection("users")
    //   //         .doc(constant.user_id)
    //   //         .update({'descompte': total_descompte});
    //   //     restar = false;
    //   //   }
    //   // }
    // }
  }
}

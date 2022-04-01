import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQR extends StatefulWidget {
  final Function() notifyParent;
  GenerateQR({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _GenerateQR createState() => _GenerateQR();
}

class _GenerateQR extends State<GenerateQR> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _popUpMoreDetails(context);
          print("Button pressed");
        },
        child: Container(
          width: 150,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Color(0x39000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.attach_money_sharp,
                  color: Color(0xFF1E2429),
                  size: 40,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Text(
                    'Use discount',
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
        ));
  }

  _checkIfDiscount(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(constant.user_id)
            .get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            int Udiscount = snapshot.data['descompte'];
            constant.userTotalDiscount = Udiscount;
            if (constant.userTotalDiscount <= 0) {
              return Center(child: Text('No discount available'));
            }
            return QrImage(
                data: 
                    "client" + 
                    "'" +
                    constant.user_id +
                    "'" +
                    constant.userTotalDiscount.toString() +
                    "'" +
                    DateTime.now().toString(),
                size: 275.0);
          }
          return Center(child: CircularProgressIndicator());
        });
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
                                widget.notifyParent();
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
}

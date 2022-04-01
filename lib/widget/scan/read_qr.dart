import 'dart:developer';

import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter/foundation.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ReadQR extends StatefulWidget {
  final Function() notifyParent;
  ReadQR({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _ReadQR createState() => _ReadQR();
}

class _ReadQR extends State<ReadQR> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _checkDate(context);
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
                  Icons.photo_camera,
                  color: Color(0xFF1E2429),
                  size: 40,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                  child: Text(
                    'Read QR',
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

  _checkDate(BuildContext context) {
    // return FutureBuilder(
    //     future: FirebaseFirestore.instance
    //         .collection('users')
    //         .doc(constant.user_id)
    //         .get(),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       if (snapshot.hasData) {
    //         var Ufecha = snapshot.data['date'];
    //         constant.userLastDiscount = Ufecha;
    //         if ((DateTime.now().difference(Ufecha)).inHours < 12) {
    //           return _popUpMoreDetails(context);
    //         }
    //         // Navigator.of(context).push(MaterialPageRoute(
    //         //   builder: (context) => const QRViewExample(),
    //         // ));
    //         return _popUpMoreDetails(context);
    //       }
    //       return Center(child: CircularProgressIndicator());
    //     });
    // var query =
    //     DateTime.fromMicrosecondsSinceEpoch(constant.userLastDiscount * 1000);

    // if ((DateTime.now().difference(query)).inHours < 12) {
    //   return _popUpMoreDetails(context);
    // }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => QRViewExample(
        notifyParentQR: () {
          _updateParent();
        },
      ),
    ));
    // return _popUpMoreDetails(context);
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
                      child: Text(
                          'Wait at least 12 hours to introduce another discount'),
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

  _updateParent() {
    widget.notifyParent();
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
        setState(() {
          result = scanData;
        });
        print(result);
        _addDiscount(result!.code.toString());
        _deleteOldDiscounts();
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

  _addDiscount(String s) {
    var idx = s.split("'");
    try {
      if (idx[0].trim() == "shop") {
        String idLocal = idx[1].trim(); //s.substring(0, idx).trim();
        print(idLocal);
        int descompte = int.parse(idx[2].trim()); //int.parse(s.substring(idx + 1).trim());
        print(descompte);
        DateTime data = DateTime.parse(idx[3].trim());
        print(data);

        if (constant.userTotalDiscount + descompte <= 15) {
          _addDiscountFirestore(idLocal, descompte, data);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  _addDiscountFirestore(String idLocal, int descompte, DateTime data) async {
    String id_fav;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(constant.user_id)
        .collection("discounts")
        .add({
          'date': data, // 2022-03-07 17:37:58
          'discount': descompte, // 15
          'local': idLocal, // 0Bbpz3qnmz3UEQkfhj3b
        })
        .then((value) => (id_fav = value.id))
        .catchError((error) => print("Failed to add user: $error"));
  }

  _deleteOldDiscounts() async {
    var discountsQuery = await FirebaseFirestore.instance
        .collection("users")
        .doc(constant.user_id)
        .collection("discounts")
        .orderBy('date', descending: true)
        .get();

    int contador = 0, total_descompte = 0;
    bool restar = true;

    for (var snapshot in discountsQuery.docs) {
      contador++;

      if (contador > 10) {
        var documentID = snapshot.id;
        // var password = snapshot['password'].toString();

        print(documentID);

        FirebaseFirestore.instance
            .collection("user")
            .doc(constant.user_id)
            .collection("discounts")
            .doc(documentID)
            .delete();
      }

      if (contador <= 10 && restar) {
        int discount = snapshot['discount'];

        if (discount > 0) { //add maximum lines available
          total_descompte = total_descompte + discount;
        } else {
          FirebaseFirestore.instance
              .collection("users")
              .doc(constant.user_id)
              .update({'descompte': total_descompte});
          restar = false;
        }
      }
    }

    
        setState(() {});
        Future.delayed(Duration.zero, () {
          Navigator.pop(context);
        });

        widget.notifyParentQR();
  }
}

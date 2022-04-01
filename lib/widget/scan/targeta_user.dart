import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:cloud_firestore/cloud_firestore.dart';

class ScanTargetauser extends StatefulWidget {
  final Function() notifyParent;
  ScanTargetauser({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _ScanTargetauser createState() => _ScanTargetauser();
}

class _ScanTargetauser extends State<ScanTargetauser> {
  @override
  Widget build(BuildContext context) {
    String Uname;
    int Udiscount;
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(constant.user_id)
            .get(), //constant.user_id
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            Uname = snapshot.data['name'].toString();
            Udiscount = snapshot.data['descompte'];
            constant.userTotalDiscount = Udiscount;
            return _body(Uname, Udiscount);
          }
          Uname = "---";
          Udiscount = 0;
          return _body(Uname, Udiscount);
        });
  }

  _body(String name, int discount) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.92,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              color: Color(0x4B1A1F24),
              offset: Offset(0, 2),
            )
          ],
          gradient: LinearGradient(
            colors: [Color(0xFF00968A), Color(0xFFF2A384)],
            stops: [0, 1],
            begin: AlignmentDirectional(0.94, -1),
            end: AlignmentDirectional(-0.94, 1),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.78,
                    child: Text(
                      name,
                      style: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Total Discount',
                    style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 8, 20, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    discount.toString() + '%',
                    style: TextStyle(
                      fontFamily: 'Lexend Deca',
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Maximum Available Discount',
                    style: TextStyle(
                      fontFamily: 'Roboto Mono',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    discount.toString() + '/15',
                    style: TextStyle(
                      fontFamily: 'Roboto Mono',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

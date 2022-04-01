import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constant/constant.dart' as constant;
import 'package:cloud_firestore/cloud_firestore.dart';

class HistorialUser extends StatefulWidget {
  final Function() notifyParent;
  HistorialUser({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _HistorialUser createState() => _HistorialUser();
}

class _HistorialUser extends State<HistorialUser> {

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').doc(constant.user_id).collection('discounts').orderBy('date', descending: true).get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.docs.length > 0) {
            return _construirLlistat(snapshot);
          }
          return Center(child: const Text('No data found'),);
        }
        return Center(child: const CircularProgressIndicator(),);
      }
    );
  }
    
  _construirLlistat(AsyncSnapshot snapshot) {
    return 
    Expanded(child:
    ListView.builder(
      itemCount: snapshot.data.docs.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        String ID = snapshot.data.docs[i]['local'].toString().trim();
        int percentatge = snapshot.data.docs[i]['discount'];
        String accio;
        if (percentatge < 0) {
          accio = "Extract";
        } else {
          accio = "Acumulate";
        }
        DateTime data = snapshot.data.docs[i]['date'].toDate();

        //return Text('test value' + percentatge.toString());
        if (ID == "default local id" && snapshot.data.docs.length == 1) {
          return _emptyTargeta();
          //return SizedBox(height: 0,);
        } else if (ID == "default local id") {
          return SizedBox(height: 0,);
        } 
        return _targeta(ID, percentatge, data, accio);
      }
    ),
    );
  }
    
    
  _targeta(String ID, int percentatge, DateTime data, String accio) {
    String localName = "---";
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.885,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xFFF4F5F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0x6639D2C0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Icon(
                        Icons.monetization_on_rounded,
                        color: Color(0xFF39D2C0),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        FutureBuilder(
                          future: FirebaseFirestore.instance.collection('local').doc(ID).get(), //constant.user_id
                          builder: (BuildContext context, AsyncSnapshot snapshot){
                            if (!snapshot.hasData) {
                                return Text(
                                  localName,
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF1E2429),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                );
                            }

                            try {
                                  localName = snapshot.data['name'].toString();
                                } on Exception catch (exception) {
                                  localName = "---";
                                } catch (error) {
                                  localName = "---";
                                }
                          
                            return Text(
                              localName,
                              style: TextStyle(
                                fontFamily: 'Lexend Deca',
                                color: Color(0xFF1E2429),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 4, 0, 0),
                          child: Text(
                            accio,
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF090F13),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(6, 0, 12, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        percentatge.toString() + '%',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF39D2C0),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 4, 0, 0),
                        child: Text(
                          DateFormat.yMMMd().add_jm().format(data).toString(),
                          //data.toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }

  _emptyTargeta() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.885,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xFFF4F5F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Color(0x6639D2C0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                      child: Icon(
                        Icons.monetization_on_rounded,
                        color: Color(0xFF39D2C0),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            'Start accumulating!',
                            style: TextStyle(
                              fontFamily: 'Lexend Deca',
                              color: Color(0xFF1E2429),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: true,
                          ),
                        ),
                        // Text(
                        //   'Start accumulatng now!',
                        //   style: TextStyle(
                        //     fontFamily: 'Lexend Deca',
                        //     color: Color(0xFF1E2429),
                        //     fontSize: 18,
                        //     fontWeight: FontWeight.w500,
                        //   ),
                        // ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0, 4, 0, 0),
                          child: Text(
                            'No discounts yet',
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
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(6, 0, 12, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '0%',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: Color(0xFF39D2C0),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0, 4, 0, 0),
                        child: Text(
                          DateFormat.yMMMd().add_jm().format(DateTime.now()).toString(),
                          //data.toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: Color(0xFF090F13),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}
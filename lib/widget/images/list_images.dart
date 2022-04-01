import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math'; 

import 'dart:io';

class ImageList extends StatefulWidget {
  final Function() notifyParent;
  ImageList({Key? key, required this.notifyParent}) : super(key: key);

  @override
  _ImageList createState() => _ImageList();
}

class _ImageList extends State<ImageList> {
  bool isPerformingRequest = false;
  int counter = 0;

  String vLocalEscollit = "";

  @override
  void initState() {
    super.initState();
    if (constant.window == "home_screen") {
      vLocalEscollit = constant.localEscollitID;
    } else if (constant.window == "favorite_screen") {
      vLocalEscollit = constant.flocalEscollitID;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('local')
                .doc(vLocalEscollit)
                .collection('image')
                //.orderBy(_id, descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data?.docs.length == 1) {
                  return const Center(
                  child: 
                  Text(
                    'No images have been uploaded yet',
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  )
                );
                }
                counter++;
                return ListView(
                  children: getExpenseItems(snapshot),
                  scrollDirection: Axis.horizontal,
                );
              }
              return const Center(
                  child: 
                Text(
                  'Loading...',
                  style: TextStyle(fontSize: 25.0, color: Colors.grey),
                )
              );
            }));
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    // String? test = snapshot.data?.docs[1]['name'].toString();
    


    return snapshot.data?.docs
        .map<Widget>((doc) => returnContainer(doc)
        )
        .toList();
  }

  returnContainer(QueryDocumentSnapshot<Object?> doc) {

    //File image = new File('image.png');
    //File image = (File)Image.network(doc['image']);
    // File image = urlToFile(doc['image']) as File;
    // var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    // print(decodedImage.width);
    // print(decodedImage.height);

    if (doc['user_id'] != "default_id") {
      return 
      Padding(
        padding: EdgeInsets.all(10.0),
        child: 
        // Expanded(
        //   child: 
        
          Container(
            height: 300,
            width: 300,
            //padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: constant.ColorPrimary, spreadRadius: 3),
              ],
            ),
            margin: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox.fromSize(
                size: Size.fromRadius(48),
                child: Image.network(doc['image'], fit: BoxFit.cover),
              ),
            )
          ),
        // )
      );
    } else {
      return SizedBox(height: 0, width: 0,);
    }
    
  }

  // onPressed(BuildContext context, String speechTitle, String pastorCode,
  //     String audioLink) {
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               ScreenAudioSelected(speechTitle, pastorCode, audioLink)));
  // }
}
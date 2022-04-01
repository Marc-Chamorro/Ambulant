import 'dart:io';

import 'package:ambulant_project/screen/main_body/mainbody_screen.dart';
// import 'package:ambulant_project/widget/images/storage_service.dart';
// import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
//import 'package:file_picker/file_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import '../../constant/constant.dart' as constant;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageCollection extends StatefulWidget {
  final Function() notifyParent;
  ImageCollection({Key? key, required this.notifyParent}) : super(key: key);

  //widget.notifyParent();

  @override
  _ImageCollection createState() => _ImageCollection();
}

class _ImageCollection extends State<ImageCollection> {
  // var storage = firebase_storage.FirebaseStorage.instance;
  late List<AssetImage> listOfImage;
  bool clicked = false;
  List<String?> listOfStr = [];
  String? images;
  bool isLoading = false;

  String vLocalEscollit = "";

  @override
  void initState() {
    super.initState();

    if (constant.window == "home_screen") {
      vLocalEscollit = constant.localEscollitID;
    } else if (constant.window == "favorite_screen") {
      vLocalEscollit = constant.flocalEscollitID;
    }
    // getImages();
  }

  // void getImages() {
  //   listOfImage = [];
  //   for (int i = 0; i < 6; i++) {
  //     listOfImage.add(
  //         AssetImage('assets/images/travelimage' + i.toString() + '.jpeg'));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // final Storage storage = Storage();
    return Container(
      child: Column(
        children: [
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              onPressed: () async {
                // final results = await FilePicker.platform.pickFiles(
                //   allowMultiple: false,
                //   type: FileType.image,
                //   allowedExtensions: ['png', 'jpg']
                // );

                XFile? image = await ImagePicker().pickImage(
                    source: ImageSource.gallery, imageQuality: 50
                );

                if (image == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No file selected'),),);
                  return null;
                }
                // final path = results.files.single.path!;
                // final fileName = results.files.single.name;

                final path = image.path;
                final fileName = image.name;

                print(path);
                print(fileName);

                _uploadImage(path, fileName);

                // storage.uploadFile(path, fileName, constant.localEscollitID).then((value) => print('Done'));
              }, 
              child: Text('Upload'),
            ),
          ),
        ],
      ),
    );
  }

  //when downloading, check from the firestore then download one by one

  _uploadImage(String path, String fileName) async {

    var query = await FirebaseFirestore.instance.collection('local').doc(vLocalEscollit).collection('image').where('user_id', isEqualTo: constant.user_id).get();

    final cloudinary = Cloudinary(
      '862222854648514',
      '5YeTjBPnQbpT5bZZEeU6c_S1oSw',
      'chamo'
    );

    if (query.docs.isEmpty) {
      // upload image
      final response = await cloudinary.uploadFile(
        filePath: path,
        resourceType: CloudinaryResourceType.image,
        folder: 'ambulant',
      );
      print(response.secureUrl);
      String? urlsite = response.secureUrl;
      
      // save to the firestore
      FirebaseFirestore.instance
          .collection("local")
          .doc(vLocalEscollit)
          .collection("image")
          .add({
            'user_id': constant.user_id,
            'image': urlsite,
          }).catchError((error) => print("Failed to add image path: $error"));

      widget.notifyParent();

    } else {
      // get image
      for (var snapshot in query.docs) {
        var image = snapshot['image'].toString();
        var id = snapshot.id.toString();

        // delete image
        Future.delayed(const Duration(seconds: 120), () async {

          final response = await cloudinary.deleteFile(
            url: image,
            resourceType: CloudinaryResourceType.image,
            invalidate: false,
          );
          if(!response.isSuccessful){
            print('NOT WORKING BRO');
          }
        });

        // upload image
        final response = await cloudinary.uploadFile(
          filePath: path,
          resourceType: CloudinaryResourceType.image,
          folder: 'ambulant',
        );
        print(response.secureUrl);
        String? urlsite = response.secureUrl;

        // upload firestore
        FirebaseFirestore.instance
            .collection('local')
            .doc(vLocalEscollit)
            .collection('image')
            .doc(id)
            .update({'image': urlsite,});
      }
    }
    widget.notifyParent();
  }
}
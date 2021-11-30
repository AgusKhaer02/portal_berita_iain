import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permissionHandler;
import 'package:portal_berita/location/gps_tracker.dart';
// import 'package:portal_berita/location/gps_tracker.dart';

class PIckImagePage extends StatefulWidget {
  const PIckImagePage({Key? key}) : super(key: key);

  @override
  _PIckImagePageState createState() => _PIckImagePageState();
}

class _PIckImagePageState extends State<PIckImagePage> {
  final ImagePicker _picker = ImagePicker();
  String? path;
  Uint8List? imageBytes;

  pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    path = image!.path;
    imageBytes = await File(path!).readAsBytes();
    setState(() {});
  }

  capturePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    path = photo!.path;
    imageBytes = await File(path!).readAsBytes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: (){
                pickImage();
              },
              child: Text("pick image from gallery"),
            ),

            ElevatedButton(
              onPressed: (){
                capturePhoto();
              },
              child: Text("pick image from camera"),
            ),

            (imageBytes != null)
                ? Image.memory(
              imageBytes!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}

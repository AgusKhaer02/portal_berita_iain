import 'package:flutter/material.dart';
import 'package:portal_berita/pages/home_berita.dart';

void main(){
  runApp(PortalBeritaApp());
}

class PortalBeritaApp extends StatelessWidget {
  const PortalBeritaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Portal Berita",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeBerita(),
    );
  }
}

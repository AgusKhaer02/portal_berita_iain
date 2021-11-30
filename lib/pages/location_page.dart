import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permissionHandler;
import 'package:portal_berita/location/gps_tracker.dart';
// import 'package:portal_berita/location/gps_tracker.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  GPSTracker tracker = GPSTracker();
  LocationData? location;
  bool? _serviceEnabled;
  permissionHandler.PermissionStatus? _permissionGranted;
  LocationData? _locationData;
  bool? _GPSPermissionGranted;

  void getLocation(){
    _askGPSPermissions();
    tracker.getLocation().then((value) {
      location = value;
    });
  }

  // meminta permission pada saat runtime
  Future<void> _askGPSPermissions() async {
    permissionHandler.PermissionStatus permissionStatus = await _getGPSPermission();
    if (permissionStatus == permissionHandler.PermissionStatus.granted) {
      setState(() {
        _GPSPermissionGranted = true;
      });
    } else {
      setState(() {
        _GPSPermissionGranted = false;
      });
      // _handleInvalidPermissions(permissionStatus);
    }
  }

  // lanjutannya dari _askPermissions
  Future<permissionHandler.PermissionStatus> _getGPSPermission() async {
    permissionHandler.PermissionStatus permission = await permissionHandler.Permission.location.status;
    if (permission != permissionHandler.PermissionStatus.granted &&
        permission != permissionHandler.PermissionStatus.permanentlyDenied) {
      permissionHandler.PermissionStatus permissionStatus = await permissionHandler.Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text((location != null) ? "${location!.longitude!} - ${location!.latitude!}" : "Kosong, belum get location"),
            ElevatedButton(
              onPressed: (){
                getLocation();
              },
              child: Text("get location"),
            )
          ],
        ),
      ),
    );
  }
}

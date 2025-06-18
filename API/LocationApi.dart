import 'package:location/location.dart' as loc;
import 'package:flutter/services.dart';
import 'package:wheatherapp/module/LocationData.dart'; // your model

class LocationApi {
  String? error;
  static LocationApi? _instance;
  static LocationApi getInstance() => _instance ??= LocationApi();

  final loc.Location _location = loc.Location();

  Future<LocationData?> getLocation() async {
    try {
      final hasPermission = await _location.hasPermission();
      if (hasPermission == loc.PermissionStatus.denied) {
        final reqPermission = await _location.requestPermission();
        if (reqPermission != loc.PermissionStatus.granted) {
          error = 'Location permission not granted';
          return null;
        }
      }

      final loc.LocationData locationData = await _location.getLocation();
      error = null;

      // Adapt this based on how your LocationData model is structured
      return LocationData(
        latitude: locationData.latitude ?? 0.0,
        longitude: locationData.longitude ?? 0.0,
        // Add other fields as needed
      );
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission Denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please enable location in settings';
      } else {
        error = 'Unknown platform exception: ${e.message}';
      }
    } catch (e) {
      error = 'Unexpected error: $e';
    }
    return null;
  }
}

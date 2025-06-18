import 'LocationData.dart' as loc;

class LocationData {
  final double latitude;
  final double longitude;

  LocationData({required this.latitude, required this.longitude});

  // optional factory if needed
  factory LocationData.fromRaw(loc.LocationData raw) {
    return LocationData(
      latitude: raw.latitude ?? 0.0,
      longitude: raw.longitude ?? 0.0,
    );
  }
}

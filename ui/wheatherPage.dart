import 'package:flutter/material.dart';
import 'package:wheatherapp/ui/wheatherReport.dart';
import 'package:wheatherapp/module/WheatherData.dart';
import 'package:wheatherapp/API/MyApi.dart';
import 'package:wheatherapp/API/LocationApi.dart';
import 'package:wheatherapp/module/LocationData.dart'; // Assuming this defines latitude & longitude

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WheatherData? _wheatherData; // ✅ Make nullable

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(
          child: Text(
            widget.title,
            style: const TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: _wheatherData != null
          ? wheatherReport(wheatherData: _wheatherData!) // ✅ Use non-null assertion
          : const Center(
        child: CircularProgressIndicator(
          strokeWidth: 4.0,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );
  }

  Future<void> getCurrentLocation() async {
    final locationApi = LocationApi.getInstance();
    final location = await locationApi.getLocation();

    if (location != null) {
      await loadWeather(lat: location.latitude, lon: location.longitude); // ✅ Use correct properties
    } else {
      // Optional: handle location fetch failure
      print('Failed to get location: ${locationApi.error}');
    }
  }

  Future<void> loadWeather({required double lat, required double lon}) async {
    final myApi = MyApi.getInstance();
    final data = await myApi.getWeather(lat: lat, lon: lon);
    setState(() {
      _wheatherData = data;
    });
  }
}

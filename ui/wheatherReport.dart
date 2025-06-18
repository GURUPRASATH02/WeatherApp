import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wheatherapp/module/WheatherData.dart';

class wheatherReport extends StatefulWidget {
  final WheatherData wheatherData;

  const wheatherReport({super.key, required this.wheatherData});

  @override
  State<wheatherReport> createState() => _wheatherReportState();
}

class _wheatherReportState extends State<wheatherReport> {
  @override
  Widget build(BuildContext context) {
    final wheatherData = widget.wheatherData;

    Widget dateSection = Container(
      child: Text(
        DateFormat('MMMM d, H:mm').format(DateTime.now()),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 25.0,
        ),
      ),
    );

    Widget tempSection = Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            wheatherData.temp.toStringAsFixed(0),
            style: TextStyle(fontSize: 80),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 12),
              margin: EdgeInsets.only(left: 6),
              child: Text(
                '\u2103',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Container(
            width: 80,
            height: 80,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200],
            ),
            child: ClipOval(
              child: Image.network(
                'https://openweathermap.org/img/w/${wheatherData.icon}.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );

    Widget desc = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            wheatherData.name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            wheatherData.main,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );

    return Container(
      padding: EdgeInsets.all(60.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          dateSection,
          tempSection,
          desc,
        ],
      ),
    );
  }
}

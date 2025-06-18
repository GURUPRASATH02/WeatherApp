import 'dart:convert';

class WheatherData {

  final String name;
  final double temp;
  final String main;
  final String icon;

  WheatherData(this.name,this.temp,this.main,this.icon);

  static WheatherData deserialize(String json){
    JsonDecoder decoder = JsonDecoder();
    var map = decoder.convert(json);

    String name = map['name'];
    double temp = map['main']['temp'].toDouble();
    String main = map['weather'][0]['main'];
    String icon = map['weather'][0]['icon'];

    return WheatherData(name, temp, main, icon);
  }
}
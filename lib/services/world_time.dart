import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;
  String flag;
  String url;
  String time;
  bool isDayTime;
  DateTime now;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getData() async{
    try {
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      now = DateTime.parse(data['datetime']);
      int offset = int.parse(data['utc_offset'].substring(0, 3));
      now = now.add(Duration(hours: offset));

      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print("error cought: $e");
      time = "Could not get time.";
      isDayTime = true;
    }
  }
  
  void addTime(amountInSeconds){
    now = now.add(Duration(seconds: amountInSeconds));
    time = DateFormat.jm().format(now);
  }
}
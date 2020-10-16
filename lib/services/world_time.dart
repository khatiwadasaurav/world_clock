import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the ui
  String time; //the time in that location
  String flag; //url to asset flag icon
  String url;
  String date; //this is the location url for endpoints
  bool isDay;
  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    // simulate network request for username
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'];

      //create date time object
      DateTime now = DateTime.parse(dateTime);
      String offsetValue = offset.split(":")[0];
      if (offsetValue.contains('+')) {
        now = now.add(Duration(
            hours: int.parse(offset.substring(1, 3)),
            minutes: int.parse(offset.substring(4))));
      } else {
        now = now.subtract(Duration(
            hours: int.parse(offset.substring(1, 3)),
            minutes: int.parse(offset.substring(4))));
      }
      time = DateFormat.jm().format(now);
      date = DateFormat.yMMMMEEEEd().format(now);
      isDay = now.hour > 6 && now.hour < 17 ? true : false;
    } catch (error) {
      print('error is $error');
      time = 'Could not get time data';
    }
  }
}

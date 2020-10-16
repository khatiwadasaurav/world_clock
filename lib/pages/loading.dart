import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_clock/services/world_time.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String currentTimeData = 'Loading';

  void setupWorldTime() async {
    WorldTime currentTime = WorldTime(
        flag: 'nepal.jpg', location: "Kathmandu", url: 'Asia/Kathmandu');
    await currentTime.getTime();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'flag': currentTime.flag,
      'location': currentTime.location,
      'time': currentTime.time,
      'date': currentTime.date,
      'isDay': currentTime.isDay
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 75.0,
        ),
      ),
    );
  }
}

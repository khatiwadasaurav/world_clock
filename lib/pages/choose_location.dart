import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_clock/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [];

  loadJson() async {
    try {
      String data = await rootBundle.loadString('assets/data/timezone.json');
      List arr = json.decode(data);
      arr.sort((a, b) => a['location'].compareTo(b['location']));
      arr.asMap().forEach((index, value) {
        locations.add(WorldTime(
            location: value["location"],
            flag: value["flag"],
            url: value["url"]));
      });
      return locations;
    } catch (error) {
      print(" error is $error");
      return "Error Found";
    }
  }

  void updateTime(index) async {
    WorldTime time = locations[index];
    await time.getTime();
    //navigate to home screen
    Navigator.pop(context, {
      'flag': time.flag,
      'location': time.location,
      'time': time.time,
      'date': time.date,
      'isDay': time.isDay
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a location'),
        backgroundColor: Colors.blueAccent[900],
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<Object>(
          future: loadJson(),
          builder: (context, snapshot) {
            if (locations.length > 0) {
              return ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  Widget cardData = Card(
                    child: ListTile(
                      onTap: () {
                        updateTime(index);
                      },
                      title: Text('${locations[index].location}'),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                            'assets/images/flags/${locations[index].flag}'),
                      ),
                    ),
                  );

                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: cardData);
                },
              );
            } else {
              return SpinKitFadingCube(
                color: Colors.blue,
                size: 75.0,
              );
            }
          }),
    );
  }
}

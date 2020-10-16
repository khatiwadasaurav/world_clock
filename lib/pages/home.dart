import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map routeData = {};

  @override
  Widget build(BuildContext context) {
    routeData = routeData.isNotEmpty
        ? routeData
        : ModalRoute.of(context).settings.arguments;

    //set background
    String bgImage = routeData['isDay']
        ? 'assets/images/day.jpg'
        : 'assets/images/night.jpg';
    int textColor = routeData['isDay'] ? 0xff000000 : 0xffFFFFFF;
    int notiColor = routeData['isDay'] ? 0xff40739e : 0xff14192b;
    // the actual arguments sent in route is received here
    return Scaffold(
      backgroundColor: Color(notiColor),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bgImage), fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: SafeArea(
                child: Column(
              children: <Widget>[
                FlatButton.icon(
                    onPressed: () async {
                      dynamic result =
                          await Navigator.pushNamed(context, '/location');
                      setState(() {
                        routeData = {
                          'time': result['time'],
                          'flag': result['flag'],
                          'location': result['location'],
                          'date': result['date'],
                          'isDay': result['isDay']
                        };
                      });
                    },
                    icon: Icon(
                      Icons.edit_location,
                      color: Color(textColor),
                    ),
                    label: Text(
                      'Edit Location',
                      style: TextStyle(color: Color(textColor)),
                    )),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/images/flags/${routeData['flag']}'),
                      radius: 25.0,
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      routeData['location'],
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Color(textColor)),
                    )
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  routeData['time'],
                  style: TextStyle(fontSize: 66.0, color: Color(textColor)),
                ),
                SizedBox(height: 5.0),
                Text(
                  routeData['date'],
                  style: TextStyle(fontSize: 19.0, color: Color(textColor)),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/services/Timer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  Timer timer;

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String bgImage = data["instance"].isDayTime ? "assets/day.png" : "assets/night.png";

    if(timer==null) {
      timer = Timer(secondsBetweenCommand: 60, command: () {
        setState(() {
          data['instance'].addTime(60);
        });
      });
      print(60-data["instance"].now.second);
      timer.waitStartTimer(60 - data["instance"].now.second);
    }

    return Scaffold(
      backgroundColor: Colors.indigo[400],
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
          )
        ),
        child: SafeArea(
          child:Column(
            children: [
              FlatButton.icon(
                onPressed: () async {
                  dynamic instance = await Navigator.pushNamed(context, "/location");
                  if(instance!=null)
                    setState(() {
                      data = {
                        'instance' : instance['instance']
                      };
                    });
                },
                icon: Icon(
                  Icons.location_on,
                  color: Colors.grey[200],),
                label: Text(
                    "Change Location",
                  style: TextStyle(
                    color: Colors.grey[200],
                  ),
                )),
              SizedBox(height: 60,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      data["instance"].location,
                      style: TextStyle(
                        fontSize: 32,
                        letterSpacing: 2,
                        color: Colors.white,
                      ),
                  )
                ],
              ),
              SizedBox(height: 30,),
              Text(
                data["instance"].time,
                style: TextStyle(
                  fontSize: 56,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 120,),
            ],
          )),
      ),
    );
  }
}

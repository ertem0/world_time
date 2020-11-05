import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  setWorldTime() async {
    WorldTime instance = WorldTime(location: "Lisbon", flag: "assets/Portugal", url: "Europe/Lisbon");
    await instance.getData();
    await Future.delayed(const Duration(seconds : 3));
    Navigator.pushReplacementNamed(context, "/home", arguments: {
       "instance": instance
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    setWorldTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.blue,
          size: 50,
        ),
      )
    );
  }
}

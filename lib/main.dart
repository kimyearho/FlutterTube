import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'commons/app.dart';
import 'dart:async';
import 'widgets/player/model/simple_player_model.dart';

void main() => runApp(FlutterTube());

class FlutterTube extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    return ChangeNotifierProvider(
      create: (context) => SimplePlayerControlModel.empty(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AppPage(),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/AppPage');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1.0),
      body: new Center(
        child: new Image.asset(
          'assets/images/flutter1.png',
          width: 100,
          height: 80,
        ),
      ),
    );
  }
}

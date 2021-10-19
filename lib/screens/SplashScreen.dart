import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_world/screens/MainScreen.dart';

import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferences localstorage;
  late bool newuser=false;

  void initState() {
    super.initState();

    check_if_already_login();
  }

  void check_if_already_login() async {
    localstorage = await SharedPreferences.getInstance();
    newuser = (localstorage.getBool('login') ?? true);
    print("Login-$newuser");
    if (newuser == true) {
      Timer(
          Duration(seconds: 4),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext
                  context) => MainScreen())));
    } else {
      Timer(
          Duration(seconds: 4),
              () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen())));
    }
  }

  @override
  Widget build(BuildContext context) {
    //bool lightMode = MediaQuery.of(context).platformBrightness == Brightness.light;
    return Scaffold(
      backgroundColor: Color(0x00e1f5fe).withOpacity(1.0),
      body: Container(

        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 150),
                height: 150,
                width: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/res.png'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  "Demo App",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xff6A1B9A),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100.0),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Color(0xff6A1B9A)),
                    ),
                  )


                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

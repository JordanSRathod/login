import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_world/screens/HomeScreen.dart';
import 'package:sr_world/screens/LoginScreen.dart';
import 'package:sr_world/screens/signupscreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {


  late SharedPreferences localstorage;

  void initState(){
    super.initState();
    check_if_already_login();

  }
  void check_if_already_login() async {
    localstorage = await SharedPreferences.getInstance();

  }
  //
  // Future<bool?> showBack(BuildContext context) async => showDialog<bool>(context: context,
  //     builder: (context)=>AlertDialog(
  //       title: Text("Do you Really want to exit?"),
  //       actions: [
  //         ElevatedButton(
  //           child: Text("No"),
  //           onPressed:() => Navigator.pop(context,false),
  //
  //         ),
  //         ElevatedButton(
  //             child: Text("Yes"),
  //             onPressed: ()=>Navigator.pop(context,true),
  //
  //         )
  //       ],
  //     ),
  //
  // );

  @override
  Widget build(BuildContext context)
  {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15),primary: Color(0xff6A1B9A));
    final ButtonStyle style1 =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 15),primary: Colors.white,
      side: BorderSide( color:Color(0xff6A1B9A)),onPrimary: Color(0xff6A1B9A));

    return Scaffold(
      // onWillPop: () async {
      //   print("back button press");
      //   final backpress = await showBack(context);
      //
      //   return backpress ?? false;
      // },

        body: SingleChildScrollView(
            child: Container(
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(

               //   mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text("Eat Search",
                        style: const TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Color(0xff6A1B9A)), //0xff
                      ),

                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 340,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/specials.jpg'),
                        ),
                      ),
                    ),
                    Align(

                            alignment: Alignment.centerLeft,

                            child: Container(
                                margin: EdgeInsets.only(left: 32,top: 25,bottom:10),

                                child: Text("Let's find a \nplace to eat",textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      color: Color(0xff6A1B9A),fontFamily: 'RobotoMono'),
                                ),
                            ),


                    ),

                    Container(
                        child:SizedBox(

                          height: 50,
                          width: 330,

                          child: ElevatedButton(

                            style: style,

                              onPressed: () {

                                  Navigator.push(
                                      context, MaterialPageRoute(builder: (BuildContext context) => signupscreen()));


                              },
                              child: const Text('Sign Up'),



                          ),

                        ),
                        padding: EdgeInsets.all(20)

                    ),
                    Container(
                      child:SizedBox(

                        height: 50,
                        width: 330,

                        child: ElevatedButton(

                          style: style1,
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                          },
                          child: const Text('Log in'

                          ),


                        ),

                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,

                      child: Container(
                        margin: EdgeInsets.only(left: 32,top:25),

                          child:TextButton(
                              child: Text('Continue as a guest'),
                              style: TextButton.styleFrom(
                               // padding: const EdgeInsets.only(top: 16.0),
                                primary: Color(0xff6A1B9A),
                                textStyle: const TextStyle(fontSize: 20),
                              ), onPressed: () {
                              localstorage.setBool("guestornew", true);

                              Navigator.push(
                                  context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));

                            },

                          )

                        // child: Text("Continue as a guest",textAlign: TextAlign.left,
                        //   style: const TextStyle(
                        //       fontSize: 20,
                        //       color: Color(0xff6A1B9A)),
                        //
                        // ),
                      ),

                    ),



                  ],


                ),
              ),

            ),
          ),


    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_world/screens/EditprofileScreen.dart';
import 'package:sr_world/screens/MainScreen.dart';
import 'package:sr_world/screens/signupscreen.dart';


import 'ChangePassword.dart';
import 'package:functional_widget_annotation/functional_widget_annotation.dart';

class HomeScreen extends StatefulWidget {
  /*final String temp;
  HomeScreen({this.temp});*/

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //late SharedPreferences localstorage;

  String email = "", user = "", birth = "";
  bool newuser = false, guestornew = false;
  bool remove = false;
  late SharedPreferences localstorage;

  //get localstorage => null;

  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    localstorage = await SharedPreferences.getInstance();
    print(guestornew);
    guestornew = localstorage.getBool('guestornew')!;
    print("guest-$guestornew");
    setState(() {
      if (guestornew == false) {
        // print(newuser);
        email = localstorage.getString('email')!;
        user = localstorage.getString('username')!;
        birth = localstorage.getString('birthday')!;

        //  newuser = localstorage.getBool('newuser')!;
      } else {
        // print("true-$newuser");
        email = "Guest@sr.com";
        birth = "21-05-1950";
        user = "Guest";
      }
    });
  }

  Future<bool?> showBack(BuildContext context) async => showDialog<bool>(context: context,
      builder: (context)=>AlertDialog(
        title: Text("Do you Really want to exit?"),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff6A1B9A),

            ),
            child: Text("No"),
            onPressed:() => Navigator.pop(context,false),

          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff6A1B9A),

              ),
              child: Text("Yes"),
              onPressed: ()=>Navigator.pop(context,true),

          )
        ],
      ),

  );

  @override
  Widget build(BuildContext context) {
    
    
    return WillPopScope (
      onWillPop: () async {
        print("back button press");
        final backpress = await showBack(context);

        return backpress ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Demo APP"),
          backgroundColor: Color(0xff6A1B9A),
          centerTitle: true,
        ),
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage("assets/home.jpg"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              if (guestornew == true) ...[
                Center(
                  child:
                      // Text(localstorage.toString()),
                      GuestCard(context, true),
                ),
              ] else ...[
                Center(
                  child:
                      //  Text("user"),
                      LoginCard(context, user, true),
                ),
              ]
            ],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Color(0xff6A1B9A), Colors.deepPurple]),
                  color: Color(0xff6A1B9A),
                ),
                child: Container(
                  child: Column(
                    children: [
                      if (guestornew == true) ...[
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          elevation: 10,
                          child: Image.asset(
                            "assets/profile1.png",
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Guest",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // Text(
                        //   "Guest",
                        //   style: TextStyle(
                        //     color: Colors.white,
                        //   ),
                        // )
                      ] else ...[
                        Material(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          elevation: 10,
                          child: Image.asset(
                            "assets/profile1.png",
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            user,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ),
              if (guestornew == true) ...[
                CustomList(
                    Icons.home,
                    "Home",
                    () => {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Sign In'),
                              content: Text('Please sign in to use this feature'),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Color(0xff6A1B9A)
                                  ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel')),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Color(0xff6A1B9A)
                                    ),
                                    onPressed: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                signupscreen())),
                                    child: Text('Yes')),
                                //localstorage.setBool('login', true),
                              ],
                            ),
                          )
                        }),
                CustomList(
                    Icons.person_add_sharp,
                    "Edit Profile",
                    () => {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Sign In'),
                              content: Text('Please sign in to use this feature'),
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Color(0xff6A1B9A)
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel')),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Color(0xff6A1B9A)
                                    ),
                                    onPressed: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                signupscreen())),
                                    child: Text('Yes')),
                                //localstorage.setBool('login', true),
                              ],
                            ),
                          )
                        }),
                CustomList(
                    Icons.password,
                    "Change Password",
                    () => {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Sign In'),
                              content: Text('Please sign in to use this feature'),
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Color(0xff6A1B9A)
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel')),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Color(0xff6A1B9A)
                                    ),
                                    onPressed: () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                signupscreen())),
                                    child: Text('Yes')),
                                //localstorage.setBool('login', true),
                              ],
                            ),
                          )
                        }),
              ] else ...[
                CustomList(
                    Icons.home,
                    "Home",
                    () => {
                          Navigator.pop(context),
                        }),
                CustomList(
                    Icons.person_add_sharp,
                    "Edit Profile",
                    () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditprofileScreen()))
                        }),
                CustomList(
                    Icons.password,
                    "Change Password",
                    () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword()))
                        }),
                CustomList(
                    Icons.logout,
                    "Logout",
                    () => {
                          showDialog<String>(

                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Are you sure you want to Logout?'),
                              actions: [
                                TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Color(0xff6A1B9A)
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Cancel')),
                                TextButton(
                                  style: TextButton.styleFrom(
                                      primary: Color(0xff6A1B9A)
                                  ),
                                    onPressed: () =>

                                        Navigator.pushAndRemoveUntil<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                        builder: (BuildContext context) => MainScreen(),
                                        ),
                                        (Route<dynamic> route) => false,
                                        ),

                                        // Navigator.pushReplacement(
                                        // context,
                                        // MaterialPageRoute(
                                        //     builder: (BuildContext context) =>
                                        //         MainScreen())),
                                    child: Text('Yes'),
                                ),

                                //localstorage.setBool('login', true),
                              ],
                            ),
                          ) //localstorage.clear(),
                        }),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class CustomList extends StatelessWidget {
  IconData icon;
  String text;
  VoidCallback onClick;

  CustomList(this.icon, this.text, this.onClick);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
          color: Colors.grey.shade400,
        ))),
        child: InkWell(
          splashColor: Color(0xff6A1B9A),

          onTap: onClick,
          //     ()=>{
          // Navigator.push(
          // context,
          // MaterialPageRoute(
          // builder: (context) => ChangePassword()))
          //
          // },
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget GuestCard(BuildContext context, bool guestornew) => Visibility(
      visible: guestornew,
      child: Padding(
        padding: EdgeInsets.only(left: 22,right: 22),
        child: Card(
          elevation: 30,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 320,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 2),
                  child: Text(
                    "You are login as Guest!\nDo your want to Sing Up?",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff6A1B9A)),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/Learning.png'),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff6A1B9A),
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen()));
                          },
                          child: Text('Main Page'),
                        ),
                      ),
                      Container(
                        width: 120,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xff6A1B9A),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        signupscreen()));
                          },
                          child: Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget LoginCard(BuildContext context, String user1, bool bool) => Center(
      child: Visibility(
        visible: bool,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(

              child: Card(
                margin: EdgeInsets.only(top: 50),
                elevation: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.antiAlias,
                child: SizedBox(
                  height: 50,
                  width: 300,
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome $user1",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Color(0xff6A1B9A),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKeylogin = GlobalKey<FormState>();
  late SharedPreferences localstorage;
  String email="",pass="";
  TextEditingController login_pass_Control= new TextEditingController();
  TextEditingController login_email_Control= new TextEditingController();

  bool _isHiddenpassword = true;

//  late bool newuser;

  void initState() {
    super.initState();
    initial();
  }
  void initial() async {
    localstorage = await SharedPreferences.getInstance();
    setState(() {
      if (localstorage!=Null) {
        email = localstorage.getString('email')!;
        pass = localstorage.getString('password')!;
      }
      else
        {
          email = "";
          pass = "";
        }
    });
  }



  @override
  Widget build(BuildContext context) {
    final ButtonStyle style_button_google = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15),
        primary: Colors.white,
        side: BorderSide(color: Color(0xff000000)),
        onPrimary: Color(0xff000000));
    final ButtonStyle style_button = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15), primary: Color(0xff3b5998));
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15), primary: Color(0xff6A1B9A));

    login_email_Control.text=email;
    login_pass_Control.text=pass;


    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKeylogin,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 35, left: 10),
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Back',
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Log in",
                    style:
                        const TextStyle(fontSize: 35, color: Color(0xff6A1B9A)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: SizedBox(
                  height: 50,
                  width: 330,
                  child: ElevatedButton(
                    style: style_button,
                    onPressed: () {
                      print("Facebook Login");
                    },
                    child: const Text('Continue with Facebook'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: SizedBox(
                  height: 50,
                  width: 330,
                  child: ElevatedButton(
                    style: style_button_google,
                    onPressed: () {
                      print("Google Login");
                    },
                    child: const Text('Continue with Google'),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 80,
                  width: 330,
                  child: TextFormField(
                    //controller: login_email_Control,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please Enter Email Id';
                        //print(value);
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid Email Address';
                      }
                      if (email!=value) {
                        return 'Please enter correct Email Id';
                      }

                      return null;
                    },
                    cursorColor: Color(0xff6A1B9A),
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Color(0xff6A1B9A)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6A1B9A)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6A1B9A)),
                      ),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff6A1B9A)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: SizedBox(
                  height: 80,
                  width: 330,
                  child: TextFormField(
                    //controller: login_pass_Control,
                    obscureText: _isHiddenpassword,
                    cursorColor: Color(0xff6A1B9A),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter Password";
                      }
                      if (value.trim().length < 8) {
                        return "Please enter minimum 8 characters of password";
                      }
                      if (pass != value) {
                        return "Please enter correct password";
                      }
                      return null;
                    },

                    decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: _togglepassword,
                        child: Icon(
                          _isHiddenpassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      hintStyle: TextStyle(color: Color(0xff6A1B9A)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6A1B9A)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6A1B9A)),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: Color(0xff6A1B9A),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: SizedBox(
                    height: 50,
                    width: 330,
                    child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        if (_formKeylogin.currentState!.validate()) {
                         // print("password :- $final_pass");
                          localstorage.setBool('login', false);
                          localstorage.setBool('guestornew', false);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Login SuccessFully')),
                          );

                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen())
                          );

                        }
                      },
                      child: const Text('Log In'),
                    ),
                  ),
                  padding: EdgeInsets.all(20)),
            ],
          ),
        ),
      ),
    );
  }
  void _togglepassword() {
    setState(() {
      _isHiddenpassword = !_isHiddenpassword;
    });
  }
}

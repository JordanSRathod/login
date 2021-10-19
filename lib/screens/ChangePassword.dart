import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_world/screens/HomeScreen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChnagePasswordState createState() => _ChnagePasswordState();
}

class _ChnagePasswordState extends State<ChangePassword> {

  String pass = "";
  late SharedPreferences localstorage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }
  void initial() async {
    localstorage = await SharedPreferences.getInstance();
    pass = localstorage.getString('password')!;
    print("password-$pass");
  }


  final _fomrchangepassword = GlobalKey<FormState>();
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15), primary: Color(0xff6A1B9A));

  bool _isHiddenold = true;
  bool _isHiddennew = true;
  bool _isHiddenconfirm = true;
  String value_new="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _fomrchangepassword,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, left: 10),
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Back',
                  color: Color(0xff6A1B9A),
                  splashColor: Color(0xff6A1B9A),
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Change Password",
                    style:
                        const TextStyle(fontSize: 30, color: Color(0xff6A1B9A)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 25),
                child: SizedBox(
                  height: 80,
                  width: 330,
                  child: TextFormField(
                    obscureText: _isHiddenold,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter Old Password";
                      }
                      if (value.trim().length < 8) {
                        return "Please enter minimum 8 characters of password";
                      }
                      if (pass!=value) {
                        return "Old password is wrong";
                      }
                      return null;
                    },
                    cursorColor: Color(0xff6A1B9A),
                    decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: _togglepassword,
                        child: Icon(
                          _isHiddenold
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
                      labelText: 'Old Password',
                      labelStyle: TextStyle(
                          color: Color(0xff6A1B9A),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                child: SizedBox(
                  height: 80,
                  width: 330,
                  child: TextFormField(
                    validator: (value_new_password) {
                      if (value_new_password == null || value_new_password.trim().isEmpty) {
                        return "Please enter New Password";
                      }
                      if (value_new_password.trim().length < 8) {
                        return "Please enter minimum 8 characters of password";
                      }
                      value_new=value_new_password;
                      return null;
                    },
                    obscureText: _isHiddennew,
                    cursorColor: Color(0xff6A1B9A),
                    decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: _togglepasswordnew,
                        child: Icon(
                          _isHiddennew
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
                      labelText: 'New Password',
                      labelStyle: TextStyle(
                          color: Color(0xff6A1B9A),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                child: SizedBox(
                  height: 80,
                  width: 330,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter Confirm Password";
                      }
                      if (value.trim().length < 8) {
                        return "Please enter minimum 8 characters of password";
                      }
                      if (value_new!=value) {
                        return "Confirm password must be same with password";
                      }
                      return null;
                    },
                    obscureText: _isHiddenconfirm,
                    cursorColor: Color(0xff6A1B9A),
                    decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: _togglepasswordconfirm,
                        child: Icon(
                          _isHiddenconfirm
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
                      labelText: 'Confirm Password',
                      labelStyle: TextStyle(
                          color: Color(0xff6A1B9A),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                  child: SizedBox(
                    height: 50,
                    width: 330,
                    child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        if (_fomrchangepassword.currentState!.validate()) {
                          localstorage.setString("password", value_new);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Password Change SuccessFully')),
                          );
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
                        }
                      },
                      child: const Text('Update New Password'),
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
      _isHiddenold = !_isHiddenold;
    });
  }

  void _togglepasswordnew() {
    setState(() {
      _isHiddennew = !_isHiddennew;
    });
  }

  void _togglepasswordconfirm() {
    setState(() {
      _isHiddenconfirm = !_isHiddenconfirm;
    });
  }
}

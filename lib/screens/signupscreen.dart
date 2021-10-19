import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sr_world/screens/HomeScreen.dart';
import 'package:sr_world/screens/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_world/main.dart';

class signupscreen extends StatefulWidget {


  const signupscreen({Key? key}) : super(key: key);


  @override
  _signupscreenState createState() => _signupscreenState();

}



class _signupscreenState extends State<signupscreen> {

  DateTime currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  late bool newuser;

  bool commuity = false;
  bool terms = false;
  var myController = new TextEditingController();
  bool checkterms = false;
  bool checkcommuity = false;
  TextEditingController usernameControl = new TextEditingController();
  TextEditingController emailControl = new TextEditingController();
  TextEditingController passwordControl = new TextEditingController();
  late SharedPreferences localstorage;
  late String username_store,email_store,password_store,birthday_store;
  late String guestornew;

  bool _isHiddenpasswordsign = true;


  void initState() {
    super.initState();
    var outputFormat = DateFormat('dd/MM/yyyy');
    var finalResult = outputFormat.format(currentDate);
    // myController.addListener(_printDate);
    myController.text = finalResult.toString();
      check_if_already_login();
  }
  void check_if_already_login() async {
    localstorage = await SharedPreferences.getInstance();
    // newuser = (localstorage.getBool('login') ?? true);
    // print("Login-$newuser");
    // if (newuser == false) {
    //   Navigator.pushReplacement(
    //       context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    // }
  }



  // void _submitForm()
  // {
  //   final isValid = _formKey.currentState!.validate();
  //   if (isValid) {
  //     print('Everything looks good!');
  //
  //
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style_button = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15), primary: Color(0xff3b5998));
    final ButtonStyle style_button_google = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15),
        primary: Colors.white,
        side: BorderSide(color: Color(0xff000000)),
        onPrimary: Color(0xff000000));
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 15), primary: Color(0xff6A1B9A));

    var user = usernameControl.text.toString();
    var email = emailControl.text.toString();
    var pass = passwordControl.text.toString();
    var birth = myController.text.toString();


    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, left: 10),
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
                    "Sign Up",
                    style:
                        const TextStyle(fontSize: 35, color: Color(0xff6A1B9A)),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15),
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
                margin: EdgeInsets.only(top: 10),
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
                margin: EdgeInsets.only(top: 10),
                child: SizedBox(
                  height: 80,
                  width: 330,
                  child: TextFormField(
                    controller: emailControl,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'please Enter Email Id';
                        //print(value);
                      }
                      if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return 'Please enter a valid Email Address';
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
                child: SizedBox(
                  height: 80,
                  width: 330,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.characters,
                    controller: usernameControl,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "PLease Enter Username";
                      }
                      if (value.trim().length < 4) {
                        return "Please enter minimum 4 characters for Username";
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
                      labelText: 'Username',
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
                    controller: passwordControl,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter Password";
                      }
                      if (value.trim().length < 8) {
                        return "Please enter minimum 8 characters of password";
                      }
                      return null;
                    },
                    obscureText: _isHiddenpasswordsign,
                    cursorColor: Color(0xff6A1B9A),
                    decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: _togglepasswordsign,
                        child: Icon(
                          _isHiddenpasswordsign
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
                child: GestureDetector(

                  child: SizedBox(
                    height: 80,
                    width: 330,
                    child: TextFormField(
                      readOnly: true,
                      controller: myController,
                      style: TextStyle(color: Color(0xff6A1B9A)),
                      onTap: () {
                        _selectDate(context);
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
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
                        labelText: 'Birthday',
                        labelStyle: TextStyle(
                            color: Color(0xff6A1B9A),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                margin: EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Checkbox(
                      value: commuity,
                      onChanged: (value1) {
                        setState(() {
                          commuity = value1!;
                          print("inside commuity $commuity");
                          if (commuity) {
                            checkcommuity=false;
                          }
                        });
                      },
                      checkColor: Color(0xffffffff),
                      activeColor: Color(0xff6A1B9A),
                    ),
                    Text(
                      "Email me news from the community, Opt out anytime",
                      style: TextStyle(fontSize: 12, color: Color(0xff6A1B9A)),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: checkcommuity,
                child: Container(
                  child: Text(
                    "Please accept email me news from the community",
                    style: TextStyle(fontSize: 12, color: Color(0xffff0000),
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
                margin: EdgeInsets.only(top: 12, left: 12),
                child: Row(
                  children: [
                    Checkbox(
                      value: terms,
                      onChanged: (value) {
                        setState(() {
                          terms = value!;
                          print("inside term $terms");
                          if (terms) {
                            checkterms=false;
                          }
                        });
                      },
                      checkColor: Color(0xffffffff),
                      activeColor: Color(0xff6A1B9A),
                    ),
                    Text(
                      "I agree the Terms of Service and Privacy Policy",
                      style: TextStyle(fontSize: 12, color: Color(0xff6A1B9A)),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: checkterms,
                child: Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Text(
                    "Please accept Terms of Service and Privacy Policy",
                    style: TextStyle(fontSize: 12, color: Color(0xffff0000),
                    fontWeight: FontWeight.bold
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
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (!commuity) {
                            checkcommuity = true;
                            checkterms = false;
                          } else if (!terms) {
                            checkterms = true;
                            checkcommuity = false;
                          } else {

                           // save();
                           // SharedPreferences prefs = await SharedPreferences.getInstance();
                            localstorage.setString('username', user);
                            localstorage.setString('email', email);
                            localstorage.setString('password', pass);
                            localstorage.setString('birthday', birth);
                            localstorage.setBool("guestornew", true);

                            // username_store = localstorage.getString('username')!;
                            // email_store = localstorage.getString('email')!;
                            // password_store = localstorage.getString('password')!;
                            // birthday_store = localstorage.getString('birthday')!;
                            // var login = localstorage.get("login");


                            // if (localstorage != null)
                            //   {
                            //     print("$username_store-$email_store-$password_store-$birthday_store-$login");
                            //   }
                            // else
                            //   {
                            //     print ("shared preferences is NUll");
                            //   }
                            checkcommuity = false;
                            checkterms = false;
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Signin SuccessFully')),
                            );

                            Navigator.pushReplacement(
                                context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));
                          }
                          setState(() {

                          });
                          //   _submitForm();

                        }
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                  padding: EdgeInsets.all(20)),
            ],
          ),
        ),
      ),
    );


  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickdate = await showDatePicker(
        context: context,
        firstDate: DateTime(1990),
        lastDate: DateTime.now().subtract(Duration(days: 0)),
        initialDatePickerMode: DatePickerMode.year,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: Color(0xff6A1B9A), // header background color
                onPrimary: Color(0xffffffff), // header text color
                onSurface: Color(0xff000000), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Color(0xff6A1B9A), // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: currentDate);

    if (pickdate != null && pickdate != currentDate) {
      setState(() {
        currentDate = pickdate;
        DateFormat formatDate = DateFormat('dd/MM/yyyy');
        String finalDate = formatDate.format(currentDate);
        myController.text = finalDate.toString();
        print("Selected Date :" + myController.text.toString());
      });
    }



  }

  void _togglepasswordsign() {
    setState(() {
      _isHiddenpasswordsign = !_isHiddenpasswordsign;
    });
  }

}

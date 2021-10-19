import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sr_world/screens/HomeScreen.dart';

class EditprofileScreen extends StatefulWidget {
  const EditprofileScreen({Key? key}) : super(key: key);

  @override
  _EditprofileScreenState createState() => _EditprofileScreenState();
}

class _EditprofileScreenState extends State<EditprofileScreen> {
  late SharedPreferences localstorage;
  final _editprofilescreen = GlobalKey<FormState>();
  var myController = new TextEditingController();
  DateTime currentDate = DateTime.now();
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 15), primary: Color(0xff6A1B9A));


  
  late String user="",email="",birth="";
  TextEditingController usename_control= new TextEditingController();
  TextEditingController email_control= new TextEditingController();
  TextEditingController birth_control= new TextEditingController();


  void initState() {
    super.initState();
    var outputFormat = DateFormat('dd/MM/yyyy');
    var finalResult = outputFormat.format(currentDate);
    // myController.addListener(_printDate);
    myController.text = finalResult.toString();
    initial();
  }

  void initial() async {
    localstorage = await SharedPreferences.getInstance();
    if (localstorage!=Null) {
      user = localstorage.getString("username")!;
      email = localstorage.getString("email")!;
      birth = localstorage.getString("birthday")!;
    }
    else
      {
        user="";
        email="";
        birth="";
      }
    usename_control.text=user;
    email_control.text=email;
    myController.text=birth;

  }



  @override
  Widget build(BuildContext context) {


   // birth_control.text=birth;
    var user_get = usename_control.text.toString();
    var email_get = email_control.text.toString();
    var birth_get = myController.text.toString();

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _editprofilescreen,
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
                    "Edit Profile",
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
                    controller: usename_control,
                    cursorColor: Color(0xff6A1B9A),
                    // onTap: () {
                    //   FocusScopeNode currentFocus = FocusScope.of(context);
                    //   if (!currentFocus.hasPrimaryFocus) {
                    //     currentFocus.unfocus();
                    //   }
                    // },

                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Color(0xff6A1B9A)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6A1B9A)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6A1B9A)),
                      ),
                      labelText: 'User Name',
                      labelStyle: TextStyle(
                          color: Color(0xff6A1B9A),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 80,
                  width: 330,
                  child: TextFormField(
                    controller: email_control,

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
                    decoration: InputDecoration(
                      hintStyle: TextStyle(color: Color(0xff6A1B9A)),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6A1B9A)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff6A1B9A)),
                      ),
                      labelText: 'Email id',
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
                  child: SizedBox(
                    height: 50,
                    width: 330,
                    child: ElevatedButton(
                      style: style,
                      onPressed: () {
                        if (_editprofilescreen.currentState!.validate()) {

                          print("email-$email_get");



                          localstorage.setString('username', user_get);
                          localstorage.setString('email', email_get);
                          localstorage.setString('birthday', birth_get);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Profile Update SuccessFully')),
                          );

                          Navigator.pushReplacement(context,MaterialPageRoute(builder: (BuildContext context)=>
                          HomeScreen()
                          ));

                        }
                      },
                      child: const Text('Update Profile'),
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
}

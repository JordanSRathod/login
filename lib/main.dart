import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sr_world/screens/SplashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());


}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo SR',
      theme: ThemeData(

        primarySwatch: Colors.deepOrange,
      ),
      home: SplashScreen(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: <Widget>[

            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                      text: "Hello ",
                      style: TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(
                      text: "World",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Icon(Icons.access_alarm),
            Image.asset("assets/transportation.jpg"),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Container(
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Color(0xfff)),
                      left: BorderSide(width: 1.0, color: Color(0xFFFFFFFFFF)),
                      right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                      bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                    )),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                      left: BorderSide(width: 1.0, color: Color(0xFFFFDFDFDF)),
                      right: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
                      bottom: BorderSide(width: 1.0, color: Color(0xFFFF7F7F7F)),
                    ),
                    color: Colors.deepOrange,
                  ),
                  child: const Text("send",
                      textAlign: TextAlign.center, style: TextStyle(color: Colors.black)),
                ),
              ) ,
            )

          ],


        ),

      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



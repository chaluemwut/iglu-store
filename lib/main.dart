import 'dart:async';

import 'package:flutter/material.dart';
import 'package:istore/constant.dart';
import 'package:istore/home.dart';

void main() {
  final app = App();
  runApp(app);
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final materialApp = MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(primaryColor: Constant.primaryColor),
      routes: {'/Home': (BuildContext context) => Home()},
    );
    return materialApp;
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State {
  @override
  void initState() {
    Timer(Duration(seconds: 2),
        () => Navigator.of(context).pushReplacementNamed('/Home'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Constant.primaryColor),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag, size: 200, color: Colors.white),
              Text(
                'iStore',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}

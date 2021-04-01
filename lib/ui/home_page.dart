import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer _timer;
  int _counter = 0;

  void startTimer() {
    var timeStep = Duration(milliseconds: 300);
    _timer = new Timer.periodic(timeStep, (Timer timer) {
      setState(() {
        _counter++;
      });
    });
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Timer Flutter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$_counter",
              style: TextStyle(fontSize: 55),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                startTimer();
              },
              child: Text(
                "Start",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                _timer.cancel();
              },
              child: Text(
                "Stop",
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter = 0;
                });
              },
              child: Text(
                "Reset",
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

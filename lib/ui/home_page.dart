import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_flutter/cubits/home_cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _homeCubit = HomeCubit();
    _homeCubit.onInit();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Timer Flutter")),
      body: BlocBuilder(
        cubit: _homeCubit,
        builder: (_,__){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${_homeCubit.counter}",
                  style: TextStyle(fontSize: 55),
                ),
                SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    _homeCubit.startTimer();
                  },
                  child: Text(
                    "Start",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    _homeCubit.dispose();
                  },
                  child: Text(
                    "Stop",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () {
                    _homeCubit.resetCounter();
                  },
                  child: Text(
                    "Reset",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    switch(state){
      case AppLifecycleState.inactive:{
        _homeCubit.dispose();
        _homeCubit.saveStartDate(date: DateTime.now());
        break;
      }
      case AppLifecycleState.resumed:{
        _homeCubit.onInit();
        break;
      }
    }

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

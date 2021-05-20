import 'package:flutter/material.dart';
import 'screens/ferma.dart';
import 'screens/perceptron.dart';
import 'screens/generic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RTS lab3',
      theme: ThemeData(fontFamily: 'RobotoMono'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> screens = [
    Ferma(),
    Perceptron(),
    Genetic(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        body: TabBarView(
          children: screens,
        ),
        bottomNavigationBar: Container(
          child: new TabBar(
            tabs: [
              Tab(icon: Icon(Icons.adjust)),
              Tab(icon: Icon(Icons.adjust_rounded)),
              Tab(icon: Icon(Icons.adjust_sharp)),
            ],
            unselectedLabelColor: Colors.black,
            labelColor: Colors.redAccent[400],
            indicatorColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
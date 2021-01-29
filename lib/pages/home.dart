import 'package:covid19/pages/countries.dart';
import 'package:covid19/pages/summary.dart';
import 'package:covid19/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  void initState() {
    Provider.of<SummaryProvider>(context, listen: false).getSummaryApi();
    Provider.of<SummaryProvider>(context, listen: false).getSCountriesApi();
    super.initState();
  }

  void _setIndex(int newVal) {
    setState(() {
      _currentIndex = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("COVID 19 - STAY HOME"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.teal[200],
        selectedItemColor: Colors.red[700],
        onTap: _setIndex,
        currentIndex:
            _currentIndex, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            title: Text('Details'),
          )
        ],
      ),
      body: _currentIndex == 0 ? Summary() : Countries(),
    );
  }
}

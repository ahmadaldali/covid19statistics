import 'package:covid19/pages/countries.dart';
import 'package:covid19/pages/country_statistics.dart';
import 'package:covid19/pages/summary.dart';
import 'package:covid19/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'dart:async';
import 'package:connectivity/connectivity.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    Provider.of<SummaryProvider>(context, listen: false).getSummaryApi();
    Provider.of<SummaryProvider>(context, listen: false).getCountriesApi();
    Provider.of<SummaryProvider>(context, listen: false).getAllCountriesApi();
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
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
            title: new Text('Summary'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more),
            title: Text('Countries Statistics'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_city),
            title: Text('Country Statistics'),
          ),
        ],
      ),
      /*   body: _currentIndex == 0
          ? Summary()
          : (_currentIndex == 1 ? Countries() : CountryStatistics()), */
      body: Center(child: Text('Connection Status: $_connectionStatus')),
    );
  }
}

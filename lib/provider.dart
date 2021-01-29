import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SummaryProvider extends ChangeNotifier {
  Map<String, dynamic> _summary = {
    "cases_new": 0,
    "cases_active": 0,
    "cases_critical": 0,
    "cases_recovered": 0,
    "cases_total": 0,
    "deaths_new": 0,
    "deaths_total": 0,
    "tests_total": 0,
  };

  List<dynamic> _countries;

  bool _isLoading = true;

  Map<String, dynamic> get getSummary {
    return _summary;
  }

  List<dynamic> get getCountries {
    return _countries;
  }

  bool get getLoading {
    return _isLoading;
  }

  void getSummaryApi() async {
    //print(summary["cases_new"]);
    var url = 'https://covid.zeuor.net/api/get_summary';

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _summary = jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    _isLoading = false;

    notifyListeners();
  }

  void getSCountriesApi() async {
    var url = 'https://covid.zeuor.net/api/get_all_statistics';
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      _countries = jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    notifyListeners();
  }
}

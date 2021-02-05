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
  List<String> _allCountries;
  Map<String, dynamic> _countryStatistics = {
    "cn": 0,
    "ca": 0,
    "cc": 0,
    "cr": 0,
    "ct": 0,
    "dn": 0,
    "dt": 0,
    "tt": 0,
  };

  bool _isLoading = true;
  bool _countryLoading = false;

  Map<String, dynamic> get getSummary {
    return _summary;
  }

  List<dynamic> get getCountries {
    return _countries;
  }

  List<String> get getAllCountries {
    return _allCountries;
  }

  Map<String, dynamic> get getCountryStatistics {
    return _countryStatistics;
  }

  bool get getLoading {
    return _isLoading;
  }

  bool get getCountryLoading {
    return _countryLoading;
  }

  void getSummaryApi() async {
    try {
      //print(summary["cases_new"]);
      var url = 'https://covid.zeuor.net/api/get_summary';

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        _summary = jsonResponse;
        _isLoading = false;
        notifyListeners();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  void getCountriesApi() async {
    try {
      var url = 'https://covid.zeuor.net/api/get_all_statistics';
      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        _countries = jsonResponse;

        notifyListeners();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  void getAllCountriesApi() async {
    try {
      var url = 'https://covid.zeuor.net/api/get_all_countries';
      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        _allCountries = List<String>.from(jsonResponse);
        notifyListeners();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }
  }

  void getCountryStatisticsApi(String country) async {
    try {
      _countryLoading = true;
      var url = 'https://covid.zeuor.net/api/get_statistics?key=' + country;
      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        _countryStatistics['cn'] = jsonResponse[0]['cases']['new'];
        _countryStatistics['ca'] = jsonResponse[0]['cases']['active'];
        _countryStatistics['cc'] = jsonResponse[0]['cases']['critical'];
        _countryStatistics['cr'] = jsonResponse[0]['cases']['recovered'];
        _countryStatistics['ct'] = jsonResponse[0]['cases']['total'];
        _countryStatistics['dn'] = jsonResponse[0]['deaths']['new'];
        _countryStatistics['dt'] = jsonResponse[0]['deaths']['total'];
        _countryStatistics['tt'] = jsonResponse[0]['tests']['total'];
        notifyListeners();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print(e);
    }

    _countryLoading = false;
  }
}

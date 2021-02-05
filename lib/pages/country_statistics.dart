import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid19/components/country.dart';
import 'package:covid19/constants.dart';
import 'package:covid19/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryStatistics extends StatefulWidget {
  @override
  _CountryStatisticsState createState() => _CountryStatisticsState();
}

class _CountryStatisticsState extends State<CountryStatistics> {
  String _chosenValue;
  List<String> allCountries;
  Map<String, dynamic> countryStatistics;
  bool loading = false;
  List<String> images;
  int activeIndex;

  @override
  void initState() {
    activeIndex = 0;
    images = [
      'assets/images/1.png',
      'assets/images/2.png',
      'assets/images/3.png',
    ];

    super.initState();
  }

  Widget _buildSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height * 0.25,
        initialPage: activeIndex,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 1200),
        autoPlayCurve: Curves.slowMiddle,
        onPageChanged: (index, reason) {
          setState(() {
            activeIndex = index;
          });
        },
      ),
      items: images.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.8,
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.02,
              ),
              decoration: BoxDecoration(),
              child: Image.asset(
                '$i',
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildDropDown() {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        height: 30,
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: _chosenValue,
          elevation: 16,
          items: allCountries.map<DropdownMenuItem<String>>((String value) {
            //print(value);
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.toString(),
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          hint: Text(
            "Please Choose Country",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          onChanged: (String value) {
            setState(() {
              _chosenValue = value.toString();
              if (_chosenValue.toLowerCase() != 'please choose country') {
                Provider.of<SummaryProvider>(context, listen: false)
                    .getCountryStatisticsApi(_chosenValue);
              }
            });
          },
        ),
      ),
    );
  }

  Widget _buildCountry() {
    return Country(
      ct: 'Cases Total: ' + countryStatistics['ct'].toString(),
      ca: 'Cases Active: ' + countryStatistics['ca'].toString(),
      cr: 'Cases Recovered: ' + countryStatistics['cr'].toString(),
      cn: 'Cases New: ' + countryStatistics['cn'].toString(),
      cc: 'Cases Critical: ' + countryStatistics['cc'].toString(),
      dt: 'Deaths Total: ' + countryStatistics['dt'].toString(),
      dn: 'Deaths New: ' + countryStatistics['dn'].toString(),
      tt: 'Tests Total: ' + countryStatistics['tt'].toString(),
    );
  }

  Widget _buildSpace() {
    return SizedBox(
      height: 20,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SummaryProvider>(builder: (context, sp, child) {
      allCountries = sp.getAllCountries;
      countryStatistics = sp.getCountryStatistics;
      loading = sp.getCountryLoading;

      return allCountries == null
          ? Constants.buildLoading()
          : Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  _buildSlider(),
                  _buildSpace(),
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 2,
                        color: Colors.teal[300],
                      ),
                    ),
                    child: _buildDropDown(),
                  ),
                  _buildSpace(),
                  (_chosenValue == null)
                      ? Container()
                      : loading ? Constants.buildLoading() : _buildCountry()
                ],
              ),
            );
    });
  }
}

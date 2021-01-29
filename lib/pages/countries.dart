import 'package:covid19/components/country_statistics_text.dart';
import 'package:covid19/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Countries extends StatefulWidget {
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {
  List<dynamic> _countries;

  @override
  void initState() {
    _countries =
        Provider.of<SummaryProvider>(context, listen: false).getCountries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //condition here
    return Consumer<SummaryProvider>(
      builder: (context, sp, child) {
        _countries = sp.getCountries;
        return _countries == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      strokeWidth: 4,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Loading')
                  ],
                ),
              )
            : Padding(
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 25),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.teal[200]),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListView.separated(
                    itemBuilder: (context, position) {
                      return ExpansionTile(
                        title: Text(
                          _countries[position]['country'],
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CountryStatisticsText(
                                'Cases Total: ' +
                                    (_countries[position]['cases']['total'])
                                        .toString(),
                              ),
                            ],
                          ),
                          CountryStatisticsText(
                            'Cases Active: ' +
                                (_countries[position]['cases']['active'])
                                    .toString(),
                          ),
                          CountryStatisticsText(
                            'Cases Recovered: ' +
                                (_countries[position]['cases']['recovered'])
                                    .toString(),
                          ),
                          CountryStatisticsText(
                            'Cases New: ' +
                                (_countries[position]['cases']['new'])
                                    .toString(),
                          ),
                          CountryStatisticsText(
                            'Cases Critical: ' +
                                (_countries[position]['cases']['critical'])
                                    .toString(),
                          ),
                          CountryStatisticsText(
                            'Deaths Total: ' +
                                (_countries[position]['deaths']['total'])
                                    .toString(),
                          ),
                          CountryStatisticsText(
                            'Deaths New: ' +
                                (_countries[position]['deaths']['new'])
                                    .toString(),
                          ),
                          CountryStatisticsText(
                            'Tests Total: ' +
                                (_countries[position]['tests']['total'])
                                    .toString(),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (_, __) => Divider(
                      height: 5,
                      color: Colors.teal[200],
                      thickness: 2,
                    ),
                    itemCount: _countries.length,
                  ),
                ),
              );
      },
    );
  }
}

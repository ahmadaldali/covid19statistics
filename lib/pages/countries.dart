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
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 15, top: 25),
                child: ListView.separated(
                  itemBuilder: (context, position) {
                    return ExpansionTile(
                      title: Text(_countries[position]['country']),
                      children: [
                        Center(
                          child: Text(_countries[position]['country']),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => Divider(
                    height: 5,
                    color: Colors.teal[300],
                    thickness: 2,
                  ),
                  itemCount: _countries.length,
                ),
              );
      },
    );
  }
}

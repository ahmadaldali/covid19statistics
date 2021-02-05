import 'package:covid19/components/country.dart';
import 'package:covid19/constants.dart';
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

  Widget _buildListViewBody(position) {
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
        Country(
          ct: 'Cases Total: ' +
              (_countries[position]['cases']['total']).toString(),
          ca: 'Cases Active: ' +
              (_countries[position]['cases']['active']).toString(),
          cr: 'Cases Recovered: ' +
              (_countries[position]['cases']['recovered']).toString(),
          cn: 'Cases New: ' + (_countries[position]['cases']['new']).toString(),
          cc: 'Cases Critical: ' +
              (_countries[position]['cases']['critical']).toString(),
          dt: 'Deaths Total: ' +
              (_countries[position]['deaths']['total']).toString(),
          dn: 'Deaths New: ' +
              (_countries[position]['deaths']['new']).toString(),
          tt: 'Tests Total: ' +
              (_countries[position]['tests']['total']).toString(),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 8, top: 25),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.teal[200]),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListView.separated(
          itemBuilder: (context, position) => _buildListViewBody(position),
          separatorBuilder: (_, __) => Divider(
            height: 5,
            color: Colors.teal[200],
            thickness: 2,
          ),
          itemCount: _countries.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //condition here
    return Consumer<SummaryProvider>(
      builder: (context, sp, child) {
        _countries = sp.getCountries;
        return _countries == null ? Constants.buildLoading() : _buildBody();
      },
    );
  }
}

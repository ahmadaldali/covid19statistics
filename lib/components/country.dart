import 'package:covid19/components/country_statistics_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Country extends StatelessWidget {
  String ct, ca, cr, cn, cc, dt, dn, tt;

  Country({
    this.ct,
    this.ca,
    this.cr,
    this.cn,
    this.cc,
    this.dt,
    this.dn,
    this.tt,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CountryStatisticsText(this.ct),
          CountryStatisticsText(this.ca),
          CountryStatisticsText(this.cr),
          CountryStatisticsText(this.cn),
          CountryStatisticsText(this.cc),
          CountryStatisticsText(this.dt),
          CountryStatisticsText(this.dn),
          CountryStatisticsText(this.tt),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

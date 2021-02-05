import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/clip_component.dart';
import 'package:covid19/provider.dart';
import 'package:covid19/constants.dart';

class Summary extends StatefulWidget {
  @override
  _SummaryState createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  List<String> _summary = [
    "cases_new",
    "cases_active",
    "cases_critical",
    "cases_recovered",
    "cases_total",
    "deaths_new",
    "deaths_total",
    "tests_total"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
      child: Column(
        children: [
          Image.asset(
            'assets/images/main.png',
            height: 150,
            width: 150,
          ),
          Expanded(
            child: GridView.builder(
              itemCount: _summary.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Consumer<SummaryProvider>(
                  builder: (context, sp, child) {
                    return ClipComponent(
                      text: Constants.initCap((_summary[index]).toString()),
                      nums: (sp.getSummary[_summary[index]]).toString(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

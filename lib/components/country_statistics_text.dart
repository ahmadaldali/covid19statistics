import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CountryStatisticsText extends StatelessWidget {
  String content = 'a';

  CountryStatisticsText(this.content);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.content.replaceAll('null', 'N/A'),
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Colors.teal[500],
          shadows: [Shadow(blurRadius: 0.1)]),
    );
  }
}

import 'package:flutter/material.dart';

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
  String get capitalizeFirstofEach =>
      this.split(" ").map((str) => str.capitalizeFirstofEach).join(" ");
}

class Constants {
  static String initCap(String str) {
    List<String> contents = str.split("_");
    String newStr = "";
    contents.forEach((element) {
      newStr += element.inCaps + " ";
    });

    return newStr;
  }

  static Widget buildLoading() {
    return Center(
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
    );
  }
}

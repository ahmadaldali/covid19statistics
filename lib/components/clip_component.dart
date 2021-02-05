import 'package:covid19/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ClipComponent extends StatelessWidget {
  Widget elementOfClip;
  String text;
  String nums;

  ClipComponent({
    this.elementOfClip,
    this.text,
    this.nums,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(75.0)),
      child: Container(
        //width: 150,
        //height: 200,
        color: Colors.teal[300],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                this.text,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              Provider.of<SummaryProvider>(context, listen: false).getLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.red,
                      strokeWidth: 4,
                    )
                  : Text(
                      this.nums,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

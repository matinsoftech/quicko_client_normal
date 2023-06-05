import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';

class RideOption extends StatelessWidget {
  final String image;
  final String title;

  RideOption({ this.image,  this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: AppColor.primaryColor,
          width: 13,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            image,
            width: 80,
            height: 80,
          ),
          // SizedBox(height: 10),
          // Text(
          //   title,
          //   style: TextStyle(
          //     fontSize: 18,
          //     fontWeight: FontWeight.bold,
          //     color: Color.fromARGB(211, 28, 161, 128),
          //   ),
          // ),
        ],
      ),
    );
  }
}
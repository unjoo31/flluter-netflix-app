import 'package:flutter/material.dart';
import 'package:netflix/screens/main_screens.dart';

class ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: AssetImage("assets/images/dog.jpg"),
              width: 100.0,
              height: 100.0,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "도글띠",
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, MainScreens.routeName);
      },
    );
  }
}

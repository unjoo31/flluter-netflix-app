import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ComingScreen extends StatefulWidget {
  @override
  State<ComingScreen> createState() => _ComingScreenState();
}

class _ComingScreenState extends State<ComingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(
          "공개 예정",
          style: TextStyle(fontSize: 18.0),
        ),
        actions: [
          Icon(FontAwesomeIcons.chromecast),
          SizedBox(width: 25.0),
          Icon(FontAwesomeIcons.search),
          SizedBox(width: 25.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                image: AssetImage("assets/images/dog.jpg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

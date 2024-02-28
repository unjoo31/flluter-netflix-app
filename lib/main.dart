import 'package:flutter/material.dart';
import 'package:netflix/routes.dart';
import 'package:netflix/screens/splash/splash_screen.dart';
import 'package:netflix/theme.dart';

void main() {
  runApp(const Netflix());
}

class Netflix extends StatelessWidget {
  const Netflix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: route,
    );
  }
}

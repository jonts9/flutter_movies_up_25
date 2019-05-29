import 'package:flutter/material.dart';
import 'package:flutter_movies_up_25/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.deepOrange
      ),
      home: LoginPage(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:cappp/navigation_page/home_screen.dart'; // HomeScreen을 포함한 파일을 가져옵니다.
import 'package:cappp/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      home: LoginPage(),
    );
  }
}

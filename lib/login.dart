import 'package:flutter/material.dart';

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

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: '이메일',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: '비밀번호',
            ),
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () {
            bool isLoggedIn = true;

            if (isLoggedIn) {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('로그인 실패! 아이디, 비밀번호를 확인하세요.')),
              );
            }
          },
          child: Text('로그인'),
        ),
      ],
    );
  }
}
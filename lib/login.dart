import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cappp/navigation_page/home_screen.dart'; // HomeScreen을 포함한 파일을 가져옵니다.

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(), // 빈 컨테이너로 AppBar의 제목을 비웁니다.
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      ),
      body: Center(
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String name = _nameController.text;
    final String password = _passwordController.text;

    final response = await http.post(
      Uri.parse('http://localhost:8080/gbsw/students/signIn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'stuName': name,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      bool isLoggedIn = responseJson['isLoggedIn']; // 백엔드 응답 구조에 따라 수정 필요

      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그인 실패! 아이디, 비밀번호를 확인하세요.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('서버 오류! 다시 시도하세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Image.asset(
            'assets/images/log.png', // 이미지 경로
            height: 100.0,     // 이미지 높이 조정
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: '아이디',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: '비밀번호',
            ),
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: _login,
          child: Text('로그인'),
        ),
      ],
    );
  }
}

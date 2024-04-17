import 'package:flutter/material.dart';
import 'package:cappp/main.dart';

class login extends StatelessWidget {
  const login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class login_main extends StatelessWidget {
  const login_main({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 동작 추가
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
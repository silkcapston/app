import 'package:flutter/material.dart';
import 'package:cappp/login.dart';
import 'package:cappp/navigation_page/chat.dart';
import 'package:cappp/navigation_page/like.dart';
import 'package:cappp/navigation_page/write.dart';
import 'package:cappp/navigation_page/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 모드에서 "Debug" 레이블 숨기기
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/images/log.png'),
          // 이미지 추가
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black, // 아이콘 색상 설정
              ),
              onPressed: () {
                // 검색 아이콘을 눌렀을 때의 동작을 정의합니다.
                // 예를 들어, 검색 화면으로 이동할 수 있습니다.
              },
            ),
          ],
        ),
        body: Container(
          // 네비게이션 바를 제외한 나머지 내용을 배치합니다.
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outlined),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_outlined),
              label: 'Edit',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sms_outlined),
              label: 'Messages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
            ),
          ],
          // 현재 선택된 항목의 인덱스를 지정합니다.
          currentIndex: 0,
          // 항목이 선택될 때 호출될 콜백 함수를 지정합니다.
          onTap: (int index) {
            // 네비게이션 바의 항목을 탭할 때마다 호출될 로직을 작성합니다.
          },
          // 선택된 아이템의 아이콘 색상을 설정합니다.
          selectedItemColor: Colors.blue,
          // 선택되지 않은 아이템의 아이콘 색상을 설정합니다.
          unselectedItemColor: Colors.grey,
        ),
      ),
    );
  }
}

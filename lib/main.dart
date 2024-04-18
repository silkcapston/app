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
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset('assets/images/log.png'),
          leadingWidth: 80,
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () {},
            ),
            IconButton(
              onPressed: () {}, icon: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
            ),
            ),

          ],
        ),
        body: Center(
          child: Container(
            child:ListView(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.sms_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: '',
            ),
          ],
          currentIndex: 0,
          onTap: (int index) {},
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 0, // 선택된 아이템의 텍스트 크기를 0으로 설정
          unselectedFontSize: 0, // 선택되지 않은 아이템의 텍스트 크기를 0으로 설정

        ),
      ),
    );
  }
}

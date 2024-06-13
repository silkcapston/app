import 'package:flutter/material.dart';
import 'package:cappp/navigation_page/chat.dart';
import 'package:cappp/navigation_page/like.dart';
import 'package:cappp/navigation_page/write.dart';
import 'package:cappp/navigation_page/person.dart';
import 'package:cappp/navigation_page/main.dart';
import 'package:cappp/sangs.dart';
import 'package:cappp/search.dart';
import 'package:cappp/login.dart';


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin { // SingleTickerProviderStateMixin 추가
  late TabController _nestedTabController;
  int _selectedIndex = 0; // 현재 선택된 인덱스

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _nestedTabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // 각 항목에 따라 페이지 이동
    switch (_selectedIndex) {
      case 0:
      // 중고거래 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
        break;
      case 1:
      // like 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => like()),
        );
        break;
      case 2:
      // 추가 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => plus()),
        );
        break;
      case 3:
      // 메시지 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LiveChatList(socket: _io.Socket,)),
        );
        break;
      case 4:
      // 프로필 페이지로 이동
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PersonPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Bottom Navigation Example"),
          bottom: TabBar(
            controller: _nestedTabController,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black54,
            isScrollable: true,
            tabs: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Tab(
                  child: Text(
                    "중고거래",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Tab(
                  child: Text(
                    "공동구매",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
            padding: EdgeInsets.only(top: 25.0),
          ),
        ),
        body: Center(
          child: Text('Index $_selectedIndex'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
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
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedFontSize: 0,
          unselectedFontSize: 0,
        ),
      ),
    );
  }
}

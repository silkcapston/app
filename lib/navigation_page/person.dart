import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 프로필'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_picture.png'),
            ),
            title: Text('User_1'),
            subtitle: Text('자기 소개를 입력하세요'),
            trailing: IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                // 설정 화면으로 이동
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
              ),
              itemCount: 2, // 사용자가 등록한 상품 수
              itemBuilder: (context, index) {
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('상품 $index'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

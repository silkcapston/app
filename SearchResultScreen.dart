import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  final Map<String, dynamic> result;

  SearchResultScreen({required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색 결과'),
      ),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '제목: ${result['title'] ?? '제목 없음'}',
              style: TextStyle(fontSize: 20),
            ),
            // 추가적인 상세 정보를 여기에 표시할 수 있습니다.
          ],
        ),
      ),
    );
  }
}
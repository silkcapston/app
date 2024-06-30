import 'package:flutter/material.dart';
import 'dart:convert';  // JSON 변환을 위해 추가
import 'package:http/http.dart' as http;  // HTTP 요청을 위해 추가
import 'package:cappp/SearchResultScreen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isLoading = false;

  // 검색 수행 함수
  Future<void> _performSearch(String query) async {
    final url = Uri.parse('http://localhost:8080/gbsw/shop/search?q=$query'); // 실제 API URL로 변경

    setState(() {
      _isLoading = true; // 로딩 상태 시작
    });

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // JSON 응답을 디코드
        final List<dynamic> results = json.decode(response.body);

        // 검색 결과 업데이트
        setState(() {
          _searchResults = results.map((result) => result as Map<String, dynamic>).toList();
        });
      } else {
        // 에러 처리
        print('Error: ${response.statusCode}');
        setState(() {
          _searchResults = [];
        });
      }
    } catch (e) {
      // 예외 처리
      print('Exception: $e');
      setState(() {
        _searchResults = [];
      });
    } finally {
      setState(() {
        _isLoading = false; // 로딩 상태 종료
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('검색'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: '검색어를 입력하세요',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _performSearch(_searchController.text); // 검색 수행
                  },
                ),
              ),
              onSubmitted: _performSearch, // 엔터키를 누르면 검색 수행
            ),
          ),
          _isLoading
              ? Center(child: CircularProgressIndicator()) // 로딩 인디케이터
              : Expanded(
            child: _searchResults.isEmpty
                ? Center(child: Text('검색 결과가 없습니다.'))
                : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return ListTile(
                  title: Text(result['title'] ?? '제목 없음'), // 예시로 title 필드를 사용
                  onTap: () {
                    // 검색 결과 클릭 시 상세 화면으로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultScreen(
                          result: result, // 타입 일치
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LikeScreen extends StatefulWidget {
  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  List<dynamic> _likedItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLikedItems();
  }

  Future<void> _fetchLikedItems() async {
    final url = Uri.parse('http://localhost:8080/gbsw/likes');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          _likedItems = json.decode(response.body);
          _isLoading = false;
        });
      } else {
        // Error handling
        print('Error: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      // Exception handling
      print('Exception: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('좋아요 목록'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _likedItems.isEmpty
          ? Center(child: Text('좋아요한 항목이 없습니다.'))
          : ListView.builder(
        itemCount: _likedItems.length,
        itemBuilder: (context, index) {
          final item = _likedItems[index];
          return ListTile(
            title: Text(item['title']),
            subtitle: Text(item['description']),
            onTap: () {
              // 상세 화면으로 이동할 수 있습니다.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LikeDetailScreen(item: item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LikeDetailScreen extends StatelessWidget {
  final dynamic item;

  LikeDetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['title'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(item['description']),
            // 추가적인 상세 정보가 있으면 여기에 표시할 수 있습니다.
          ],
        ),
      ),
    );
  }
}

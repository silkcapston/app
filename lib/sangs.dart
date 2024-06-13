import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상품 상세'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: Center(child: Text('이미지')),
            ),
            SizedBox(height: 16.0),

            Row(
              children: [
                Icon(Icons.favorite),
                Text('2'),
                SizedBox(width: 16.0),
                Icon(Icons.person),
                Text('2기'),
              ],
            ),
            SizedBox(height: 16.0),
            Text('상세 설명'),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 수정 로직
                  },
                  child: Text('수정하기'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(

                  ),
                  onPressed: () {

                  },
                  child: Text('삭제하기'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

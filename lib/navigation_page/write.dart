import 'package:flutter/material.dart';

class ProductRegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상품 등록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // 사진 추가 로직 구현
              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.grey[300],
                child: Icon(Icons.camera_alt),
              ),
            ),
            TextField(
              decoration: InputDecoration(labelText: '상품명'),
            ),
            TextField(
              decoration: InputDecoration(labelText: '가격'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text('공유 구매'),
                    value: 'share',
                    groupValue: 'category',
                    onChanged: (value) {},
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('중고 거래'),
                    value: 'used',
                    groupValue: 'category',
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(labelText: '공구인원'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              decoration: InputDecoration(labelText: '상품태그'),
            ),
            TextField(
              decoration: InputDecoration(labelText: '상품 설명을 입력해 주세요.'),
              maxLines: 4,
            ),
            ElevatedButton(
              onPressed: () {
                // 저장 로직 구현
              },
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}

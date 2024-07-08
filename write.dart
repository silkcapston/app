import 'dart:convert';
import 'dart:io'; // File 관련 라이브러리
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ProductRegistrationScreen extends StatefulWidget {
  @override
  _ProductRegistrationScreenState createState() => _ProductRegistrationScreenState();
}

class _ProductRegistrationScreenState extends State<ProductRegistrationScreen> {
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _tagController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _category = 'share';
  File? _imageFile; // 선택된 이미지 파일을 저장할 변수

  final String springServerUrl = 'http://your-spring-server-url.com';
  final int springServerPort = 8080;
  final String itemEndpoint = '/api/item';

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveItem() async {
    var request = http.MultipartRequest('POST', Uri.parse('$springServerUrl:$springServerPort$itemEndpoint/create'));

    // 텍스트 필드 데이터를 request에 추가
    request.fields['title'] = _titleController.text;
    request.fields['price'] = _priceController.text;
    request.fields['quantity'] = _quantityController.text;
    request.fields['category'] = _category;
    request.fields['tag'] = _tagController.text;
    request.fields['description'] = _descriptionController.text;

    // 이미지 파일이 선택되었을 경우 request에 추가
    if (_imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath('imgPath', _imageFile!.path));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('상품이 성공적으로 등록되었습니다.')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('상품 등록에 실패했습니다.')));
    }
  }

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
              onTap: _pickImage, // 사진 선택을 위한 메서드 호출
              child: Container(
                height: 100,
                width: 100,
                color: Colors.grey[300],
                child: _imageFile == null
                    ? Icon(Icons.camera_alt, color: Colors.white)
                    : Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '상품명'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: '가격'),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    title: Text('공유 구매'),
                    value: 'share',
                    groupValue: _category,
                    onChanged: (value) {
                      setState(() {
                        _category = value.toString();
                      });
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    title: Text('중고 거래'),
                    value: 'used',
                    groupValue: _category,
                    onChanged: (value) {
                      setState(() {
                        _category = value.toString();
                      });
                    },
                  ),
                ),
              ],
            ),
            TextField(
              controller: _quantityController,
              decoration: InputDecoration(labelText: '공구인원'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _tagController,
              decoration: InputDecoration(labelText: '상품태그'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: '상품 설명을 입력해 주세요.'),
              maxLines: 4,
            ),
            ElevatedButton(
              onPressed: _saveItem,
              child: Text('저장'),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailScreen extends StatefulWidget {
  final int productId; // 상품 ID를 받아올 변수

  ProductDetailScreen({required this.productId});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Product> futureProduct;

  @override
  void initState() {
    super.initState();
    futureProduct = fetchProduct(widget.productId);
  }

  Future<Product> fetchProduct(int productId) async {
    final response = await http.get(
        Uri.parse('http://your-server-url.com/api/products/$productId'));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('상품 상세'),
        automaticallyImplyLeading: false, // 기본적으로 뒤로가기 버튼을 자동으로 추가하지 않음
        leading: SizedBox.shrink(), // 뒤로가기 버튼 제거
      ),
      body: FutureBuilder<Product>(
        future: futureProduct,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
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
                      Text(' ${snapshot.data!.likesCount.toString()}'),
                      SizedBox(width: 16.0),
                      Icon(Icons.person),
                      Text(' ${snapshot.data!.viewersCount.toString()}'),
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
                          // 수정하기 로직
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProductScreen(
                                productId: widget.productId,
                                currentProduct: snapshot.data!,
                              ),
                            ),
                          );
                        },
                        child: Text('수정하기'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(),
                        onPressed: () {
                          // 삭제하기 로직
                          deleteProduct(widget.productId);
                        },
                        child: Text('삭제하기'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void deleteProduct(int productId) async {
    final response = await http.delete(
      Uri.parse('http://your-server-url.com/api/products/$productId'),
    );

    if (response.statusCode == 200) {
      // 삭제 성공 시 처리
      Navigator.pop(context); // 현재 화면 닫기
    } else {
      throw Exception('Failed to delete product');
    }
  }
}

class EditProductScreen extends StatelessWidget {
  final int productId;
  final Product currentProduct;

  EditProductScreen({required this.productId, required this.currentProduct});

  @override
  Widget build(BuildContext context) {
    // 수정 화면 UI 구현
    return Scaffold(
      appBar: AppBar(
        title: Text('상품 수정'),
        automaticallyImplyLeading: false, // 기본적으로 뒤로가기 버튼을 자동으로 추가하지 않음
        leading: SizedBox.shrink(), // 뒤로가기 버튼 제거
      ),
      body: Center(
        child: Text('상품 수정 화면'),
      ),
    );
  }
}

class Product {
  final int id;
  final String title;
  final int price;
  final String category;
  final String imgPath;
  final int likesCount;
  final int viewersCount;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.imgPath,
    required this.likesCount,
    required this.viewersCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      category: json['category'],
      imgPath: json['imgPath'],
      likesCount: json['likesCount'],
      viewersCount: json['viewersCount'],
    );
  }
}

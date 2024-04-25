import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Photo {
  final String imageUrl;
  final String description;

  Photo({required this.imageUrl, required this.description});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      imageUrl: json['imageUrl'],
      description: json['description'],
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  late TabController _nestedTabController;
  late List<Photo> photos = []; // 사진 목록을 저장할 리스트

  @override
  // void initState() {
  //   super.initState();
  //   _nestedTabController = TabController(length: 5, vsync: this);
  //   fetchPhotos(); // 이미지 가져오기 함수 호출
  // }

  // 이미지를 가져오는 함수
  // void fetchPhotos() async {
  //   final response = await http.get('YOUR_BACKEND_API_ENDPOINT');
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = json.decode(response.body);
  //     setState(() {
  //       photos = data.map((json) => Photo.fromJson(json)).toList();
  //     });
  //   } else {
  //     throw Exception('Failed to load photos');
  //   }
  // }

  @override
  void dispose() {
    _nestedTabController.dispose();
    super.dispose();
  }

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
              onPressed: () {},
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              ),
            ),
          ],
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
          child: photos.isNotEmpty
              ? ListView.builder(
            itemCount: photos.length,
            itemBuilder: (context, index) {
              final photo = photos[index];
              return ListTile(
                title: Text('Photo ${index + 1}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PhotoDetailScreen(photo: photo),
                    ),
                  );
                },
              );
            },
          )
              : CircularProgressIndicator(), // 이미지가 없는 경우 로딩 표시
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
          selectedFontSize: 0,
          unselectedFontSize: 0,
        ),
      ),
    );
  }
}

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photo Detail')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(photo.imageUrl),
          SizedBox(height: 20),
          Text(photo.description),
        ],
      ),
    );
  }
}

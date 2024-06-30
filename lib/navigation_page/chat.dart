import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class LiveChatObject {
  final String NI; // 닉네임
  final String MG; // 메시지
  final bool? PMO; // 관리자 여부

  LiveChatObject({
    required this.NI,
    required this.MG,
    this.PMO,
  });

  factory LiveChatObject.fromJson(Map<String, dynamic> json) {
    return LiveChatObject(
      NI: json['NI'],
      MG: json['MG'],
      PMO: json['PMO'],
    );
  }
}

class LiveChatList extends StatefulWidget {
  final IO.Socket socket;

  const LiveChatList({
    Key? key,
    required this.socket,
  }) : super(key: key);

  @override
  _LiveChatListState createState() => _LiveChatListState();
}

class _LiveChatListState extends State<LiveChatList> {
  late IO.Socket _socket;
  final StreamController<LiveChatObject> _streamController = StreamController<LiveChatObject>();
  final List<LiveChatObject> _messageList = [];
  final ScrollController _scrollController = ScrollController();
  late Timer _timer;

  final String springServerUrl = 'http://your-spring-server-url.com';
  final int springServerPort = 8080;
  final String chatEndpoint = '/api/chat';

  @override
  void initState() {
    super.initState();
    _socket = widget.socket;

    fetchChatMessages(); // 스프링 서버로부터 채팅 메시지 가져오기

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _socket.emit('chats');
      _socket.on('CHATS', (data) {
        Iterable list = data['CA'];
        var beforeChats = list.map((i) => LiveChatObject.fromJson(i)).toList();
        setState(() {
          _messageList.addAll(beforeChats);
        });
      });

      _socket.on('MSSG', (data) {
        final chatObject = LiveChatObject.fromJson(data);
        _streamController.sink.add(chatObject);
        setState(() {
          _messageList.add(chatObject);
        });
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _streamController.close();
    _socket.dispose();
    super.dispose();
  }

  Future<void> fetchChatMessages() async {
    final response = await http.get(Uri.parse('$springServerUrl:$springServerPort$chatEndpoint/messages'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        _messageList.addAll(data.map((chatData) => LiveChatObject.fromJson(chatData)).toList());
      });
    } else {
      throw Exception('Failed to load chat messages');
    }
  }

  Future<void> sendMessage(String sender, String message) async {
    final response = await http.post(
      Uri.parse('$springServerUrl:$springServerPort$chatEndpoint/message'),
      body: jsonEncode({
        'sender': sender,
        'message': message,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_messageList.isNotEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messageList.length,
                itemBuilder: (context, index) {
                  final chat = _messageList[index];
                  return ShoppyLiveChatText(
                    nickname: chat.NI,
                    message: chat.MG,
                    empFlag: false,
                    isPMO: chat.PMO ?? false,
                  );
                },
              ),
            ),
            TextField(
              onSubmitted: (value) {
                sendMessage('YourName', value); // 메시지 보내기
              },
              decoration: InputDecoration(
                labelText: 'Send a message',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShoppyLiveChatText extends StatelessWidget {
  final String nickname;
  final String message;
  final bool empFlag;
  final bool isPMO;

  const ShoppyLiveChatText({
    Key? key,
    required this.nickname,
    required this.message,
    required this.empFlag,
    required this.isPMO,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nickname),
      subtitle: Text(message),
      tileColor: isPMO ? Colors.grey[300] : null, // 관리자 여부에 따라 배경색 변경
    );
  }
}

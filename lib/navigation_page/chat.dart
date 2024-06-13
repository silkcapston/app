import 'dart:async';
import 'dart:convert';
import 'package:cappp/navigation_page/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as _io;

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
  final _io.Socket socket;

  const LiveChatList({
    Key? key,
    required this.socket,
  }) : super(key: key);

  @override
  _LiveChatListState createState() => _LiveChatListState();
}

class _LiveChatListState extends State<LiveChatList> {
  late _io.Socket _socket;
  final StreamController<LiveChatObject> _streamController = StreamController<LiveChatObject>();
  final List<LiveChatObject> _messageList = [];
  final ScrollController _scrollController = ScrollController();

  final String springServerUrl = 'http://your-spring-server-url.com';
  final int springServerPort = 8080;
  final String chatEndpoint = '/api/chat';

  @override
  void initState() {
    super.initState();
    _socket = widget.socket;

    fetchChatMessages(); // 스프링 서버로부터 채팅 메시지 가져오기

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _socket.emit('chats');
      _socket.on('CHATS', (data) {
        Iterable list = data['CA'];
        var beforeChats = list.map((i) => LiveChatObject.fromJson(i)).toList();
        setState(() {
          beforeChats.forEach((chatData) {
            _messageList.add(chatData);
          });
        });
      });
    });

    _socket.on('MSSG', (data) {
      _streamController.sink.add(LiveChatObject.fromJson(data));
      setState(() {
        _messageList.add(LiveChatObject.fromJson(data));
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _streamController.close();
  }

  Future<void> fetchChatMessages() async {
    final response = await http.get(Uri.parse('$springServerUrl:$springServerPort$chatEndpoint'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        data.forEach((chatData) {
          _messageList.add(LiveChatObject.fromJson(chatData));
        });
      });
    } else {
      throw Exception('Failed to load chat messages');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_messageList.isNotEmpty) {
      SchedulerBinding.instance!.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 50),
          curve: Curves.easeOut,
        );
      });
    }

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 7),
      height: 170,
      padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        controller: _scrollController,
        itemCount: _messageList.length,
        itemBuilder: (BuildContext context, int index) {
          return _messageList[index].PMO != null
              ? ShoppyLiveChatText(
              nickname: _messageList[index].NI,
              message: _messageList[index].MG,
              empFlag: false,
              isPMO: false)
              : Container();
        },
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
    );
  }
}
import 'package:flutter/material.dart';

class LiveChatList extends StatefulWidget {
  const LiveChatList({Key? key}) : super(key: key);

  @override
  _LiveChatListState createState() => _LiveChatListState();
}

class _LiveChatListState extends State<LiveChatList> {
  List<String> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(String message) {
    setState(() {
      _messages.add(message);
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter message',
                    ),
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

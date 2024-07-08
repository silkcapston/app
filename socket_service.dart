import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;

  IO.Socket get socket => _socket;

  SocketService() {
    _initializeSocket();
  }

  void _initializeSocket() {
    _socket = IO.io('ws://localhost:8080/ws/chat', <String, dynamic>{
      'transports': ['websocket'],
    });

    _socket.onConnect((_) {
      print('Connected to WebSocket');
    });

    _socket.onConnectError((data) {
      print('Connect Error: $data');
    });

    _socket.onDisconnect((_) {
      print('Disconnected from WebSocket');
    });
  }

  void dispose() {
    _socket.dispose();
  }
}

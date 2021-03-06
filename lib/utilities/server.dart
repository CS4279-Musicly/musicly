import 'dart:async';
import 'dart:io';

import 'dart:typed_data';

import 'models.dart';

class Server {

  Server({required this.onError, required this.onData});

  Uint8ListCallback onData;
  DynamicCallback onError;
  ServerSocket? server;
  bool running = false;
  List<Socket> sockets = [];

  start() async {
    runZoned(() async {
      server = await ServerSocket.bind('localhost', 4040);
      this.running = true;
      server!.listen(onRequest);
      this.onData(Uint8List.fromList('Server started on port 4040'.codeUnits));
    }, onError: (e) {
      this.onError(e);
    });
  }

  stop() async {
    await this.server!.close();
    this.server = null;
    this.running = false;
  }

  broadCast(String message) {
    this.onData(Uint8List.fromList('Broadcasting : $message'.codeUnits));
    for (Socket socket in sockets) {
      socket.write( message + '\n' );
    }
  }


  onRequest(Socket socket) {
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }
    socket.listen((Uint8List data) {
      this.onData(data);
    });
  }
}
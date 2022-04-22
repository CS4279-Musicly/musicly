import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicly/views/pdf_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:musicly/utilities/styles.dart';

class ClientPage extends StatefulWidget {
  final String title = "Test";
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {

  String _fileName = "";
  int _numFiles = 0;
  late SharedPreferences prefs;

  @override
  void initState() {
    _setup();
    super.initState();
  }

  /// Asynchronously access the phone preferences on view load to grab data.
  _setup() async {
    prefs = await SharedPreferences.getInstance();
    _numFiles = prefs.getInt("numMusicFiles")!;
  }



  final _channel = WebSocketChannel.connect(
    Uri.parse('wss://demo.piesocket.com/v3/channel_1?api_key=oCdCMcMPQpbvNjUIzqtvF1d2X2okWpDQj4AwARJuAgtjhzKxVEjQU6IdCjwm&notify_self'),
  );

  openPDF() async {
    for (int i = 0; i < _numFiles; i++) {
      if (_fileName == prefs.getStringList(i.toString())![0]) {
        // showCupertinoModalBottomSheet(
        //     context: context,
        //     expand: true,
        //     duration: const Duration(milliseconds: 300),
        //     builder: (_) => PDFScreen(path: prefs.getStringList((i).toString())?[1] ?? "")
        // );
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (context) =>
                PDFScreen(path: prefs.getStringList((i).toString())?[1] ?? ""),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: <Widget>[
              const CupertinoSliverNavigationBar(
                largeTitle: Text(
                    'Music Reception',
                style: TextStyle(color: VanderbiltStyles.gold)
                )
              ),
              const SliverPadding(
                    padding: EdgeInsets.all(20.0),
              ),
              SliverFillRemaining(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder(
                          stream: _channel.stream,
                          builder: (context, snapshot) {
                            _fileName = snapshot.data.toString();
                            openPDF();
                            return Text("   Waiting for director...");
                          },
                        )
                      ],
                    ),
                  ),
            ]
        )
      );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

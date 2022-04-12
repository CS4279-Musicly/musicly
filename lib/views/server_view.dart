import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:musicly/utilities/styles.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ServerPage extends StatefulWidget {
  @override
  _ServerPageState createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  String _songName = "Song Name";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text(
            'Change tune',
            style: TextStyle(color: VanderbiltStyles.gold),
          ),
          previousPageTitle: "Home",
        ),
        SliverFillRemaining(
            child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 35.0, bottom: 0),
              child: SizedBox(
                width: 350,
                child: CupertinoTextField(
                  //controller: ,TODO: Text controllers for text field values
                  placeholder: _songName,
                  placeholderStyle: VanderbiltStyles.textRowPlaceholder,
                  style: VanderbiltStyles.textRowPlaceholder,
                  autocorrect: false,
                  textAlign: TextAlign.center,
                  padding: const EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onChanged: (text) {
                    _songName = text;
                  },
                  onSubmitted: (text) {
                    _songName = text;
                  },
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(
                left: 30.0, right: 30.0, top: 25.0, bottom: 0),
            child: CupertinoButton(
              child: const Text(
                'Submit',
                style: VanderbiltStyles.textButton,
              ),
              onPressed: () async {
                submitSong(_songName);
              },
              borderRadius: BorderRadius.circular(25.0),
              color: VanderbiltStyles.gold,
              pressedOpacity: 0.75,
            ),
          ),
        ]))
      ],
    ));
  }

  Future<http.Response> submitSong(String title) {
    return http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'User-type': 'Conductor',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:musicly/utilities/styles.dart';
import 'dart:io';
import 'package:musicly/utilities/firebase_files.dart';

class DownloadMusicView extends StatefulWidget {
  DownloadMusicView({Key? key}) : super(key: key);

  /// Creates the dynamic state for the Add Music class.
  @override
  _DownloadMusicViewState createState() => _DownloadMusicViewState();
}

/// Creates and manages the Account screen.
class _DownloadMusicViewState extends State<DownloadMusicView> {

  String _songName = "File Name";

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            // Navigation bar at the top of the screen that contains the view title and navigation buttons.
            const CupertinoSliverNavigationBar(
              largeTitle: Text(
                'Download Music',
                style: TextStyle(color: VanderbiltStyles.gold),
              ),
              previousPageTitle: "Home",
            ),
            SliverFillRemaining(
                child: Column(
                    children: [
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
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 25.0, bottom: 0),
                        child: CupertinoButton(
                          child: const Text(
                            'Download',
                            style: VanderbiltStyles.textButton,
                          ),
                          onPressed: () async {
                            FirebaseFiles().downloadFile(context, _songName);
                            //Navigator.pop(context);
                          },
                          borderRadius: BorderRadius.circular(25.0),
                          color: VanderbiltStyles.gold,
                          pressedOpacity: 0.75,
                        ),
                      )
                    ]
                )
            )
          ],
        )
    );
  }
}
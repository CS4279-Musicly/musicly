import 'package:flutter/cupertino.dart';
import 'package:musicly/utilities/styles.dart';
import 'dart:io';
import 'package:musicly/utilities/firebase_files.dart';

class DownloadDrillView extends StatefulWidget {
  DownloadDrillView({Key? key}) : super(key: key);

  /// Creates the dynamic state for the Add Music class.
  @override
  _DownloadDrillViewState createState() => _DownloadDrillViewState();
}

/// Creates and manages the Account screen.
class _DownloadDrillViewState extends State<DownloadDrillView> {

  String _songName = "File Name";

  _getFile(BuildContext context) async {
    await FirebaseFiles().downloadDrillFile(context, _songName);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            // Navigation bar at the top of the screen that contains the view title and navigation buttons.
            const CupertinoSliverNavigationBar(
              largeTitle: Text(
                'Download Drill',
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
                                _getFile(context);
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
                            _getFile(context);
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
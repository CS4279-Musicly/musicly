import 'package:flutter/cupertino.dart';
import 'package:musicly/utilities/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:musicly/views/pdf_view.dart';

/// Manages dynamic state for the Music File class.
class MusicFileView extends StatefulWidget {
  MusicFileView({Key? key, this.id = -1}) : super(key: key);
  final int id;

  /// Creates the dynamic state for the Music File class.
  @override
  _MusicFileViewState createState() => _MusicFileViewState(id);
}

/// Creates and manages the Music File screen.
class _MusicFileViewState extends State<MusicFileView> {
  _MusicFileViewState(this.id);
  final int id;
  int? children = 0;
  late SharedPreferences prefs;

  /// Called on view load to initialize the view.
  @override
  void initState() {
    super.initState();
    _getDir();
    //_refreshData();
  }

  _refreshData() {
    setState(() {
      children = prefs.getInt("numMusicFiles") ?? 0;
    });
  }

  _getDir() async {
    prefs = await SharedPreferences.getInstance();
    children = prefs.getInt("numMusicFiles") ?? 0;
  }

  /// Builds the UI using widgets.
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CupertinoScrollbar(
            child: CustomScrollView(
              slivers: [
                // Navigation bar at the top of the screen that contains the view title and navigation buttons.
                CupertinoSliverNavigationBar(
                  largeTitle: const Text(
                      'Music',
                      style: TextStyle(color: VanderbiltStyles.gold)
                  ),
                  //previousPageTitle: 'Instruments',
                  trailing: CupertinoButton(
                      child: const Icon(CupertinoIcons.refresh),
                      padding: const EdgeInsets.all(10),
                      // Navigates to Account View when pressed.
                      onPressed: () {
                        _refreshData();
                      }),
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(top: 5.0),
                ),
                // Create the folder grid.
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 30.0,
                    childAspectRatio: 9 / 10,
                  ),
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                      if (id == -2) {
                        return null;
                      } else {
                        // Create the objects in the grid.
                        return Stack(
                          children: [
                            Container(
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('assets/images/file_white.png'),
                                      fit: BoxFit.none,
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 150.0),
                                  child: Text(prefs.getStringList((index).toString())?[0] ?? ""),
                                )
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) =>
                                        PDFScreen(path: prefs.getStringList((index).toString())?[1] ?? ""),
                                  ),
                                );
                              }
                            )
                          ],
                        );
                      }
                    },
                    childCount: children,
                  ),
                ),
              ],
            )
        )
    );
  }
}
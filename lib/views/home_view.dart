import 'package:flutter/cupertino.dart';
import 'package:musicly/utilities/styles.dart';
import 'add_music_view.dart';

/// Creates and manages the Home screen.
class HomeView extends StatefulWidget {
  const HomeView({Key? key, this.conductor = false}) : super(key: key);
  final bool conductor;

  /// Creates the dynamic state for the Home class.
  @override
  _HomeViewState createState() => _HomeViewState(conductor);
}

/// Creates and manages the Home screen.
class _HomeViewState extends State<HomeView> {
  _HomeViewState(this.conductor);
  final bool conductor;

  @override
  initState() {
    super.initState();
  }

  CupertinoSliverNavigationBar _buildBar(BuildContext context) {
    if (conductor) {
      return const CupertinoSliverNavigationBar(
        automaticallyImplyLeading: false,
        largeTitle: Text(
          'Home: Conductor',
          style: TextStyle(color: VanderbiltStyles.gold),
        ),
      );
    } else {
      return const CupertinoSliverNavigationBar(
        automaticallyImplyLeading: false,
        largeTitle: Text(
          'Home: Student',
          style: TextStyle(color: VanderbiltStyles.gold),
        ),
      );
    }
  }

  Column _buildColumn(BuildContext context) {
    if (conductor) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 0, right: 0, top: 35.0, bottom: 0),
            child: SizedBox(
              width: 370,
              child: CupertinoButton(
                child: const Text(
                  'Add New Sheet Music',
                  style: VanderbiltStyles.textButton,
                ),
                onPressed: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => AddMusicView()));
                },
                borderRadius: BorderRadius.circular(25.0),
                color: VanderbiltStyles.gold,
                pressedOpacity: 0.75,
              ),
            ),
          ),
        ]
      );
    } else {
      return Column(
        children: [

        ],
      );
    }
  }

  /// Builds the UI using widgets.
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: <Widget>[
            // Navigation bar at the top of the screen that contains the view title and navigation buttons.
            _buildBar(context),
            SliverFillRemaining(
              child: _buildColumn(context)
            )
          ],
        )
    );
  }
}

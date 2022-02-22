import 'package:flutter/cupertino.dart';
import 'package:musicly/utilities/styles.dart';

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

  /// Builds the UI using widgets.
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            // Navigation bar at the top of the screen that contains the view title and navigation buttons.
            _buildBar(context),
          ],
        )
    );
  }
}

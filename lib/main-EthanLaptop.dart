import 'package:flutter/cupertino.dart';
import 'views/login_view.dart';

/// Called initially to start the app.
void main() => runApp(Musicly());

/// Base class of the app.
class Musicly extends StatelessWidget {
  const Musicly({Key? key}) : super(key: key);

  /// Builds the UI using widgets.
  @override
  Widget build(BuildContext context) {
    // Cupertino App is the iOS-style app flutter offers and acts as the root of the app
    return const CupertinoApp(
      title: 'Musicly',
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      home: LoginView(),
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'views/login_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

/// Called initially to start the app.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Musicly());
}

/// Base class of the app.
class Musicly extends StatelessWidget {
  const Musicly({Key? key}) : super(key: key);

  /// Builds the UI using widgets.
  @override
  Widget build(BuildContext context) {
    // Cupertino App is the iOS-style app flutter offers and acts as the root of the app
    return const CupertinoApp(
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      title: 'Musicly',
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      home: LoginView(),
    );
  }
}
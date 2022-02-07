import 'package:flutter/cupertino.dart';
import 'package:musicly/utilities/styles.dart';

/// Manages dynamic state for the Login class.
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  /// Creates the dynamic state for the Login class.
  @override
  State<LoginView> createState() => _LoginViewState();
}

/// Creates and manages the Login screen.
class _LoginViewState extends State<LoginView> {

  /// Builds the UI using widgets.
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                    child: Text(
                      'Musicly',
                      style: TextStyle(color: CupertinoColors.white, fontSize: 40, fontWeight: FontWeight.bold),
                    )
                )
            ),
            // Create the Star V image.
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: SizedBox(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/images/starV_873.png')),
              ),
            ),
            // Create the password text box.
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 55.0, bottom: 0),
              child: CupertinoTextField(
                placeholder: 'Password',
                obscureText: true,
                textAlign: TextAlign.center,
                placeholderStyle: VanderbiltStyles.textRowPlaceholder,
                style: VanderbiltStyles.textRowPlaceholder,
                padding: const EdgeInsets.only(
                    left: 0.0, right: 0.0, top: 15.0, bottom: 15.0),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                onChanged: (text) {
                },
                onSubmitted: (text) {
                },
              ),
            ),
            // Create the login button.
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 25.0, bottom: 0),
              child: CupertinoButton(
                child: const Text(
                  'Login',
                  style: VanderbiltStyles.textButton,
                ),
                onPressed: () {
                },
                borderRadius: BorderRadius.circular(25.0),
                color: VanderbiltStyles.gold,
                pressedOpacity: 0.75,
              ),
            )
          ]
      ),
    );
  }
}

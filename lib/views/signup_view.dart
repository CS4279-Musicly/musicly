import 'package:flutter/cupertino.dart';
import 'package:musicly/utilities/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  /// Creates the dynamic state for the Login class.
  @override
  State<SignupView> createState() => _SignupView();
}

/// Creates and manages the Login screen.
class _SignupView extends State<SignupView> {

  String _password = "";
  String _email = "";
  bool success = true;

  FirebaseAuth auth = FirebaseAuth.instance;

  _signUp() async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showDialog(context, "The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        _showDialog(context, "The account already exists for that email.");
      }
      success = false;
    } catch (e) {
      _showDialog(context, e.toString());
      success = false;
    }

    if (success) {
      Navigator.of(context).maybePop();
    }
  }

  /// Shows a pop up error box when the incorrect password is entered.
  _showDialog(BuildContext context, String error) {
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Text(error),
      actions: [
        CupertinoDialogAction(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
    return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  /// Builds the UI using widgets.
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListView(
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
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 55.0, bottom: 0),
              child: CupertinoTextField(
                placeholder: 'Email',
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
                  _email = text;
                },
              ),
            ),
            // Create the password text box.
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 25.0, bottom: 0),
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
                  _password = text;
                },
              ),
            ),
            // Create the login or signup button.
            Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 25.0, bottom: 0),
              child: CupertinoButton(
                child: const Text(
                  'Sign Up',
                  style: VanderbiltStyles.textButton,
                ),
                onPressed: () {
                  _signUp();
                },
                borderRadius: BorderRadius.circular(25.0),
                color: VanderbiltStyles.gold,
                pressedOpacity: 0.75,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 75.0, right: 75.0, top: 25.0, bottom: 0),
              child: CupertinoButton(
                child: const Text(
                  'Cancel',
                  style: VanderbiltStyles.textButton,
                ),
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                borderRadius: BorderRadius.circular(25.0),
                color: VanderbiltStyles.darkerGold,
                pressedOpacity: 0.75,
              ),
            )
          ]
      ),
    );
  }
}
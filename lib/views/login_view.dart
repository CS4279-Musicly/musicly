import 'package:flutter/cupertino.dart';
import 'package:musicly/utilities/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:musicly/views/account_view.dart';
import 'tab_view.dart';
import 'signup_view.dart';

/// Manages dynamic state for the Login class.
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  /// Creates the dynamic state for the Login class.
  @override
  State<LoginView> createState() => _LoginViewState();
}

/// Creates and manages the Login screen.
class _LoginViewState extends State<LoginView> {

  String _password = "";
  String _email = "";
  bool _firstLaunch = false; // First time launching the app?
  bool _conductor = false;

  FirebaseAuth auth = FirebaseAuth.instance;

  /// Called on view load to initialize the view.
  @override
  void initState() {
    super.initState();
    _setup();
  }

  /// Asynchronously access the phone preferences on view load to grab data.
  _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _firstLaunch = prefs.getBool('firstLaunch') ?? true;
    if (_firstLaunch) {
      prefs.setBool('firstLaunch', false);
    }
  }

  /// Validate password when submitted to determine which view to load.
  _validatePassword() async {
    bool _validated = true;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: _email,
          password: _password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showDialog(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        _showDialog(context, "Wrong password provided for that user.");
      }
      _validated = false;
    }

    if (_email == "ethan.h.mayer@vanderbilt.edu") {
      _conductor = true;
    }

    if (_validated) {
      Navigator.push(
          context,
          CupertinoPageRoute(builder: (_) => TabView(conductor: _conductor)
          ));
    }
  }

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
    } catch (e) {
      _showDialog(context, e.toString());
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

  _pickUniversityColors() async{
    bool col = true;
  }

  Widget _buildButton() {
    if (_firstLaunch) {
      // Build the button as sign in if first launch
      return Padding(
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
      );
    } else {
      // Build the button as login if not first launch
      return Padding(
        padding: const EdgeInsets.only(
            left: 30.0, right: 30.0, top: 25.0, bottom: 0),
        child: CupertinoButton(
          child: const Text(
            'Login',
            style: VanderbiltStyles.textButton,
          ),
          onPressed: () {
            _validatePassword();
          },
          borderRadius: BorderRadius.circular(25.0),
          color: VanderbiltStyles.gold,
          pressedOpacity: 0.75,
        ),
      );
    }
  }

  Widget _buildSignUp() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 75.0, right: 75.0, top: 25.0, bottom: 0),
      child: CupertinoButton(
        child: const Text(
          'Sign Up',
          style: VanderbiltStyles.textButton,
        ),
        onPressed: () {
          showCupertinoModalBottomSheet(
              context: context,
              expand: true,
              duration: const Duration(milliseconds: 300),
              builder: (_) => SignupView());
        },
        borderRadius: BorderRadius.circular(25.0),
        color: VanderbiltStyles.darkerGold,
        pressedOpacity: 0.75,
      ),
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
                onSubmitted: (text) {
                  _validatePassword();
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
                onSubmitted: (text) {
                  _validatePassword();
                },
              ),
            ),
            // Create the login or signup button.
            _buildButton(),
            _buildSignUp()
          ]
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tab_view.dart';
import 'package:musicly/utilities/styles.dart';

/// Manages dynamic state for the Account class.
class AccountView extends StatefulWidget {
  const AccountView({Key? key, this.first = false, this.conductor = false}) : super(key: key);
  final bool first;
  final bool conductor;

  /// Creates the dynamic state for the Account class.
  @override
  _AccountViewState createState() => _AccountViewState(first, conductor);
}

/// Creates and manages the Account screen.
class _AccountViewState extends State<AccountView> {
  // Handles first launch of the app
  _AccountViewState(this._first, this._conductor);
  final bool _first;
  final bool _conductor;

  // Variables to keep a local copy of data.
  String _name = "Name";
  String _university = "University";
  String _instrument = "Instrument";

  // Text controllers for input fields
  TextEditingController _nameController = TextEditingController(
    text: "",
  );

  // List of universities that can participate in the marching band.
  final List<Text> _universityList = const [
    Text('Vanderbilt', style: VanderbiltStyles.textRow),
    Text('Northwestern', style: NorthwesternStyles.textRow),
  ];

  // List of instruments in the marching band.
  final List<Text> _instrumentList = const [
    Text('Piccolo (Flute)', style: VanderbiltStyles.textRow),
    Text('Clarinet', style: VanderbiltStyles.textRow),
    Text('Alto Sax', style: VanderbiltStyles.textRow),
    Text('Tenor Sax', style: VanderbiltStyles.textRow),
    Text('Bari Sax', style: VanderbiltStyles.textRow),
    Text('Trumpet', style: VanderbiltStyles.textRow),
    Text('Mellophone', style: VanderbiltStyles.textRow),
    Text('Trombone', style: VanderbiltStyles.textRow),
    Text('Euphonium/Baritone (BC)', style: VanderbiltStyles.textRow),
    Text('Euphonium/Baritone (TC)', style: VanderbiltStyles.textRow),
    Text('Sousaphone', style: VanderbiltStyles.textRow),
    Text('Snare Drum', style: VanderbiltStyles.textRow),
    Text('Bass Drum', style: VanderbiltStyles.textRow),
    Text('Tenor Drums', style: VanderbiltStyles.textRow),
    Text('Cymbal', style: VanderbiltStyles.textRow),
    Text('Color Guard', style: VanderbiltStyles.textRow),
  ];

  /// Called on view load to initialize the screen view.
  @override
  void initState() {
    super.initState();
    _setup();
  }

  /// Called upon view close to destroy previously allocated resources
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  /// Asynchronously access the phone preferences on view load to grab data.
  _setup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? "";
      _nameController = TextEditingController(
        text: _name,
      );
      _university = prefs.getString('university') ?? "University";
      _instrument = prefs.getString('instrument') ?? "Instrument";
    });
  }

  /// Asynchronously stores the name in the phone preferences.
  _updateName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', _name);
  }

  /// Asynchronously stores the university in the phone preferences.
  _updateUniversity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('university', _university);
  }

  /// Asynchronously stores the instrument in the phone preferences.
  _updateInstrument() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('instrument', _instrument);
  }

  /// Shows a scroll wheel-style picker in a bottom popup for universities.
  _showUniversityPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
              height: 200,
              child: CupertinoPicker(
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                onSelectedItemChanged: (value) {
                  // Called to refresh the UI to change the university text value.
                  setState(() {
                    _university = _universityList[value].data!;
                    _updateUniversity();
                  });
                },
                itemExtent: 32.0,
                children: _universityList,
              )
          );
        });
  }

  /// Shows a scroll wheel-style picker in a bottom popup for instruments
  _showInstrumentPicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 200,
            child: CupertinoPicker(
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              onSelectedItemChanged: (value) {
                // Called to refresh the UI to change the instrument text value.
                setState(() {
                  _instrument = _instrumentList[value].data!;
                  _updateInstrument();
                });
              },
              itemExtent: 32.0,
              children: _instrumentList,
            )
          );
        });
  }

  List<Widget> _buildCommon(BuildContext context) {
    if(_university != 'Vanderbilt'){
      if (_conductor) {
        return <Widget>[
          // Create the Star V image login page.
          Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: Center(
              child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/images/starV_873.png')),
            ),
          ),
          // Create the name text field.
          Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 50.0, bottom: 0),
              child: SizedBox(
                width: 350,
                child: CupertinoTextField(
                  controller: _nameController,
                  placeholder: "Name",
                  placeholderStyle: VanderbiltStyles.textRowPlaceholder,
                  style: VanderbiltStyles.textRowPlaceholder,
                  textAlign: TextAlign.center,
                  padding: const EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onSubmitted: (text) {
                    _name = text;
                    _updateName();
                  },
                ),
              )
          ),
        ];
      } else {
        return <Widget>[
          // Create the Star V image login page.
          Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: Center(
              child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/images/northwestern_logo.png')),
            ),
          ),
          // Create the name text field.
          Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 50.0, bottom: 0),
              child: SizedBox(
                width: 350,
                child: CupertinoTextField(
                  controller: _nameController,
                  placeholder: "Name",
                  placeholderStyle: VanderbiltStyles.textRowPlaceholder,
                  style: VanderbiltStyles.textRowPlaceholder,
                  textAlign: TextAlign.center,
                  padding: const EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onSubmitted: (text) {
                    _name = text;
                    _updateName();
                  },
                ),
              )
          ),
          // Create the university text field/picker.
          Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 25.0, bottom: 0),
              child: SizedBox(
                width: 350,
                child: CupertinoButton(
                  child: Text(
                    _university,
                    style: VanderbiltStyles.textRowPlaceholder,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                  color: CupertinoColors.white,
                  onPressed: () {
                    _showUniversityPicker();
                  },
                ),
              )
          ),
          // Create the instrument text field/picker.
          Padding(
              padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 25.0,
                  bottom: 0
              ),
              child: SizedBox(
                width: 350,
                child: CupertinoButton(
                  child: Text(
                    _instrument,
                    style: VanderbiltStyles.textRowPlaceholder,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                  color: CupertinoColors.white,
                  onPressed: () {
                    _showInstrumentPicker();
                  },
                ),
              )
          ),
        ];
      }
    } else {
      if (_conductor) {
        return <Widget>[
          // Create the Star V image login page.
          Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: Center(
              child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/images/starV_873.png')),
            ),
          ),
          // Create the name text field.
          Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 50.0, bottom: 0),
              child: SizedBox(
                width: 350,
                child: CupertinoTextField(
                  controller: _nameController,
                  placeholder: "Name",
                  placeholderStyle: VanderbiltStyles.textRowPlaceholder,
                  style: VanderbiltStyles.textRowPlaceholder,
                  textAlign: TextAlign.center,
                  padding: const EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onSubmitted: (text) {
                    _name = text;
                    _updateName();
                  },
                ),
              )
          ),
        ];
      } else {
        return <Widget>[
          // Create the Star V image login page.
          Padding(
            padding: const EdgeInsets.only(top: 90.0),
            child: Center(
              child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('assets/images/starV_873.png')),
            ),
          ),
          // Create the name text field.
          Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 50.0, bottom: 0),
              child: SizedBox(
                width: 350,
                child: CupertinoTextField(
                  controller: _nameController,
                  placeholder: "Name",
                  placeholderStyle: NorthwesternStyles.textRowPlaceholder,
                  style: NorthwesternStyles.textRowPlaceholder,
                  textAlign: TextAlign.center,
                  padding: const EdgeInsets.only(
                      left: 0.0, right: 0.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  onSubmitted: (text) {
                    _name = text;
                    _updateName();
                  },
                ),
              )
          ),
          // Create the university text field/picker.
          Padding(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 25.0, bottom: 0),
              child: SizedBox(
                width: 350,
                child: CupertinoButton(
                  child: Text(
                    _university,
                    style: NorthwesternStyles.textRowPlaceholder,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                  color: CupertinoColors.white,
                  onPressed: () {
                    _showUniversityPicker();
                  },
                ),
              )
          ),
          // Create the instrument text field/picker.
          Padding(
              padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30.0,
                  top: 25.0,
                  bottom: 0
              ),
              child: SizedBox(
                width: 350,
                child: CupertinoButton(
                  child: Text(
                    _instrument,
                    style: NorthwesternStyles.textRowPlaceholder,
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                  color: CupertinoColors.white,
                  onPressed: () {
                    _showInstrumentPicker();
                  },
                ),
              )
          ),
        ];
      }
    }
  }

  /// Builds the UI using widgets.
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          automaticallyImplyLeading: false,
          middle: const Text('Account'),
          // Right nav bar button, navigates to Home view.
          trailing: CupertinoButton(
              child: const Text(
                'Done',
                style: TextStyle(
                  color: VanderbiltStyles.systemBlue,
                ),
              ),
              padding: const EdgeInsets.all(10),
              onPressed: () {
                if (!_first) {
                  Navigator.of(context).maybePop();
                } else {
                  Navigator.pushReplacement(
                      //context, CupertinoPageRoute(builder: (_) => HomeView(conductor: false)
                      context, CupertinoPageRoute(builder: (_) => TabView(conductor: _conductor)
                  ));
                }
              }),
        ),
        child: SingleChildScrollView(
            child: Column(
                children: _buildCommon(context)
            )
        )
    );
  }
}
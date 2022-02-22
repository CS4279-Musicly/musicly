import 'package:flutter/cupertino.dart';

/// Class to hold all of the custom styles for Vanderbilt.
abstract class VanderbiltStyles {
  // Official Vanderbilt gold.
  static const Color gold = Color.fromRGBO(216, 171, 76, 1);

  // Official dark Vanderbilt gold.
  static const Color darkerGold = Color.fromRGBO(153, 127, 61, 1);

  // Standardized Apple blue used for nav bar buttons.
  static const Color systemBlue = CupertinoColors.systemBlue;

  // Standardized placeholder text style.
  static const TextStyle textRowPlaceholder = TextStyle(
      color: CupertinoColors.systemGrey,
      fontWeight: FontWeight.bold,
      fontSize: 20
  );

  // Standardized text style.
  static const TextStyle textRow = TextStyle(
      color: CupertinoColors.black,
      fontSize: 20
  );

  // Standardized button text style.
  static const TextStyle textButton = TextStyle(
      color: CupertinoColors.white,
      fontSize: 25,
      fontWeight: FontWeight.bold,
  );
}

/// Class to hold all of the custom styles for Northwestern
abstract class NorthwesternStyles {
  // Official Northwestern Purple.
  static const Color purple = Color.fromRGBO(78, 42, 132, 1);
}
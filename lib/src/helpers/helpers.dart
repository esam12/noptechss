import 'package:flutter/material.dart';

bool get isIOS =>
    true; //foundation.defaultTargetPlatform == TargetPlatform.iOS;

class Helpers {
  static const String loginRoute = "/";
  static const String systemViewRoute = "/systemView";
  static const String accountRoute = "/accountview";

  static const Map<int, Color> color = {
    50: Color.fromRGBO(108, 5, 67, .1),
    100: Color.fromRGBO(108, 5, 67, .2),
    200: Color.fromRGBO(108, 5, 67, .3),
    300: Color.fromRGBO(108, 5, 67, .4),
    400: Color.fromRGBO(108, 5, 67, .5),
    500: Color.fromRGBO(108, 5, 67, .6),
    600: Color.fromRGBO(108, 5, 67, .7),
    700: Color.fromRGBO(108, 5, 67, .8),
    800: Color.fromRGBO(108, 5, 67, .9),
    900: Color.fromRGBO(108, 5, 67, 1),
  };
  static const MaterialColor colorCustom = MaterialColor(0xFF6C0543, color);
  static const String savedDomainList = "noptechssaveddomainlists";
}

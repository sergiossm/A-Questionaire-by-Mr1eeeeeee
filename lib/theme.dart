import 'package:flutter/material.dart';

TextTheme buildTextTheme(TextTheme base) => base.copyWith(
      headline6: base.headline6.copyWith(
        fontFamily: 'OpenSans',
        color: Colors.white,
        letterSpacing: .7,
      ),
      headline4: base.headline4.copyWith(
        fontFamily: 'OpenSans',
        color: Color(0xCBFFFFFF),
        fontWeight: FontWeight.w600,
        fontSize: 36,
      ),
    );

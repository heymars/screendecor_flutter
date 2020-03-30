import 'dart:ui';

import 'package:flutter/material.dart';

import 'custom_colors.dart';

class TextStyles {
  static final TextStyle h1Black = TextStyle(
      color: Color(0xffffffff),
      fontFamily: 'Poppins-Bold',
      fontSize: 32,
      letterSpacing: 0);

  static final TextStyle h2Bold = TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins-Regular',
      fontSize: 25,
      letterSpacing: 0);

  static final TextStyle h2Light = TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins-Light',
      fontSize: 25,
      letterSpacing: 0);

  static final TextStyle h2Green = TextStyle(
      color: CustomColors.teal_green,
      fontFamily: 'Poppins-Regular',
      fontSize: 25,
      height: 1);

  static final TextStyle h3Bold = TextStyle(
      color: Colors.black,
      fontFamily: 'Poppins-Bold',
      fontSize: 18,
      letterSpacing: 0);

  static final TextStyle h3Green = TextStyle(
    color: CustomColors.teal_green,
    fontFamily: 'Poppins-Bold',
    fontSize: 18,
    letterSpacing: 0.36,
  );

  static final TextStyle h4DarkSemiBold = TextStyle(
    color: CustomColors.black,
    fontFamily: 'Poppins-SemiBold',
    height: 1.0,
    fontSize: 16,
  );

  static final TextStyle h4DarkGraySemiBold = TextStyle(
    color: CustomColors.brown_grey_three,
    fontFamily: 'Poppins-SemiBold',
    height: 1.0,
    fontSize: 16,
  );

  static final TextStyle h4Black = TextStyle(
    color: Colors.black,
    fontFamily: 'Poppins-Medium',
    height: 1.0,
    fontSize: 15,
  );
  static final TextStyle h4DarkRegular = TextStyle(
    color: Color(0xff373737),
    fontFamily: 'Poppins-Regular',
    height: 1.0,
    letterSpacing: 0.5,
    fontSize: 16,
  );
  static final TextStyle h4DarkGrey = TextStyle(
    color: Color(0xffb2b2b2),
    fontFamily: 'Poppins-Regular',
    height: 1.0,
    letterSpacing: 0.5,
    fontSize: 16,
  );

  static final TextStyle h4White = TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins-Medium',
    fontSize: 15,
  );
  static final TextStyle h4Bold = TextStyle(
    color: Colors.black,
    fontFamily: 'Poppins-Bold',
    fontSize: 15,
    letterSpacing: 0.3,
  );

  static final TextStyle body1 = TextStyle(
    color: Color(0xff4a4a4a),
    fontFamily: 'Poppins-Bold',
    letterSpacing: 0.12,
    fontSize: 14,
  );

  static final TextStyle body2Black = TextStyle(
      color: CustomColors.greyish_brown,
      fontFamily: 'Poppins-Regular',
      fontSize: 12,
      letterSpacing: 0.3);

  static final TextStyle body2BlackMedium = TextStyle(
      color: CustomColors.greyish_brown,
      fontFamily: 'Poppins-Medium',
      fontSize: 12,
      letterSpacing: 0.3);

  static final TextStyle body2Grey = TextStyle(
      color: CustomColors.brown_grey,
      fontFamily: 'Poppins-Regular',
      fontSize: 12,
      letterSpacing: 0.38);
  static final TextStyle bodyText3 = TextStyle(
      color: Color(0xff424242),
      fontFamily: 'Poppins-SemiBold',
      fontSize: 11,
      letterSpacing: 0.1);

  static final TextStyle bodyText2 = TextStyle(
      color: Color(0xff858585),
      fontFamily: 'Poppins-Regular',
      fontSize: 12,
      letterSpacing: 0.38);

  static final TextStyle bodyText4 = TextStyle(
      color: Color(0xff838383),
      fontFamily: 'Poppins-Medium',
      fontSize: 10,
      letterSpacing: 0);
  static final TextStyle hashTag = TextStyle(
    color: Color(0xff7a7a7a),
    letterSpacing: 0.28,
    fontSize: 11,
    fontFamily: 'Poppins-Regular',
  );
}

class TextFieldStyles {
  static final TextStyle editTextStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Poppins-Regular',
    fontSize: 15,
  );
}

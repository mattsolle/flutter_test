import 'package:flutter/material.dart';

import 'theme_extensions/app_typography.dart';

class AppTextStyles {
  ////----- Lora -----//
  static const loraRegularHeadline = TextStyle(
    fontFamily: 'Lora',
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
  );
  static const loraRegularTitle = TextStyle(
    fontFamily: 'Lora',
    fontWeight: FontWeight.w500,
    fontSize: 16.0,
  );

  //----- Open Sans -----//
  static const openRegularHeadline = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 16.0,
    color: Colors.black,
  );
  static const openRegularTitleSemiBold = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w600,
    fontSize: 14.0,
    color: Colors.black,
  );
  static const openRegularTitle = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 14.0,
    color: Colors.black,
  );
  static const openRegularText = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
    color: Colors.black,
  );
  static const openRegularItalic = TextStyle(
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    fontSize: 12.0,
    color: Colors.black,
  );

  static const AppTypography defaultTypography = AppTypography(
    loraRegularHeadline: loraRegularHeadline,
    loraRegularTitle: loraRegularTitle,
    openRegularHeadline: openRegularHeadline,
    openRegularTitleSemiBold: openRegularTitleSemiBold,
    openRegularTitle: openRegularTitle,
    openRegularText: openRegularText,
    openRegularItalic: openRegularItalic,
  );
}

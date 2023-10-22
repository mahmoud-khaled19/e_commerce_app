import 'package:flutter/cupertino.dart';

class AppDimensions {
  static double screenHeight(BuildContext context) =>
      MediaQuery.sizeOf(context).height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.sizeOf(context).width;
}

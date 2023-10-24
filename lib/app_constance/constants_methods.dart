import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import '../../view_model/shared/network/local/shared_preferences.dart';
import '../view/screens/auth_screens/login_screen.dart';

class GlobalMethods {
  static void navigateAndFinish(context, widget) {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.center,
            child: widget,
            duration: const Duration(milliseconds: 1500)),
        (route) => false);
  }

  static void navigateTo(context, widget) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.scale,
            alignment: Alignment.center,
            child: widget,
            duration: const Duration(milliseconds: 1500)));
  }

  static void signOut(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      CacheHelper.removeData(key: 'token');
      if (value!) {
        navigateAndFinish(context, const LoginScreen());
      }
    });
  }

  static showToast(BuildContext context, String text, Color color) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static validate(text, String? value) {
    if (value!.isEmpty) {
      return text;
    } else {
      return null;
    }
  }

  static String? token = '';
}

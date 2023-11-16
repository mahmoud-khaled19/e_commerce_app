import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/style_manager.dart';
import 'package:shop_app/app_constance/values_manager.dart';
import 'colors_manager.dart';

ThemeData getLightApplicationTheme(context) {
  return ThemeData(
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.lightCardColor,
        elevation: 2,
      ),
      cardColor: ColorsManager.lightCardColor,
      appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.akshar(
              color: Colors.black,
              fontSize: AppSize.s16,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w500),
          backgroundColor: ColorsManager.lightScaffoldColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black, size: AppSize.s18)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.lightScaffoldColor,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: ColorsManager.lightSecondColor,
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false
      ),
      iconTheme: IconThemeData(
          color: ColorsManager.lightSecondColor, size: AppSize.s30),
      scaffoldBackgroundColor: ColorsManager.lightScaffoldColor,
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.lightSecondColor,
      primaryColor: ColorsManager.lightSecondColor,
      disabledColor: ColorsManager.grey,
      textTheme: TextTheme(
          headlineLarge: getSemiBoldStyle(
              fontSize: AppDimensions.screenHeight(context)*0.035, color: ColorsManager.black),
          titleLarge: getSemiBoldStyle(
              fontSize: AppDimensions.screenHeight(context)*0.03, color: ColorsManager.black),
          titleMedium:
              getMediumStyle(fontSize: AppDimensions.screenHeight(context)*0.022, color: ColorsManager.black),
          titleSmall: getRegularStyle(
              fontSize: AppDimensions.screenHeight(context)*0.015, color: ColorsManager.grey)),
      brightness: Brightness.light);
}

ThemeData getDarkApplicationTheme(context) {
  return ThemeData(
      scaffoldBackgroundColor: ColorsManager.darkScaffoldColor,
      cardColor: ColorsManager.darkCardColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.darkCardColor,
        elevation: 2,
      ),
      appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.akshar(
              color: Colors.white,
              fontSize: AppSize.s16,
              letterSpacing: 0.6,
              fontWeight: FontWeight.w500),
          backgroundColor: ColorsManager.darkScaffoldColor,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white, size: AppSize.s18)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.darkScaffoldColor,
        type: BottomNavigationBarType.shifting,
        elevation: 0,
        selectedItemColor: ColorsManager.lightSecondColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
      ),
      iconTheme: IconThemeData(
          color: ColorsManager.darkSecondColor, size: AppSize.s30),
      primarySwatch: Colors.grey,
      splashColor: ColorsManager.darkSplashColor,
      primaryColor: ColorsManager.darkSecondColor,
      disabledColor: ColorsManager.grey,
      textTheme: TextTheme(
          headlineLarge:
              getSemiBoldStyle(fontSize: AppDimensions.screenHeight(context)*0.035, color: Colors.white),
          titleLarge:
              getSemiBoldStyle(fontSize: AppDimensions.screenHeight(context)*0.03, color: Colors.white),
          titleMedium:
              getMediumStyle(fontSize: AppDimensions.screenHeight(context)*0.022, color: Colors.white),
          titleSmall: getRegularStyle(
              fontSize: AppDimensions.screenHeight(context)*0.015, color: ColorsManager.grey)),
      brightness: Brightness.dark);
}

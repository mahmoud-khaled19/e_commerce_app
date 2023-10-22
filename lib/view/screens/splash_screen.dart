import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'layout_screens/home_layout.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(
      splashIconSize: size * .5,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      nextScreen:
          GlobalMethods.token != null ? const ShopLayout() : OnBoardingView(),
      splash: Column(
        children: [
          SizedBox(
            height: size * .02,
          ),
          const Center(child: Icon(Icons.shopify_outlined, size: 100)),
          SizedBox(
            height: size * .01,
          ),
          Text(
            AppStrings.appTitle.tr(),
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
    );
  }
}

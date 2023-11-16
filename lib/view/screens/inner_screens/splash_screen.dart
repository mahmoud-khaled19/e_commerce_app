import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/app_constance/values_manager.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import '../main_app_screens/home_layout.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(
      splashIconSize: size * .5,
      duration: 3000,
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      nextScreen: GlobalMethods.token != null
          ? const HomeLayout()
          : const OnBoardingView(),
      splash: Column(
        children: [
          SizedBox(
            height: size * 0.1,
          ),
          Center(
            child: Icon(Icons.shopify_outlined, size: AppSize.s100),
          ),
          SizedBox(
            height: size * .01,
          ),
          const DefaultCustomText(
            text: AppStrings.appTitle,
          )
        ],
      ),
    );
  }
}

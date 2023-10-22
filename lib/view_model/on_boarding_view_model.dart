import 'package:flutter/material.dart';
import '../generated/assets.dart';
import '../models/boarding_screen_list_model.dart';

abstract class OnBoardingViewModel {
  static var boardingController = PageController();
  static bool isLast = false;
  static List<BoardingList> boardingList = [
    BoardingList(
      'Your E-Commerce Journey Begins',
      'Welcome to the ultimate shopping destination!',
      'Start your journey with Our App & Discover',
      Assets.imagesOnBoardingScreen1,
    ),
    BoardingList(
      'Prepare to Shop Til You Drop',
      'Get ready to shop like never before',
      'KOOTA SHOP offers a world of products, discounts',
      Assets.imagesOnBoardingScreen2,
    ),
    BoardingList(
      'Ready to Shop? Let\'s Begin!',
      'Your shopping adventure starts here',
      'Your gateway to amazing deals and unique finds',
      Assets.imagesOnBoardingScreen3,
    ),
  ];
  static late AnimationController animationController;
  static late Animation<TextStyle> animation;
  static late Animation<double> animationButton;
}

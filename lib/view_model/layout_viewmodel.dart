import 'package:flutter/material.dart';
import '../app_constance/strings_manager.dart';
import '../view/screens/main_app_screens/cart_screen.dart';
import '../view/screens/main_app_screens/favorites_screen.dart';
import '../view/screens/main_app_screens/products.dart';
import '../view/screens/main_app_screens/settings.dart';

class LayoutViewModel {
  static List<Widget> screens = [
    const ProductsScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];
  static List<BottomNavigationBarItem> bottomNavBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: AppStrings.homeNavBar),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: AppStrings.favouritesNavBar),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_rounded),
        label: AppStrings.favouritesNavBar),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: AppStrings.settingsNavBar),
  ];
  static List<String> bottomNavTitles = [
    AppStrings.homeNavBar,
    AppStrings.favouritesNavBar,
    AppStrings.cartNavBar,
    AppStrings.settingsNavBar,
  ];
}

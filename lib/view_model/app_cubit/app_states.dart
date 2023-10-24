import 'package:shop_app/models/shop_model/shop_model.dart';

abstract class AppStates {}

class ShopInitialState extends AppStates {}

class ShopChangeTheme extends AppStates {}

class ShopChangeNavBarStates extends AppStates {}

class ShopHomeLoadingState extends AppStates {}

class ShopHomeSuccessState extends AppStates {}

class ShopHomeErrorState extends AppStates {}

class ShopCategorySuccessState extends AppStates {}

class ShopCategoryErrorState extends AppStates {}

class ShopChangeFavoritesSuccessState extends AppStates {}
class ShopChangeFavoritesLoadingsState extends AppStates {}

class ShopChangeFavoritesErrorState extends AppStates {}

class ShopFavoritesSuccessState extends AppStates {}

class ShopGetFavoritesLoadingState extends AppStates {}

class ShopFavoritesErrorState extends AppStates {}

class ShopUserDataSuccessState extends AppStates {
  ShopModel? model;

  ShopUserDataSuccessState({this.model});
}

class ShopUserDataLoadingState extends AppStates {}

class ShopUpdateUserinfoLoadingState extends AppStates {}

class ShopUserDataErrorState extends AppStates {}

class ShopUpdateUserinfoErrorState extends AppStates {}

class ShopUpdateUserinfoSuccessState extends AppStates {
  ShopModel? model;

  ShopUpdateUserinfoSuccessState({this.model});
}

class ShopChangeCartsSuccessState extends AppStates {}

class ShopChangeCartsErrorState extends AppStates {}

class ShopGetCartsSuccessState extends AppStates {}

class ShopGetCartsLoadingState extends AppStates {}

class ShopGetCartsErrorState extends AppStates {}

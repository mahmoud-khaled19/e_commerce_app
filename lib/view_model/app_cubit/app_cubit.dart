import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/carts_model/carts_model.dart';
import 'package:shop_app/models/favorite_model/favorites_model.dart';
import '../../app_constance/api_constance.dart';
import '../../app_constance/constants_methods.dart';
import '../../app_constance/strings_manager.dart';
import '../../models/category_model/category_model.dart';
import '../../models/products_model/products_model.dart';
import '../../models/shop_model/shop_model.dart';
import '../../view/screens/layout_screens/cart_screen.dart';
import '../../view/screens/layout_screens/categories.dart';
import '../../view/screens/layout_screens/favorites_screen.dart';
import '../../view/screens/layout_screens/products/products.dart';
import '../../view/screens/layout_screens/settings/settings.dart';
import '../shared/network/local/shared_preferences.dart';
import '../shared/network/remote/dio.dart';
import 'app_states.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());
  HomeModelData? model;
  ShopModel? userInfo;
  ShopModel? updateInfo;
  FavoritesModel? favModel;
  CartsModel? cartModel;
  Map<int, bool> favourites = {};
  Map<int, bool> carts = {};
  CategoryModel? catModel;

  static ShopCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),
    SettingsScreen(),
  ];
  bool isDark = false;
  List<BottomNavigationBarItem> bottomNavBarItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), label: AppStrings.homeNavBar),
    BottomNavigationBarItem(
        icon: Icon(Icons.apps), label: AppStrings.categoriesNavBar),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: AppStrings.favouritesNavBar),
    BottomNavigationBarItem(
        icon: Icon(Icons.shopping_cart_rounded),
        label: AppStrings.favouritesNavBar),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: AppStrings.settingsNavBar),
  ];

  void changeShopTheme({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopChangeTheme());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark);
      emit(ShopChangeTheme());
    }
  }

  int currentIndex = 0;

  void changeBottomNavBarState(index) {
    currentIndex = index;
    emit(ShopChangeNavBarStates());
  }

  void homeModel() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: ApiConstance.home, token: GlobalMethods.token)
        .then((value) {
      model = HomeModelData.fromJson(value.data);
      for (var element in model!.data!.products) {
        favourites.addAll({element.id!: element.favorite!});
        carts.addAll({element.id!: element.inCart!});
      }
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      emit(ShopHomeErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void categoryModel() {
    DioHelper.getData(url: ApiConstance.category).then((value) {
      catModel = CategoryModel.fromJson(value.data);

      if (kDebugMode) {
        print('Category came SuccessFully');
      }
      emit(ShopCategorySuccessState());
    }).catchError((error) {
      emit(ShopCategoryErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void changeFavoriteState(int productId, context) {
    favourites[productId] = !favourites[productId]!;
    emit(ShopChangeFavoritesSuccessState());
    DioHelper.postData(
            url: ApiConstance.favorites,
            data: {'product_id': productId},
            token: GlobalMethods.token)
        .then((value) {
      favModel = FavoritesModel.fromJson(value.data);
      getFavoritesItems();
      if (favModel?.status != null) {
        favourites[productId] != favourites[productId];
      }

      emit(ShopChangeFavoritesSuccessState());
    }).catchError((error) {
      if (favModel?.status != null) {
        favourites[productId] = !favourites[productId]!;
      }
      emit(ShopChangeFavoritesErrorState());
    });
    if (favModel?.status != null) {
      if (favourites[productId]!) {
        GlobalMethods.showToast(
            context, 'تم إضافه المنتج إلي التفضيلات', Colors.green);
      } else {
        GlobalMethods.showToast(
            context, 'تم حذف المنتج من قائمة التفضيلات ', Colors.yellow);
      }
    }
  }

  void getFavoritesItems() {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(url: ApiConstance.favorites, token: GlobalMethods.token)
        .then((value) {
      favModel = FavoritesModel.fromJson(value.data);
      emit(ShopFavoritesSuccessState());
    }).catchError((error) {
      emit(ShopFavoritesErrorState());
    });
  }

  void getUserdata() {
    emit(ShopUserDataLoadingState());
    DioHelper.getData(url: ApiConstance.profile, token: GlobalMethods.token)
        .then((value) {
      userInfo = ShopModel.fromJson(value.data);
      if (kDebugMode) {
        print(userInfo!.data!.name);
      }
      emit(ShopUserDataSuccessState());
    }).catchError((error) {
      emit(ShopUserDataErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void updateUserdata({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopUpdateUserinfoLoadingState());
    DioHelper.putData(
        url: ApiConstance.update,
        token: GlobalMethods.token,
        data: {
          'name': name,
          'phone': phone,
          'email': email,
        }).then((value) {
      updateInfo = ShopModel.fromJson(value.data);
      if (kDebugMode) {
        print(updateInfo?.data?.name);
      }
      emit(ShopUpdateUserinfoSuccessState());
    }).catchError((error) {
      emit(ShopUpdateUserinfoErrorState());
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }

  void changeCartsState(int productId, context) {
    carts[productId] = !carts[productId]!;
    emit(ShopChangeCartsSuccessState());
    DioHelper.postData(
            url: ApiConstance.cart,
            data: {'product_id': productId},
            token: GlobalMethods.token)
        .then((value) {
      cartModel = CartsModel.fromJson(value.data);
      if (catModel?.status == false) {
        carts[productId] = !carts[productId]!;
      }
      getCartsItems();
      emit(ShopChangeCartsSuccessState());
    }).catchError((error) {
      carts[productId] = !carts[productId]!;
      emit(ShopChangeCartsErrorState());
    });

    if (carts[productId]!) {
      GlobalMethods.showToast(
          context, 'تم إضافه المنتج إلي الشنطه', Colors.green);
    } else {
      GlobalMethods.showToast(
          context, 'تم حذف المنتج من الشنطه ', Colors.yellow);
    }
  }

  Future<void> getCartsItems() async {
    emit(ShopGetCartsLoadingState());
    await DioHelper.getData(url: ApiConstance.cart, token: GlobalMethods.token)
        .then((value) {
      cartModel = CartsModel.fromJson(value.data);

      emit(ShopGetCartsSuccessState());
    }).catchError((error) {
      emit(ShopGetCartsErrorState());
      print(error.toString());
    });
  }
}

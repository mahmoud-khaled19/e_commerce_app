import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/carts_model.dart';
import 'package:shop_app/models/favorites_model.dart';
import '../../app_constance/api_constance.dart';
import '../../app_constance/constants_methods.dart';
import '../../app_constance/strings_manager.dart';
import '../../models/products_model.dart';
import '../shared/network/local/shared_preferences.dart';
import '../shared/network/remote/dio.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(ShopInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  HomeModelData? homeModelData;
  FavoritesModel? favModel;
  CartsModel? cartModel;
  Map<int, bool> favourites = {};
  Map<int, bool> carts = {};
  bool isDark = false;
  int bottomNavIndex = 0;

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

  void changeBottomNavBarState(index) {
    bottomNavIndex = index;
    if (index == 1) {
      getFavoritesItems();
    } else if (index == 2) {
      getCartsItems();
    }
    emit(ShopChangeNavBarStates());
  }

  void homeModel() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(url: ApiConstance.home, token: GlobalMethods.token)
        .then((value) {
      homeModelData = HomeModelData.fromJson(value.data);
      for (var element in homeModelData!.data!.products) {
        favourites.addAll({element.id!: element.favorite!});
        carts.addAll({element.id!: element.inCart!});
      }
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      emit(ShopHomeErrorState());
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
            context, AppStrings.addedSuccessfully, Colors.green);
      } else {
        GlobalMethods.showToast(
            context, AppStrings.removedSuccessfully, Colors.yellow);
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

  void changeCartsState(int productId, context) {
    carts[productId] = !carts[productId]!;
    emit(ShopChangeCartsSuccessState());
    DioHelper.postData(
            url: ApiConstance.cart,
            data: {'product_id': productId},
            token: GlobalMethods.token)
        .then((value) {
      cartModel = CartsModel.fromJson(value.data);
      if (cartModel?.status == false) {
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
          context, AppStrings.addedSuccessfully, Colors.green);
    } else {
      GlobalMethods.showToast(
          context, AppStrings.removedSuccessfully, Colors.red);
    }
  }

  Future<void> getCartsItems() async {
    emit(GetCartsLoadingState());
    await DioHelper.getData(url: ApiConstance.cart, token: GlobalMethods.token)
        .then((value) {
      cartModel = CartsModel.fromJson(value.data);
      emit(GetCartsSuccessState());
    }).catchError((error) {
      emit(GetCartsErrorState());
    });
  }

  Future<void> updateCartItemQuantity({
    required int cartId,
    required int quantity,
  }) async {
    log('Updating cart item quantity - cartId: $cartId, quantity: $quantity');
    emit(UpdateCartItemQuantityLoadingState());
    try {
      final response = await DioHelper.putData(
          url: '${ApiConstance.cart}/$cartId',
          data: {'quantity': quantity},
          token: GlobalMethods.token);

      if (response.statusCode == 200) {
        cartModel = CartsModel.fromJson(response.data);
        emit(UpdateCartItemQuantitySuccessState());
        getCartsItems();
        log('Quantity updated successfully');
      } else {
        emit(UpdateCartItemQuantityErrorState());
        log('Quantity update failed with status code: ${response.statusCode}');
      }
    } catch (error) {
      emit(UpdateCartItemQuantityErrorState());
    }
  }

  increaseItemsQuantity({required int cartId, required quantity}) {
    quantity++;
    log('updated quantity $quantity');
    log('quantity $quantity');
    updateCartItemQuantity(cartId: cartId, quantity: quantity);
    emit(IncreaseCounterState());
  }

  decreaseItemsQuantity({required int cartId, required quantity}) {
    if (quantity > 1) {
      quantity--;
      updateCartItemQuantity(cartId: cartId, quantity: quantity);
      emit(IncreaseCounterState());
    } else {
      return;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/values_manager.dart';
import 'package:shop_app/generated/assets.dart';
import 'package:shop_app/view/components/cart_item.dart';
import 'package:shop_app/view/screens/layout_screens/payment_screen.dart';
import 'package:shop_app/view/screens/layout_screens/product_details.dart';
import 'package:shop_app/view/widgets/elevated_button_widget.dart';
import 'package:shop_app/view/widgets/pop_menu_widget.dart';
import '../../../app_constance/strings_manager.dart';
import '../../../view_model/app_cubit/app_cubit.dart';
import '../../../view_model/app_cubit/app_states.dart';
import '../../components/carts_loading_screen.dart';
import '../../widgets/default_custom_text.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        switch (state.runtimeType) {
          case GetCartsLoadingState:
            return const SelectedItemsLoadingScreen();
          case GetCartsErrorState:
            return Center(
                child: Column(
              children: [
                SizedBox(
                  height: AppDimensions.screenHeight(context) * 0.15,
                ),
                const Image(
                  image: AssetImage(Assets.imagesNoNews),
                ),
                SizedBox(
                  height: AppSize.s16,
                ),
                DefaultCustomText(
                  text: AppStrings.noCarts,
                  style: Theme.of(context).textTheme.titleLarge,
                )
              ],
            ));
          case GetCartsSuccessState:
            return cubit.cartModel!.data!.cartItems!.isEmpty
                ? Center(
                    child: Column(
                    children: [
                      SizedBox(
                        height: AppDimensions.screenHeight(context) * 0.15,
                      ),
                      const Image(
                        image: AssetImage(Assets.imagesNoNews),
                      ),
                      SizedBox(
                        height: AppSize.s16,
                      ),
                      DefaultCustomText(
                        text: AppStrings.noCarts,
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ))
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s10),
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.count(
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            childAspectRatio: 0.62,
                            mainAxisSpacing: 5,
                            children: List.generate(
                                cubit.cartModel!.data!.cartItems!.length,
                                (index) {
                              var data = cubit
                                  .cartModel!.data!.cartItems![index].product!;
                              var cartId =
                                  cubit.cartModel!.data!.cartItems![index].id!;
                              var itemQuantity = cubit
                                  .cartModel!.data!.cartItems![index].quantity!;
                              return Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  CartItem(
                                    quantity: itemQuantity,
                                    increaseFunction: () {
                                      cubit.increaseItemsQuantity(
                                          cartId: cartId,
                                          quantity: itemQuantity);
                                    },
                                    decreaseFunction: () {
                                      cubit.decreaseItemsQuantity(
                                          cartId: cartId,
                                          quantity: itemQuantity);
                                    },
                                    image: data.image!,
                                    cartId: cartId,
                                    name: data.name!,
                                    price: data.price,
                                    discount: data.discount!,
                                    oldPrice: data.oldPrice!,
                                  ),
                                  DefaultPopMenuWidget(
                                    itemOneFunction: () {
                                      cubit.changeCartsState(data.id!, context);
                                      Navigator.pop(context);
                                    },
                                    itemTwoFunction: () {
                                      GlobalMethods.navigateTo(
                                          context,
                                          ProductDetails(
                                            image: data.image!,
                                            name: data.name!,
                                            price: data.price!,
                                            description: data.description!,
                                            oldPrice: data.oldPrice!,
                                            id: data.id,
                                            discount: data.discount,
                                          ));
                                    },
                                    itemOneText: 'Delete Item',
                                    itemTwoText: 'Show Details',
                                  )
                                ],
                              );
                            }),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(
                            AppSize.s8,
                          ),
                          height: AppDimensions.screenHeight(context) * 0.08,
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(AppSize.s10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              DefaultCustomText(
                                text: 'AED ${cubit.cartModel!.data!.total}',
                                alignment: Alignment.bottomCenter,
                              ),
                              SizedBox(
                                width: AppSize.s18,
                              ),
                              DefaultButton(
                                  text:
                                      'Check out (${cubit.cartModel!.data!.cartItems!.length})',
                                  function: () {
                                    GlobalMethods.navigateTo(
                                        context, const PaymentScreen());
                                  },
                                  context: context),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

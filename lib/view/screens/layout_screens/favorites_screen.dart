import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/view/screens/layout_screens/product_details.dart';
import '../../../app_constance/constants_methods.dart';
import '../../../app_constance/strings_manager.dart';
import '../../../generated/assets.dart';
import '../../../view_model/app_cubit/app_cubit.dart';
import '../../../view_model/app_cubit/app_states.dart';
import '../../components/carts_loading_screen.dart';
import '../../components/product_item.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        switch (state.runtimeType) {
          case ShopFavoritesSuccessState:
            return cubit.favourites.values.contains(true)
                ? Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      childAspectRatio: 0.65,
                      mainAxisSpacing: 5,
                      children: List.generate(cubit.favModel!.data!.data.length,
                          (index) {
                        var data = cubit.favModel!.data!.data[index].product!;

                        return GestureDetector(
                            onTap: () {
                              GlobalMethods.navigateTo(
                                  context,
                                  ProductDetails(
                                      image: data.image!,
                                      discount: data.discount,
                                      id: data.id!,
                                      name: data.name!,
                                      price: data.price!,
                                      oldPrice: data.oldPrice,
                                      description: data.description!));
                            },
                            child: ProductItemShape(
                              image: data.image!,
                              id: data.id!,
                              name: data.name!,
                              price: data.price,
                              description: data.description!,
                              discount: data.discount!,
                              oldPrice: data.oldPrice!,
                            ));
                      }),
                    ),
                  )
                : Center(
                    child: Column(
                    children: [
                      SizedBox(
                        height: AppDimensions.screenHeight(context) * 0.15,
                      ),
                      const Image(
                        image: AssetImage(Assets.imagesNoNews),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        AppStrings.noFav,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ));
          case ShopGetFavoritesLoadingState:
            return const SelectedItemsLoadingScreen();
          case ShopFavoritesErrorState:
            return Center(
                child: Column(
              children: [
                SizedBox(
                  height: AppDimensions.screenHeight(context) * 0.15,
                ),
                const Image(
                  image: AssetImage(Assets.imagesNoNews),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  AppStrings.noFav,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ));
        }
        return const SelectedItemsLoadingScreen();
      },
    );
  }
}

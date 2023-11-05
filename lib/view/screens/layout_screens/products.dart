import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/view/screens/layout_screens/product_details.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import '../../../app_constance/constants_methods.dart';
import '../../../app_constance/strings_manager.dart';
import '../../../app_constance/values_manager.dart';
import '../../../view_model/app_cubit/app_cubit.dart';
import '../../../view_model/app_cubit/app_states.dart';
import '../../components/product_item.dart';
import '../../components/products_loading_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        switch (cubit.homeModelData != null) {
          case true:
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                        items: cubit.homeModelData!.data!.banners
                            .map((e) => CachedNetworkImage(
                                  imageUrl: e.image!,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  placeholder: (context, url) =>
                                      Shimmer.fromColors(
                                    baseColor: Colors.grey[800]!,
                                    highlightColor: Colors.grey[500]!,
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: AppSize.s10),
                                      padding: const EdgeInsets.all(10),
                                      color: Theme.of(context).splashColor,
                                      height:
                                          AppDimensions.screenHeight(context) *
                                              0.25,
                                      width: 1,
                                    ),
                                  ),
                                  height: AppDimensions.screenHeight(context) *
                                      0.25,
                                ))
                            .toList(),
                        options: CarouselOptions(
                          height: 200,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          autoPlayAnimationDuration: const Duration(seconds: 4),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.3,
                        )),
                    SizedBox(
                      height: AppSize.s20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DefaultCustomText(
                        alignment: Alignment.centerLeft,
                        text: AppStrings.newProducts,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    SizedBox(
                      height: AppSize.s10,
                    ),
                    GridView.builder(
                        itemCount: cubit.homeModelData!.data!.products.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          childAspectRatio: 0.71,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          var data = cubit.homeModelData!.data!.products[index];
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
                              price: data.price!,
                              description: data.description!,
                              discount: data.discount!,
                              oldPrice: data.oldPrice!,
                            ),
                          );
                        })
                  ]),
            );
          case false:
            return const ProductsLoadingScreen();
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}

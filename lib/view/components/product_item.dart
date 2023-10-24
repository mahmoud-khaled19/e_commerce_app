import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../../../app_constance/app_dimensions.dart';
import '../../../app_constance/constants_methods.dart';
import '../../../app_constance/strings_manager.dart';
import '../../../app_constance/values_manager.dart';
import '../../../view_model/app_cubit/app_cubit.dart';
import '../../../view_model/app_cubit/app_states.dart';
import '../screens/layout_screens/product_details.dart';
import '../widgets/default_custom_text.dart';

class ProductItemShape extends StatelessWidget {
  const ProductItemShape(
      {super.key,
      required this.image,
      required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.discount,
      required this.oldPrice});

  final String image;
  final int id;
  final String name;
  final dynamic price;
  final dynamic discount;
  final dynamic oldPrice;
  final String description;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          child: InkWell(
            onTap: () {
              GlobalMethods.navigateTo(
                  context,
                  ProductDetails(
                    discount: discount,
                    image: image,
                    oldPrice: oldPrice,
                    id: id,
                    price: '${price.round()}',
                    description: description,
                    name: name,
                  ));
            },
            child: Column(
              children: [
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: image,
                      height: AppDimensions.screenHeight(context) * 0.2,
                      width: double.infinity,
                      placeholder: (context, child) => Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            color: Theme.of(context).splashColor,
                          ),
                          height: AppDimensions.screenHeight(context) * 0.2,
                          width: AppSize.s100,
                          margin: EdgeInsets.symmetric(horizontal: AppSize.s10),
                        ),
                      ),
                    ),
                    if (discount != 0)
                      Container(
                        width: AppSize.s70,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(AppSize.s8)),
                        child: const DefaultCustomText(
                          text: AppStrings.discount,
                        ),
                      )
                  ],
                ),
                SizedBox(
                  height: AppSize.s10,
                ),
                DefaultCustomText(
                  text: name,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultCustomText(
                      text: 'AED ${price.round()}',
                      color: Colors.black,
                    ),
                    SizedBox(width: AppSize.s2),
                    if (discount != 0)
                      DefaultCustomText(
                        text: '${oldPrice.round()}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        cubit.changeFavoriteState(id, context);
                      },
                      icon: CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          cubit.favourites[id]!
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: AppSize.s24,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

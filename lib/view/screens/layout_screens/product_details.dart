import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import '../../../app_constance/strings_manager.dart';
import '../../../app_constance/values_manager.dart';
import '../../../view_model/app_cubit/app_cubit.dart';
import '../../../view_model/app_cubit/app_states.dart';

class ProductDetails extends StatelessWidget {
  final String image;
  final dynamic price;
  final dynamic oldPrice;
  final dynamic discount;
  final dynamic id;
  final String name;
  final String description;

  const ProductDetails({
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.oldPrice,
    super.key,
    required this.id,
    required this.discount,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Column(
              children: [
                CachedNetworkImage(
                  imageUrl: image,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: AppDimensions.screenHeight(context) * 0.4,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.s8),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          DefaultCustomText(
                            text: name,
                            maxLines: name.length,
                          ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          Row(
                            children: [
                              DefaultCustomText(
                                  text: 'AED $price',
                                  alignment: Alignment.centerLeft,
                                  color: Colors.blue),
                              SizedBox(
                                width: AppSize.s10,
                              ),
                              if (discount != 0)
                                DefaultCustomText(
                                    text: '$oldPrice',
                                    alignment: Alignment.centerLeft,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                        )),
                            ],
                          ),
                          DefaultCustomText(
                            text: 'Description',
                            alignment: Alignment.centerLeft,
                            maxLines: description.length,
                          ),
                          DefaultCustomText(
                            text: description,
                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: description.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(5),
                    width: double.infinity,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: AppSize.s40,
                          color: Theme.of(context).cardColor,
                          child: InkWell(
                            onTap: () {
                              cubit.changeFavoriteState(id, context);
                            },
                            child: Icon(
                              cubit.favourites[id]!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: AppSize.s24,
                            ),
                          ),
                        ),
                        Expanded(
                            child: InkWell(
                          onTap: () {
                             cubit.changeCartsState(id, context);
                          },
                          child: Container(
                              color: Theme.of(context).cardColor,
                              height: AppSize.s40,
                              child: DefaultCustomText(
                                alignment: Alignment.bottomCenter,
                                text: cubit.carts[id]!
                                    ? AppStrings.inYourBag
                                    : AppStrings.addToBag,
                              )),
                        ))
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

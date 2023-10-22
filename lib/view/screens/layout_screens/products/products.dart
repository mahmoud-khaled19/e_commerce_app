import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view/screens/layout_screens/products/products_details/product_details.dart';
import '../../../../app_constance/constants_methods.dart';
import '../../../../app_constance/strings_manager.dart';
import '../../../../models/products_model/products_model.dart';
import '../../../../view_model/app_cubit/app_cubit.dart';
import '../../../../view_model/app_cubit/app_states.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return ConditionalBuilder(
            condition: cubit.model != null,
            builder: (context) => productsBuilder(cubit.model!, context),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }
}

Widget productsBuilder(HomeModelData model, context) => SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CarouselSlider(
            items: model.data!.banners
                .map((e) => Image(
                      image: NetworkImage(e.image!),
                      width: double.infinity,
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height * 0.25,
                    ))
                .toList(),
            options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                scrollDirection: Axis.horizontal,
                autoPlayAnimationDuration: const Duration(seconds: 4),
                autoPlayCurve: Curves.fastOutSlowIn)),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            AppStrings.newProducts.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey[100],
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: model.data!.products.length,
            itemBuilder: (BuildContext context, int index) {
              return productItem(model.data!.products[index], context);
              },
          ),
        )
      ]),
    );

Widget productItem(ProductsModel model, context) =>
    BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(5),
          child: InkWell( 
            onTap: () {
              GlobalMethods.navigateTo(
                  context,
                  ProductDetails(
                    image: model.image!,
                    id: model.id,
                    price: '${AppStrings.price} : ${model.price.round()}',
                    description: model.description!,
                    name: model.name!,
                  ));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(model.image!),
                          height: MediaQuery.of(context).size.height * 0.22,
                          width: double.infinity,
                        ),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavoriteState(model.id!,context);
                          },
                          icon: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              ShopCubit.get(context).favourites[model.id]!
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: MediaQuery.of(context).size.width * 0.06,
                            ),
                          ),
                        )
                      ],
                    ),
                    if (model.discount != 0)
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          AppStrings.discount.tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Egp ${model.price.round()}',
                            maxLines: 1,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(width: 8),
                          if (model.discount != 0)
                            Text(
                              '${model.oldPrice.round()}',
                              style: TextStyle(
                                  fontSize: 10,
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey[600]),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        model.name!,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                            height: model.name!.characters.length <= 20
                                ? MediaQuery.of(context).size.height * .0038
                                : MediaQuery.of(context).size.height * .0019),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );

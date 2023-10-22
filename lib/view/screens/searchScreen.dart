import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/view/widgets/default_text_form_field.dart';
import '../../generated/assets.dart';
import '../../view_model/app_cubit/app_cubit.dart';
import '../../view_model/search_cubit/cubit.dart';
import '../../view_model/search_cubit/states.dart';
import 'layout_screens/products/products_details/product_details.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double hSize = AppDimensions.screenHeight(context);
    double wSize = AppDimensions.screenWidth(context);
    return BlocBuilder<SearchCubit, SearchStates>(
      builder: (context, state) {
        SearchCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultTextFormField(
                      controller: cubit.searchController,
                      onSubmitted: () {
                        if (formKey.currentState!.validate()) {
                          cubit.getSearch();
                        }
                      },
                      hint: AppStrings.search.tr()),
                  const SizedBox(
                    height: 10,
                  ),
                  if (state is LoadingSearchState)
                    const LinearProgressIndicator(),
                  if (state is! LoadingSearchState &&
                      state is! SuccessSearchState)
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            height: hSize * 0.05,
                          ),
                          const Image(
                            image: AssetImage(Assets.imagesSearch),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.searchScreen.tr(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (state is SuccessSearchState &&
                      cubit.model!.data!.data.isEmpty)
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          SizedBox(
                            height: hSize * 0.05,
                          ),
                          Image(
                            height: hSize * 0.3,
                            image: const AssetImage(Assets.imagesSearch),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              AppStrings.searchScreen2.tr(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (state is SuccessSearchState &&
                      cubit.model!.data!.data.isNotEmpty)
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: cubit.model!.data!.data.length,
                          itemBuilder: (context, index) => SizedBox(
                                height: hSize * 0.15,
                                child: Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      var data = cubit.model!.data!.data[index];
                                      GlobalMethods.navigateTo(
                                          context,
                                          ProductDetails(
                                              image: data.image!,
                                              id: data.id!,
                                              name: data.name!,
                                              price: data.price,
                                              description: data.description!));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Image(
                                            image: NetworkImage(cubit.model!
                                                .data!.data[index].image!),
                                            width: wSize * 0.2,
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  cubit.model!.data!.data[index]
                                                      .name!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                                Text(
                                                  'EGP ${cubit.model!.data!.data[index].price.toString()}',
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                      height: 1.8,
                                                      fontSize: 14,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Spacer(),
                                          Icon(
                                            ShopCubit.get(context).favourites[
                                                    cubit.model!.data!
                                                        .data[index].id!]!
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: Colors.red,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.06,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

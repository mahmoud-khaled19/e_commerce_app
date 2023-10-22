import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import '../../view_model/app_cubit/app_cubit.dart';

Widget productListItem(context, model) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image(
                  image: NetworkImage(model.product.image),
                  height: MediaQuery.of(context).size.height * 0.21,
                  width: double.infinity,
                ),
              ),
              if (model.product.discount != 0)
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
            padding: const EdgeInsets.only(left: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'EGP ${model.product!.price.toString()}',
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(width: 8),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    ShopCubit.get(context)
                        .changeFavoriteState(model.product!.id!, context);
                  },
                  icon: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      ShopCubit.get(context).favourites[model.product!.id!]!
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Colors.red,
                      size: MediaQuery.of(context).size.width * 0.06,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );

Widget listTileWidget({
  context,
  required String text,
  Function()? function,
  IconData? icon,
}) =>
    GestureDetector(
      onTap: function,
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: ListTile(
            style: ListTileStyle.list,
            title: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: Icon(
              icon,
              color: Theme.of(context).splashColor,
            )),
      ),
    );

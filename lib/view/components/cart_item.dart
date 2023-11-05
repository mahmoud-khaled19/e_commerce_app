import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../app_constance/app_dimensions.dart';
import '../../../app_constance/values_manager.dart';
import '../widgets/default_custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.image,
    required this.cartId,
    required this.name,
    required this.price,
    required this.discount,
    required this.oldPrice,
    required this.quantity,
    required this.decreaseFunction,
    required this.increaseFunction,
  });

  final String name, image;
  final int cartId, quantity;
  final Function() decreaseFunction, increaseFunction;
  final dynamic price, discount, oldPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppSize.s10)),
      child: Column(
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
          SizedBox(
            height: AppSize.s10,
          ),
          DefaultCustomText(
            text: name,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultCustomText(
                text: 'AED ${price.round()}',
                fontSize: AppSize.s12,
              ),
              SizedBox(width: AppSize.s2),
              if (discount != 0)
                DefaultCustomText(
                  text: '${oldPrice.round()}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: AppSize.s4),
            padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(AppSize.s10)),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: decreaseFunction,
                    child: const DefaultCustomText(
                      text: '-',
                    ),
                  ),
                ),
                Expanded(
                  child: DefaultCustomText(text: '$quantity'),
                ),
                Expanded(
                  child: InkWell(
                    onTap: increaseFunction,
                    child: const DefaultCustomText(
                      text: '+',
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

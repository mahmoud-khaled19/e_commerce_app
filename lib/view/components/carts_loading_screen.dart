import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../app_constance/app_dimensions.dart';
import '../../app_constance/values_manager.dart';

class SelectedItemsLoadingScreen extends StatelessWidget {
  const SelectedItemsLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s10),
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              childAspectRatio: 0.7,
              mainAxisSpacing: 5,
              children: List.generate(6, (index) {
                return Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(AppSize.s10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: AppSize.s20,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            color: Theme.of(context).splashColor,
                          ),
                          height: AppDimensions.screenHeight(context) * 0.2,
                          width: AppSize.s100,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s10,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            color: Theme.of(context).splashColor,
                          ),
                          height: AppDimensions.screenHeight(context) * 0.02,
                          width: AppSize.s100,
                        ),
                      ),
                      SizedBox(
                        height: AppSize.s8,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSize.s20),
                            color: Theme.of(context).splashColor,
                          ),
                          height: AppDimensions.screenHeight(context) * 0.02,
                          width: AppSize.s100,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

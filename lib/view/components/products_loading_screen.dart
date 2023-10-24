import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../app_constance/app_dimensions.dart';
import '../../../app_constance/values_manager.dart';

class ProductsLoadingScreen extends StatelessWidget {
  const ProductsLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSize.s10),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CarouselSlider(
              items: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[500]!,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: AppSize.s10),
                    padding: const EdgeInsets.all(10),
                    color: Theme.of(context).splashColor,
                    height: AppDimensions.screenHeight(context) * 0.25,
                    width: double.infinity,
                  ),
                )
              ],
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
          Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[500]!,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.s20),
                color: Theme.of(context).splashColor,
              ),
              height: AppSize.s40,
              width: AppSize.s100,
              margin: EdgeInsets.symmetric(horizontal: AppSize.s10),
            ),
          ),
          SizedBox(
            height: AppSize.s10,
          ),
          GridView.builder(
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                childAspectRatio: 0.71,
                mainAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[800]!,
                  highlightColor: Colors.grey[500]!,
                  child: Container(
                    color: Theme.of(context).splashColor,
                    padding: const EdgeInsets.all(10),
                    height: AppSize.s100,
                    width: AppSize.s100,
                  ),
                );
              })
        ]),
      ),
    );
  }
}

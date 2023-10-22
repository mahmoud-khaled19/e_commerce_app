import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import '../../../app_constance/constants_methods.dart';
import '../../../view_model/app_cubit/app_cubit.dart';
import '../../../view_model/app_cubit/app_states.dart';
import '../searchScreen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopStates>(
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                AppStrings.appTitle.tr(),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.compare_arrows),
                  onPressed: () {
                    cubit.homeModel();
                    cubit.categoryModel();
                    cubit.getFavoritesItems();
                    cubit.getUserdata();
                    cubit.getCartsItems();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    GlobalMethods.navigateTo(context, SearchScreen());
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int index) {
                cubit.changeBottomNavBarState(index);
              },
              currentIndex: cubit.currentIndex,
              items: cubit.bottomNavBarItems,
            ),
            body: cubit.screens[cubit.currentIndex]);
      },
    );
  }
}

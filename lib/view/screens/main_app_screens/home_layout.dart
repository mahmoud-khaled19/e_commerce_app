import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view_model/layout_viewmodel.dart';
import '../../../app_constance/constants_methods.dart';
import '../../../app_constance/values_manager.dart';
import '../../../view_model/app_cubit/app_cubit.dart';
import '../../../view_model/app_cubit/app_states.dart';
import '../inner_screens/searchScreen.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                LayoutViewModel.bottomNavTitles[cubit.bottomNavIndex],
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    GlobalMethods.navigateTo(context, SearchScreen());
                  },
                ),
                SizedBox(
                  width: AppSize.s4,
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (int index) {
                cubit.changeBottomNavBarState(index);
              },
              currentIndex: cubit.bottomNavIndex,
              items: LayoutViewModel.bottomNavBarItems,
            ),
            body: LayoutViewModel.screens[cubit.bottomNavIndex]);
      },
    );
  }
}

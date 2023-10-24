import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app_constance/constants_methods.dart';
import '../../../view_model/app_cubit/app_cubit.dart';
import '../../../view_model/app_cubit/app_states.dart';
import '../searchScreen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
            appBar: AppBar(
              title: Text(
                cubit.bottomNavTitles[cubit.currentIndex],
              ),
              actions: [
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

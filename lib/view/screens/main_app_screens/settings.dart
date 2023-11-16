import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/view/screens/inner_screens/splash_screen.dart';
import 'package:shop_app/view/screens/main_app_screens/login_screen.dart';
import 'package:shop_app/view/screens/inner_screens/update_user_info_screen.dart';
import 'package:shop_app/view/widgets/default_list_tile.dart';
import '../../../view_model/app_cubit/app_cubit.dart';
import '../../../view_model/app_cubit/app_states.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double size = AppDimensions.screenWidth(context);
    return BlocBuilder<AppCubit, AppStates>(
      builder: (BuildContext context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size * 0.1),
                DefaultListTile(
                  function: () {
                    cubit.changeShopTheme();
                  },
                  icon: cubit.isDark ? Icons.dark_mode : Icons.brightness_4,
                  title:
                      cubit.isDark ? AppStrings.lightMode : AppStrings.darkMode,
                ),
                SizedBox(height: size * 0.01),
                DefaultListTile(
                  title: AppStrings.update,
                  function: () {
                    GlobalMethods.navigateTo(context, const UpdateUserInfoScreen());
                  },
                  icon: Icons.privacy_tip_outlined,
                ),
                SizedBox(height: size * 0.01),
                DefaultListTile(
                    title: AppStrings.signOut,
                    function: () {
                      GlobalMethods.showAlertDialog(
                        context: context,
                        title: const Text(AppStrings.signOut),
                        content: const Text('Are you Sure to Sign Out'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                             GlobalMethods.signOut(context);
                            },
                            child: const Text('Ok'),
                          ),
                        ],
                      );
                    },
                    icon: Icons.logout_outlined),
              ],
            ),
          ),
        );
      },
    );
  }
}

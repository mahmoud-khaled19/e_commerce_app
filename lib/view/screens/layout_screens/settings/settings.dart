import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/view/screens/layout_screens/settings/privacy_screen.dart';
import 'package:shop_app/view/widgets/default_list_tile.dart';
import '../../../../view_model/app_cubit/app_cubit.dart';
import '../../../../view_model/app_cubit/app_states.dart';
import '../../../widgets/elevated_button_widget.dart';
import 'about_me.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        AppCubit cubit = BlocProvider.of(context);
        return Scaffold(
          key: scaffoldKey,
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
                    GlobalMethods.navigateTo(context, PrivacyScreen());
                  },
                  icon: Icons.privacy_tip_outlined,
                ),
                SizedBox(height: size * 0.01),
                DefaultListTile(
                  title: AppStrings.aboutMe,
                  function: () {
                    var data = cubit.userInfo!.data!;
                    GlobalMethods.navigateTo(
                        context,
                        AboutMe(
                          name: data.name,
                          phone: data.phone,
                          email: data.email,
                        ));
                  },
                  icon: Icons.person,
                ),
                SizedBox(height: size * 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DefaultButton(
                        context: context,
                        width: size * 0.4,
                        text: AppStrings.signOut,
                        function: () {
                          GlobalMethods.signOut(context);
                          GlobalMethods.token = '';
                        }),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

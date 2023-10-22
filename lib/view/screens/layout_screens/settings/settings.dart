import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/view/screens/layout_screens/settings/privacy_screen.dart';
import '../../../../view_model/app_cubit/app_cubit.dart';
import '../../../../view_model/app_cubit/app_states.dart';
import '../../../widgets/elevated_button_widget.dart';
import '../../../widgets/widgets.dart';
import 'about_me.dart';
import '../../../widgets/localization.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, Object? state) {},
      builder: (BuildContext context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return Scaffold(
          key: scaffoldKey,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: size * 0.1),
                listTileWidget(
                  context: context,
                  text: cubit.isDark
                      ? AppStrings.lightMode.tr()
                      : AppStrings.darkMode.tr(),
                  function: () {
                    cubit.changeShopTheme();
                  },
                  icon: cubit.isDark ? Icons.dark_mode : Icons.brightness_4,
                ),
                SizedBox(height: size * 0.01),
                const LocalizationTheme(),
                SizedBox(height: size * 0.01),
                listTileWidget(
                  context: context,
                  text: AppStrings.update.tr(),
                  function: () {
                    GlobalMethods.navigateTo(context, PrivacyScreen());
                  },
                  icon: Icons.privacy_tip_outlined,
                ),
                SizedBox(height: size * 0.01),
                listTileWidget(
                  context: context,
                  text: AppStrings.aboutMe.tr(),
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
                        text: AppStrings.signOut.tr(),
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

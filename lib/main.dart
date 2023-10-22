import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/app_constance/theme_manager.dart';
import 'package:shop_app/view/screens/splash_screen.dart';
import 'package:shop_app/view_model/app_cubit/app_cubit.dart';
import 'package:shop_app/view_model/app_cubit/app_states.dart';
import 'package:shop_app/view_model/login_cubit/login_cubit.dart';
import 'package:shop_app/view_model/register_cubit/register_cubit.dart';
import 'package:shop_app/view_model/search_cubit/cubit.dart';
import 'package:shop_app/view_model/shared/network/local/shared_preferences.dart';
import 'package:shop_app/view_model/shared/network/remote/dio.dart';
import 'view_model/bloc observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? true;
  GlobalMethods.token = CacheHelper.getData(key: 'token');
  runApp(EasyLocalization(
    useOnlyLangCode: true,
    saveLocale: true,
    supportedLocales: const [
      Locale('en'),
      Locale('ar'),
    ],
    fallbackLocale: const Locale('ar'),
    path: 'assets/translations',
    child: MyApp(isDark),
  ));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp(this.isDark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..homeModel()
            ..changeShopTheme(fromShared: isDark)
            ..categoryModel()
            ..getFavoritesItems()
            ..getUserdata()
            ..getCartsItems(),
        ),
        BlocProvider(
          create: (BuildContext context) => RegisterCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => SearchCubit(),
        ),
      ],
      child: BlocBuilder<ShopCubit, ShopStates>(
        builder: (context, state) {
          return MaterialApp(
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            localeResolutionCallback: (deviceLocale, supportLocales) {
              for (var locale in supportLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }
              return null;
            },
            title: AppStrings.appTitle.tr(),
            debugShowCheckedModeBanner: false,
            theme: ShopCubit.get(context).isDark
                ? getLightApplicationTheme()
                : getDarkApplicationTheme(),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}

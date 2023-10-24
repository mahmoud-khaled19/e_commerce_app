import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  await DioHelper.init();
  await CacheHelper.init();
  Bloc.observer = MyBlocObserver();
  bool isDark = CacheHelper.getData(key: 'isDark') ?? true;
  GlobalMethods.token = CacheHelper.getData(key: 'token');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp(this.isDark, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()
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
      child: BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            useInheritedMediaQuery: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: AppStrings.appTitle,
                debugShowCheckedModeBanner: false,
                theme: AppCubit.get(context).isDark
                    ? getLightApplicationTheme()
                    : getDarkApplicationTheme(),
                home: const SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}

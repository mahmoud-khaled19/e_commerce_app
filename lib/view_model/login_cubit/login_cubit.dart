import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/api_constance.dart';
import '../../../../models/shop_model/shop_model.dart';
import '../../app_constance/constants_methods.dart';
import '../../view/screens/layout_screens/home_layout.dart';
import '../shared/network/local/shared_preferences.dart';
import '../shared/network/remote/dio.dart';
import 'login_app_states.dart';

class LoginCubit extends Cubit<LoginAppStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool isVisible = true;
  late ShopModel loginModel;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void changePassVisibility() {
    isVisible = !isVisible;
    emit(ChangePassVisibility());
  }

  void userLogin({
    context,
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
        url: ApiConstance.login,
        data: {'email': email, 'password': password}).then((value) {
      loginModel = ShopModel.fromJson(value.data);
      if (loginModel.status!) {
        CacheHelper.saveData(key: 'token', value: loginModel.data!.token)
            .then((value) {
          GlobalMethods.token = loginModel.data!.token!;
          GlobalMethods.navigateAndFinish(context, const ShopLayout());
        });
      } else {
        GlobalMethods.showToast(context, loginModel.message!, Colors.red);
      }
      emit(LoginSuccessState());
    }).catchError((error) {
      GlobalMethods.showToast(context, error.toString(), Colors.green);
      emit(LoginErrorState());
    });
  }
}

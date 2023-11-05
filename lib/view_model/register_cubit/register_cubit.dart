import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/view/screens/auth_screens/login_screen.dart';
import 'package:shop_app/view_model/register_cubit/register_app_states.dart';
import '../../../app_constance/api_constance.dart';
import '../../app_constance/constants_methods.dart';
import '../shared/network/remote/dio.dart';

class RegisterCubit extends Cubit<RegisterAppStates> {
  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool visible = true;
  RegisterModel? registerModel;

  void changePassVisibility() {
    visible = !visible;
    emit(ChangePassVisibilityForRegister());
  }

  void userRegister(
    context, {
    String? email,
    String? name,
    String? phone,
    String? password,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: ApiConstance.register, data: {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    }).then((value) {
      registerModel = RegisterModel.fromJson(value.data);
      if (registerModel!.status!) {
        GlobalMethods.navigateAndFinish(context, const LoginScreen());
        GlobalMethods.showToast(context, registerModel!.message!, Colors.green);
      } else {
        GlobalMethods.showToast(context, registerModel!.message!, Colors.red);
      }
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState());
      GlobalMethods.showToast(context, error.toString(), Colors.green);
    });
  }
}

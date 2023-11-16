import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_constance/api_constance.dart';
import '../../app_constance/constants_methods.dart';
import '../../models/user_info_model.dart';
import '../shared/network/remote/dio.dart';
import 'user_info_states.dart';

class UserInfoCubit extends Cubit<UserInfoStates> {
  UserInfoCubit() : super(InitialUserInfoState());

  static UserInfoCubit get(context) => BlocProvider.of(context);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  UserInfoModel? userInfo;
  bool isEditable = false;

  changeEditAbility() {
    isEditable = !isEditable;
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    emit(ChangeEditAbilityState());
  }

  Future updateUserdata({
    context,
  }) async {
    emit(UpdateUserinfoLoadingState());
    await DioHelper.putData(
        url: ApiConstance.update,
        token: GlobalMethods.token,
        data: {
          'name': nameController.text,
          'phone': phoneController.text,
          'email': emailController.text,
        }).then((value) {
      userInfo = UserInfoModel.fromJson(value.data);
      GlobalMethods.showToast(
          context, userInfo!.message.toString(), Colors.green);
      getUserdata(context);
      changeEditAbility();
      emit(UpdateUserinfoSuccessState());
    }).catchError((error) {
      GlobalMethods.showToast(
          context, userInfo!.message.toString(), Colors.red);
      emit(UpdateUserinfoErrorState());
    });
  }

  void getUserdata(context) {
    emit(GetUserDataLoadingState());
    DioHelper.getData(url: ApiConstance.profile, token: GlobalMethods.token)
        .then((value) {
      userInfo = UserInfoModel.fromJson(value.data);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }
}

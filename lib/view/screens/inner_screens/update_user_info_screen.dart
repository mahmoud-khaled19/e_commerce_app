import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import 'package:shop_app/view/widgets/default_text_form_field.dart';
import 'package:shop_app/view/widgets/elevated_button_widget.dart';
import 'package:shop_app/view_model/user_info_cubit/user_info_cubit.dart';
import '../../../app_constance/values_manager.dart';
import '../../../view_model/user_info_cubit/user_info_states.dart';

class UpdateUserInfoScreen extends StatelessWidget {
  const UpdateUserInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hSize = AppDimensions.screenHeight(context);
    double wSize = AppDimensions.screenWidth(context);

    return BlocProvider(
      create: (context) => UserInfoCubit()..getUserdata(context),
      child: BlocBuilder<UserInfoCubit, UserInfoStates>(
        builder: (context, state) {
          UserInfoCubit cubit = BlocProvider.of(context);
          return Scaffold(
              appBar: AppBar(
                title: const Text(
                  AppStrings.update,
                ),
                actions: [
                  cubit.isEditable
                      ? IconButton(
                          onPressed: () {
                            cubit.changeEditAbility();
                          },
                          icon: const Icon(Icons.close),
                        )
                      : IconButton(
                          onPressed: () {
                            cubit.changeEditAbility();
                          },
                          icon: const Icon(Icons.edit),
                        )
                ],
              ),
              body: ConditionalBuilder(
                condition: cubit.userInfo != null,
                builder: (BuildContext context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.s14),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          DefaultCustomText(
                            text: 'Name',
                            alignment: Alignment.centerLeft,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          DefaultTextFormField(
                              enabled: cubit.isEditable,
                              validate: (String? value) {
                                return GlobalMethods.validate(
                                    'Insert Your New Name', value);
                              },
                              controller: cubit.nameController,
                              hint: cubit.userInfo!.data!.name!),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          DefaultCustomText(
                            text: 'Phone',
                            alignment: Alignment.centerLeft,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          DefaultTextFormField(
                            validate: (String? value) {
                              return GlobalMethods.validate(
                                  'Insert Your New Phone Number', value);
                            },
                            enabled: cubit.isEditable,
                            hint: cubit.userInfo!.data!.phone!,
                            textType: TextInputType.phone,
                            controller: cubit.phoneController,
                          ),
                          SizedBox(
                            height: AppSize.s10,
                          ),
                          DefaultCustomText(
                            text: 'Email',
                            alignment: Alignment.centerLeft,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          DefaultTextFormField(
                            enabled: cubit.isEditable,
                            textType: TextInputType.emailAddress,
                            controller: cubit.emailController,
                            hint: cubit.userInfo!.data!.email!,
                            validate: (String? value) {
                              return GlobalMethods.validate(
                                  'Insert Your New Email', value);
                            },
                          ),
                          SizedBox(
                            height: hSize * 0.06,
                          ),
                          if (cubit.isEditable)
                            state is! UpdateUserinfoLoadingState
                                ? DefaultButton(
                                    context: context,
                                    width: wSize * 0.4,
                                    text: AppStrings.update,
                                    function: () {
                                      if (cubit.formKey.currentState!
                                          .validate()) {
                                        cubit.updateUserdata(context: context);
                                      }
                                    })
                                : const CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                ),
                fallback: (BuildContext context) => Padding(
                  padding: EdgeInsets.all(AppSize.s14),
                  child: Column(
                    children: [
                      loadingItem(context),
                      loadingItem(context),
                      loadingItem(context),
                      SizedBox(
                        height: hSize * 0.06,
                      ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}

Widget loadingItem(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        height: AppDimensions.screenHeight(context) * 0.03,
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[500]!,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10),
              color: Colors.blue),
          height: AppDimensions.screenHeight(context) * 0.06,
          width: AppSize.s100,
        ),
      ),
      SizedBox(
        height: AppDimensions.screenHeight(context) * 0.03,
      ),
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[500]!,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s10),
              color: Colors.blue),
          height: AppDimensions.screenHeight(context) * 0.06,
          width: double.infinity,
        ),
      ),
    ],
  );
}

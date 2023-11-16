import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/view/screens/main_app_screens/login_screen.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import 'package:shop_app/view/widgets/elevated_button_widget.dart';
import '../../../app_constance/values_manager.dart';
import '../../../generated/assets.dart';
import '../../../view_model/register_cubit/register_app_states.dart';
import '../../../view_model/register_cubit/register_cubit.dart';
import '../../widgets/default_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hSize = AppDimensions.screenHeight(context);
    return BlocBuilder<RegisterCubit, RegisterAppStates>(
      builder: (context, state) {
        RegisterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s20),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(
                        Assets.imagesRegister,
                      ),
                      fit: BoxFit.cover,
                    ),
                    DefaultCustomText(
                      text: AppStrings.register,
                      style: Theme.of(context).textTheme.headlineLarge,
                      alignment: Alignment.centerLeft,
                    ),
                    DefaultTextFormField(
                      // validate: (String? value) {
                      //   return GlobalMethods.validate(
                      //       AppStrings.validateName, value);
                      // },
                      controller: cubit.nameController,
                      hint: AppStrings.nameLabel,
                    ),
                    DefaultTextFormField(
                      // validate: (String? value) {
                      //   return GlobalMethods.validate(
                      //       AppStrings.validatePhone, value);
                      // },
                      textType: TextInputType.phone,
                      controller: cubit.phoneController,
                      hint: AppStrings.phoneLabel,
                    ),
                    DefaultTextFormField(
                      // validate: (String? value) {
                      //   return GlobalMethods.validate(
                      //       AppStrings.validateEmail, value);
                      // },
                      textType: TextInputType.emailAddress,
                      isSecure: false,
                      controller: cubit.emailController,
                      hint: AppStrings.emailLHint,
                    ),
                    DefaultTextFormField(
                        // validate: (String? value) {
                        //   if (value!.isEmpty) {
                        //     return AppStrings.validatePassword;
                        //   }
                        //   return AppStrings.validatePassword;
                        // },
                        hint: AppStrings.passwordLabel,
                        isSecure: cubit.visible,
                        controller: cubit.passController,
                        suffixIcon: cubit.visible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixFunction: () {
                          cubit.changePassVisibility();
                        }),
                    SizedBox(
                      height: hSize * 0.03,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      child: state is! RegisterLoadingState
                          ? DefaultButton(
                              context: context,
                              text: AppStrings.register,
                              function: () {
                                cubit.userRegister(context,
                                    email: cubit.emailController.text,
                                    name: cubit.nameController.text,
                                    phone: cubit.phoneController.text,
                                    password: cubit.passController.text);
                                cubit.emailController.clear();
                                cubit.nameController.clear();
                                cubit.phoneController.clear();
                                cubit.passController.clear();
                              })
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: hSize * 0.02,
                    ),
                    Row(
                      children: [
                        DefaultCustomText(
                          text: AppStrings.alreadyHaveAccount,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        GestureDetector(
                          onTap: () {
                            GlobalMethods.navigateAndFinish(
                                context, const LoginScreen());
                          },
                          child: const DefaultCustomText(
                            text: AppStrings.login,
                            color: Colors.blue,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/view/screens/auth_screens/login_screen.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import 'package:shop_app/view/widgets/elevated_button_widget.dart';
import '../../../app_constance/values_manager.dart';
import '../../../generated/assets.dart';
import '../../../view_model/register_cubit/register_app_states.dart';
import '../../../view_model/register_cubit/register_cubit.dart';
import '../../widgets/default_text_form_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double hSize = AppDimensions.screenHeight(context);
    return BlocBuilder<RegisterCubit, RegisterAppStates>(
      builder: (context, state) {
        RegisterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s20),
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
                      text: AppStrings.register.tr(),
                      style: Theme.of(context).textTheme.headlineLarge,
                      alignment: Alignment.centerLeft,
                    ),
                    DefaultTextFormField(
                      // validate: (String? value) {
                      //   return GlobalMethods.validate(
                      //       AppStrings.validateName, value);
                      // },
                      controller: cubit.nameController,
                      hint: AppStrings.nameLabel.tr(),
                    ),
                    DefaultTextFormField(
                      // validate: (String? value) {
                      //   return GlobalMethods.validate(
                      //       AppStrings.validatePhone, value);
                      // },
                      textType: TextInputType.phone,
                      controller: cubit.phoneController,
                      hint: AppStrings.phoneLabel.tr(),
                    ),
                    DefaultTextFormField(
                      // validate: (String? value) {
                      //   return GlobalMethods.validate(
                      //       AppStrings.validateEmail, value);
                      // },
                      textType: TextInputType.emailAddress,
                      isSecure: false,
                      controller: cubit.emailController,
                      hint: AppStrings.emailLabel.tr(),
                    ),
                    DefaultTextFormField(
                        // validate: (String? value) {
                        //   if (value!.isEmpty) {
                        //     return AppStrings.validatePassword.tr();
                        //   }
                        //   return AppStrings.validatePassword.tr();
                        // },
                        hint: AppStrings.passwordLabel.tr(),
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
                    Visibility(
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      visible: state is! RegisterLoadingState,
                      child: DefaultButton(
                          context: context,
                          text: AppStrings.register.tr(),
                          function: () {
                            cubit.userRegister(context,
                                email: cubit.emailController.text,
                                name: cubit.nameController.text,
                                phone: cubit.phoneController.text,
                                password: cubit.passController.text);
                          }),
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
                        const SizedBox(
                          width: AppSize.s10,
                        ),
                        GestureDetector(
                          onTap: () {
                            GlobalMethods.navigateAndFinish(
                                context, const LoginScreen());
                          },
                          child: DefaultCustomText(
                            text: AppStrings.login.tr(),
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

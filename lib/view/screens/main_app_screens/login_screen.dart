import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/app_constance/values_manager.dart';
import 'package:shop_app/view/screens/main_app_screens/register_screen.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import 'package:shop_app/view/widgets/elevated_button_widget.dart';
import '../../../generated/assets.dart';
import '../../../view_model/login_cubit/login_app_states.dart';
import '../../../view_model/login_cubit/login_cubit.dart';
import '../../widgets/default_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hSize = AppDimensions.screenHeight(context);
    return BlocBuilder<LoginCubit, LoginAppStates>(
      builder: (context, state) {
        LoginCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.s14),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage(
                        Assets.imagesLogin,
                      ),
                      fit: BoxFit.cover,
                    ),
                    DefaultCustomText(
                      alignment: Alignment.centerLeft,
                      text: AppStrings.welcome,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    DefaultCustomText(
                      text: AppStrings.loginMessage,
                      alignment: Alignment.centerLeft,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    DefaultTextFormField(
                      // validate: (String? value) {
                      //   return GlobalMethods.validate(
                      //       AppStrings.validateEmail, value);
                      // },
                      textType: TextInputType.emailAddress,
                      controller: cubit.emailController,
                      hint: AppStrings.emailLHint,
                    ),
                    DefaultTextFormField(
                        // validate: (String? value) {
                        //   return GlobalMethods.validate(
                        //       AppStrings.validatePassword, value);
                        // },
                        onSubmitted: () {
                          cubit.userLogin(
                              context: context,
                              email: cubit.emailController.text,
                              password: cubit.passwordController.text);
                        },
                        isSecure: cubit.isVisible,
                        controller: cubit.passwordController,
                        suffixIcon: cubit.isVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        hint: AppStrings.passwordLabel,
                        suffixFunction: () {
                          cubit.changePassVisibility();
                        }),
                    SizedBox(
                      height: hSize * 0.02,
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      child: state is! LoginLoadingState
                          ? DefaultButton(
                              context: context,
                              text: AppStrings.login,
                              function: () {
                                cubit.userLogin(
                                    context: context,
                                    email: cubit.emailController.text,
                                    password: cubit.passwordController.text);
                                cubit.emailController.clear();
                                cubit.passwordController.clear();
                              })
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    SizedBox(
                      height: hSize * 0.04,
                    ),
                    Row(
                      children: [
                        DefaultCustomText(
                          text: AppStrings.donHaveEmail,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        SizedBox(
                          width: AppSize.s10,
                        ),
                        GestureDetector(
                          onTap: () {
                            GlobalMethods.navigateAndFinish(
                                context, const RegisterScreen());
                          },
                          child: const DefaultCustomText(
                            text: AppStrings.register,
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

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/app_constance/values_manager.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import 'package:shop_app/view/widgets/elevated_button_widget.dart';
import '../../../generated/assets.dart';
import '../../../view_model/login_cubit/login_app_states.dart';
import '../../../view_model/login_cubit/login_cubit.dart';
import '../../widgets/default_text_form_field.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double hSize = AppDimensions.screenHeight(context);
    return BlocBuilder<LoginCubit, LoginAppStates>(
      builder: (context, state) {
        LoginCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSize.s14),
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
                      text: AppStrings.welcome.tr(),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    DefaultCustomText(
                      text: AppStrings.loginMessage.tr(),
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
                      hint: AppStrings.emailLabel.tr(),
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
                        hint: AppStrings.passwordLabel.tr(),
                        suffixFunction: () {
                          cubit.changePassVisibility();
                        }),
                    SizedBox(
                      height: hSize * 0.02,
                    ),
                    Visibility(
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      visible: state is! LoginLoadingState,
                      child: DefaultButton(
                          context: context,
                          text: AppStrings.login.tr(),
                          function: () {
                            cubit.userLogin(
                                context: context,
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text);
                          }),
                    ),
                    SizedBox(
                      height: hSize * 0.04,
                    ),
                    Row(
                      children: [
                        DefaultCustomText(
                          text: AppStrings.donHaveEmail.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        const SizedBox(
                          width: AppSize.s10,
                        ),
                        GestureDetector(
                          onTap: () {
                            GlobalMethods.navigateAndFinish(
                                context, const RegisterScreen());
                          },
                          child: DefaultCustomText(
                            text: AppStrings.register.tr(),
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

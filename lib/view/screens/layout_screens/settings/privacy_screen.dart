import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/strings_manager.dart';
import 'package:shop_app/view/widgets/default_text_form_field.dart';
import 'package:shop_app/view/widgets/elevated_button_widget.dart';
import '../../../../view_model/app_cubit/app_cubit.dart';
import '../../../../view_model/app_cubit/app_states.dart';

class PrivacyScreen extends StatelessWidget {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double hSize = MediaQuery.of(context).size.height;
    double wSize = MediaQuery.of(context).size.width;

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopUpdateUserinfoSuccessState) {
          GlobalMethods.showToast(
              context, 'تم تحديث البيانات بنجاح', Colors.green);
        }
      },
      builder: (context, state) {
        ShopCubit cubit = BlocProvider.of(context);
        return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  AppStrings.update.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            body: BlocConsumer<ShopCubit, ShopStates>(
              listener: (context, state) {},
              builder: (context, state) {
                var model = cubit.userInfo!;
                return ConditionalBuilder(
                  condition: cubit.userInfo != null,
                  builder: (BuildContext context) => SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            if (state is ShopUpdateUserinfoLoadingState)
                              const LinearProgressIndicator(),
                            SizedBox(
                              height: hSize * 0.03,
                            ),
                            DefaultTextFormField(
                                controller: nameController,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    nameController.text = model.data!.name!;
                                  }
                                  return '';
                                },
                                hint: AppStrings.nameLabel.tr()),
                            DefaultTextFormField(
                                textType: TextInputType.phone,
                                controller: phoneController,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    phoneController.text = model.data!.phone!;
                                  }
                                  return '';
                                },
                                hint: AppStrings.phoneLabel.tr()),
                            DefaultTextFormField(
                              textType: TextInputType.emailAddress,
                              controller: emailController,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  emailController.text = model.data!.email!;
                                }
                                return '';
                              },
                              hint: AppStrings.emailLabel.tr(),
                            ),
                            SizedBox(
                              height: hSize * 0.04,
                            ),
                            DefaultButton(
                                context: context,
                                width: wSize * 0.4,
                                text: AppStrings.update.tr(),
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit.updateUserdata(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      email: emailController.text,
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  fallback: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ));
      },
    );
  }
}

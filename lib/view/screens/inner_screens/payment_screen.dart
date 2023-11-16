import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/app_constance/values_manager.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import 'package:shop_app/view/widgets/default_text_form_field.dart';
import 'package:shop_app/view/widgets/elevated_button_widget.dart';
import 'package:shop_app/view_model/payment_cubit/payment_cubit.dart';
import 'package:shop_app/view_model/payment_cubit/payment_state.dart';
import '../../../app_constance/strings_manager.dart';
import '../../widgets/switch_button.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key, required this.amount});

  final int amount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        PaymentCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Payment Screen'),
          ),
          body: Padding(
            padding: EdgeInsets.all(AppSize.s12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DefaultTextFormField(
                    controller: cubit.firstNameController,
                    hint: 'Your First Name',
                    validate: (String? value) {
                      return GlobalMethods.validate(
                          AppStrings.nameLabel, value);
                    },
                  ),
                  DefaultTextFormField(
                    controller: cubit.lastNameController,
                    hint: 'Your Last Name',
                    validate: (String? value) {
                      return GlobalMethods.validate(
                          'Write Your Last Name', value);
                    },
                  ),
                  SizedBox(height: AppSize.s10),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {},
                    onInputValidated: (bool value) {},
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      setSelectorButtonAsPrefixIcon: true,
                      leadingPadding: AppSize.s10,
                      useEmoji: true,
                    ),
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    selectorTextStyle: Theme.of(context).textTheme.titleMedium,
                    initialValue: PhoneNumber(isoCode: 'AE'),
                    textFieldController: cubit.phoneController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10)),
                  ),
                  SizedBox(height: AppSize.s10),
                  InternationalPhoneNumberInput(
                    autoValidateMode: AutovalidateMode.disabled,
                    onInputChanged: (PhoneNumber number) {},
                    onInputValidated: (bool value) {},
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      setSelectorButtonAsPrefixIcon: true,
                      leadingPadding: AppSize.s10,
                      useEmoji: true,
                    ),
                    hintText: 'Extra Number (optional)',
                    selectorTextStyle: Theme.of(context).textTheme.titleMedium,
                    initialValue: PhoneNumber(isoCode: 'AE'),
                    textFieldController: cubit.optionalPhoneController,
                    keyboardType: const TextInputType.numberWithOptions(),
                    inputBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.s10)),
                  ),
                  SizedBox(height: AppSize.s10),
                  if (state is GetLocationLoadingState)
                    SizedBox(height: AppSize.s12),
                  AnimatedSwitcher(
                      duration: const Duration(seconds: 1),
                      child: state is! GetLocationLoadingState
                          ? DefaultTextFormField(
                              controller: cubit.locationController,
                              enabled: false,
                              hint: 'Get Your Location',
                              suffixIcon: Icons.location_on_sharp,
                              onTap: () {
                                cubit.getPosition(context);
                              },
                            )
                          : const Center(
                              child: DefaultCustomText(
                                  text: 'Wait to Collect Your Location Data'),
                            )),
                  SizedBox(height: AppSize.s40),
                  AnimatedSwitcher(
                    duration: const Duration(seconds: 1),
                    child: state is! MakePaymentLoadingState
                        ? DefaultButton(
                            text: 'Order',
                            function: () {
                              if (cubit.firstNameController.text.isEmpty ||
                                  cubit.lastNameController.text.isEmpty ||
                                  cubit.phoneController.text.isEmpty) {
                                GlobalMethods.showToast(
                                    context,
                                    'Complete All Fields Before Order',
                                    Colors.red);
                              } else if (cubit
                                  .locationController.text.isEmpty) {
                                GlobalMethods.showToast(
                                    context, 'Get Your Location', Colors.red);
                              } else {
                                cubit.makePayment(context, amount, 'Aed');
                              }
                            },
                            context: context)
                        : const DefaultCustomText(text: 'Loading...'),
                  ),
                  SizedBox(height: AppSize.s30),
                  const SwitchButtonVisaNumber(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

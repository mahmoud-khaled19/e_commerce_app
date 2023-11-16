import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app_constance/app_dimensions.dart';
import 'package:shop_app/app_constance/constants_methods.dart';
import 'package:shop_app/view/screens/main_app_screens/home_layout.dart';
import 'package:shop_app/view/widgets/default_custom_text.dart';
import 'package:shop_app/view/widgets/elevated_button_widget.dart';
import 'package:shop_app/view_model/app_cubit/app_states.dart';
import '../../../app_constance/values_manager.dart';
import '../../../view_model/app_cubit/app_cubit.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Container(
              padding: EdgeInsets.all(AppSize.s10),
              height: AppDimensions.screenHeight(context) * 0.25,
              width: AppDimensions.screenWidth(context) * 0.8,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(AppSize.s10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DefaultCustomText(
                    text: 'Successfully Payment',
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: AppSize.s14,
                  ),
                  const DefaultCustomText(
                    text: 'Your Order Deliver In 48 Hours ',
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: AppSize.s14,
                  ),
                  DefaultButton(
                      text: 'Go Back',
                      function: () {
                        AppCubit.get(context).bottomNavIndex = 0;
                        GlobalMethods.navigateAndFinish(
                            context, const HomeLayout());
                      },
                      context: context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

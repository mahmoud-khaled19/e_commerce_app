import 'package:flutter/material.dart';
import 'package:shop_app/view/screens/auth_screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../app_constance/colors_manager.dart';
import '../../app_constance/constants_methods.dart';
import '../../app_constance/fonts_manager.dart';
import '../../app_constance/strings_manager.dart';
import '../../app_constance/values_manager.dart';
import '../../view_model/on_boarding_view_model.dart';
import '../widgets/default_custom_text.dart';
import '../widgets/elevated_button_widget.dart';
import 'auth_screens/register_screen.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    OnBoardingViewModel.animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    OnBoardingViewModel.animationController.repeat();
    OnBoardingViewModel.animation = TextStyleTween(
      begin: TextStyle(color: Colors.blue, fontSize: AppSize.s16),
      end: TextStyle(
          color: ColorsManager.lightSecondColor, fontSize: AppSize.s16),
    ).animate(CurvedAnimation(
        parent: OnBoardingViewModel.animationController, curve: Curves.easeIn));
    super.initState();
    OnBoardingViewModel.animationButton = CurvedAnimation(
        parent: OnBoardingViewModel.animationController, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    OnBoardingViewModel.animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double hSize = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSize.s14),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    GlobalMethods.navigateTo(context, const LoginScreen());
                  },
                  child: ScaleTransition(
                    scale: OnBoardingViewModel.animationController,
                    child: DefaultCustomText(
                      color: ColorsManager.grey,
                      alignment: Alignment.centerRight,
                      text: AppStrings.skip,
                      fontWeight: FontWeightManager.bold,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.s20),
                SizedBox(
                  height: hSize * 0.65,
                  child: PageView.builder(
                    controller: OnBoardingViewModel.boardingController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image(
                            image: AssetImage(
                              OnBoardingViewModel.boardingList[index].image,
                            ),
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: AppSize.s30,
                          ),
                          DefaultCustomText(
                            text: OnBoardingViewModel.boardingList[index].title,
                            fontSize: AppSize.s20,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: AppSize.s8,
                          ),
                          DefaultCustomText(
                            text: OnBoardingViewModel.boardingList[index].body1,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          SizedBox(
                            height: AppSize.s8,
                          ),
                          DefaultCustomText(
                            text: OnBoardingViewModel.boardingList[index].body2,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      );
                    },
                    onPageChanged: (value) {
                      if (value ==
                          OnBoardingViewModel.boardingList.length - 1) {
                        setState(() {
                          OnBoardingViewModel.isLast = true;
                        });
                      } else {
                        setState(() {
                          OnBoardingViewModel.isLast = false;
                        });
                      }
                    },
                    itemCount: OnBoardingViewModel.boardingList.length,
                  ),
                ),
                SizedBox(
                  height: AppSize.s8,
                ),
                SmoothPageIndicator(
                  controller: OnBoardingViewModel.boardingController,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                    spacing: 8.0,
                    radius: 4.0,
                    dotWidth: 20.0,
                    dotHeight: 10.0,
                    paintStyle: PaintingStyle.fill,
                    strokeWidth: 8,
                    dotColor: Colors.grey,
                    activeDotColor: ColorsManager.lightSecondColor,
                  ),
                ),
                SizedBox(
                  height: AppSize.s50,
                ),
                if (OnBoardingViewModel.isLast == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DefaultButton(
                          text: AppStrings.register,
                          function: () {
                            GlobalMethods.navigateTo(
                                context, const RegisterScreen());
                          },
                          context: context),
                      DefaultButton(
                          text: AppStrings.login,
                          function: () {
                            GlobalMethods.navigateTo(
                                context, const LoginScreen());
                          },
                          context: context),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

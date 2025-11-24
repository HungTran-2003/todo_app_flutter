import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/onboarding_navigator.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/onboarding_provider.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/widgets/page_indicator/page_indicator.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/ui/widgets/button/app_text_button.dart';

class OnboardingPage extends StatefulWidget {
  final OnboardingNavigator navigator;
  const OnboardingPage({super.key, required this.navigator});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final provider = OnboardingProvider();

  @override
  void initState() {
    super.initState();
  }

  final pageController = PageController();
  int _currentPage = 0;
  bool isAppStart = false;

  final assetsImages = AppImages.onBoardImages;
  final titles = [
    "Manage your tasks",
    "Create daily routine",
    "Organize your tasks",
  ];
  final descriptions = [
    "You can easily manage all of your daily tasks in Todo for free",
    "In Todo you can create your personalized routine to stay productive",
    "You can organize your daily tasks by adding your tasks into separate categories",
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingProvider>.value(
      value: provider,
      child: Builder(
        builder: (context) {
          return Scaffold(body: SafeArea(child: _buildBodyPage()));
        },
      ),
    );
  }

  Widget _buildBodyPage() {
    if (isAppStart) {
      return _buildBodyAppStart();
    }
    return _buildBodyPageView();
  }

  Widget _buildBodyPageView() {
    return Column(
      children: [
        Row(
          children: [
            AppTextButton(
              label: "SKIP",
              onPressed: () => setState(() {
                isAppStart = true;
              }),
              textStyle: AppTextStyles.bMediumSemiBold,
            ),
          ],
        ),
        Expanded(
          child: Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                children: List.generate(
                  assetsImages.length,
                  (index) => _buildOnboardingPage(index),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                top: 296 + 50,
                child: Center(
                  child: SimplePageIndicator(
                    pageCount: assetsImages.length,
                    currentPage: _currentPage,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBodyAppStart() {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isAppStart = false;
                  _currentPage = 0;
                });
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 24,
              ),
            ),
          ],
        ),

        Image.asset(AppImages.splashScreen),

        Text("Welcome to Todo", style: AppTextStyles.bMaxLargeSemiBold),
        const SizedBox(height: 26.0),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            "Login, create a new account, or skip signing in and continue enjoying the app.",
            style: AppTextStyles.bMediumMedium,
            textAlign: TextAlign.center,
          ),
        ),

        const Spacer(),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              AppButton(
                label: "Login",
                height: AppDimens.btNormal,
                onPressed: () {
                  provider.setIsFirstRun();
                  widget.navigator.openLoginPage();
                },
              ),
              SizedBox(height: 10),
              AppTextButton(
                label: "Create Account ",
                borderColor: AppColors.primary,
                width: double.infinity,
                onPressed: () {
                  widget.navigator.openSignUpPage();
                },
              ),

              AppTextButton(
                label: "Login as guest",
                onPressed: () {
                  widget.navigator.openHomePage();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOnboardingPage(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(assetsImages[index], height: 296),
        SizedBox(height: 96),
        Text(titles[index], style: AppTextStyles.bMaxLargeSemiBold),
        SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 38),
          child: Text(
            descriptions[index],
            style: AppTextStyles.bMediumMedium,
            textAlign: TextAlign.center,
          ),
        ),

        const Spacer(),

        _buildButtonOnBoard(index),
      ],
    );
  }

  Widget _buildButtonOnBoard(int index) {
    const horizontalPaddingFirstLast = EdgeInsets.symmetric(horizontal: 50);
    const horizontalPaddingMiddle = EdgeInsets.symmetric(horizontal: 25);

    void goNext() => pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    void goPrevious() => pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    if (index == 0) {
      return Padding(
        padding: horizontalPaddingFirstLast,
        child: AppButton(
          label: "NEXT",
          height: AppDimens.btNormal,
          onPressed: goNext,
        ),
      );
    }

    if (index == assetsImages.length - 1) {
      return Padding(
        padding: horizontalPaddingFirstLast,
        child: AppButton(
          label: "GET STARTED",
          height: AppDimens.btNormal,
          onPressed: () => setState(() {
            isAppStart = true;
          }),
        ),
      );
    }

    return Padding(
      padding: horizontalPaddingMiddle,
      child: Row(
        children: [
          AppTextButton(label: "BACK", onPressed: goPrevious),
          const Spacer(),
          AppButton(
            label: "NEXT",
            width: 90,
            height: AppDimens.btNormal,
            onPressed: goNext,
          ),
        ],
      ),
    );
  }
}

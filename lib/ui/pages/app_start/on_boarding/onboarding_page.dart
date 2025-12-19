import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/onboarding_navigator.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/onboarding_provider.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/widgets/page_indicator/page_indicator.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/ui/widgets/button/app_text_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return OnboardingProvider(
          navigator: OnboardingNavigator(context: context),
          authRepository: context.read<AuthRepository>(),
        );
      },
      child: OnboardingChildPage(),
    );
  }
}

class OnboardingChildPage extends StatefulWidget {
  const OnboardingChildPage({super.key});

  @override
  State<OnboardingChildPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingChildPage> {
  late OnboardingProvider provider;

  final pageController = PageController();
  int _currentPage = 0;
  bool isAppStart = false;

  final assetsImages = AppImages.onBoardImages;
  final titles = [
    S.current.title_onboard_1,
    S.current.title_onboard_2,
    S.current.title_onboard_3,
  ];
  final descriptions = [
    S.current.description_onboard_1,
    S.current.description_onboard_2,
    S.current.description_onboard_3,
  ];

  @override
  void initState() {
    super.initState();
    provider = context.read<OnboardingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Scaffold(body: SafeArea(child: _buildBodyPage()));
      },
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
              label: S.of(context).button_skip,
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
                top: 346,
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
    return LoaderOverlay(
      child: Column(
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

          Text(
            S.of(context).title_app_start,
            style: AppTextStyles.bMaxLargeSemiBold,
          ),
          const SizedBox(height: 26.0),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              S.of(context).description_app_start,
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
                  label: S.of(context).button_login,
                  height: AppDimens.btNormal,
                  onPressed: () {
                    provider.nextPage(0);
                  },
                ),
                SizedBox(height: 10),
                AppTextButton(
                  label: S.of(context).text_button_create_account,
                  borderColor: AppColors.primary,
                  width: double.infinity,
                  onPressed: () {
                    provider.nextPage(1);
                  },
                ),

                AppTextButton(
                  label: S.of(context).text_button_login_as_guest,
                  onPressed: () {
                    provider.nextPage(2);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
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
          label: S.of(context).button_next,
          height: AppDimens.btNormal,
          onPressed: goNext,
        ),
      );
    }

    if (index == assetsImages.length - 1) {
      return Padding(
        padding: horizontalPaddingFirstLast,
        child: AppButton(
          label: S.of(context).button_get_started,
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
          AppTextButton(
            label: S.of(context).button_back,
            onPressed: goPrevious,
          ),
          const Spacer(),
          AppButton(
            label: S.of(context).button_next,
            width: 90,
            height: AppDimens.btNormal,
            onPressed: goNext,
          ),
        ],
      ),
    );
  }
}

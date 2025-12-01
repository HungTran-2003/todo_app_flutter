import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_svgs.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/ui/pages/setting/setting_navigator.dart';
import 'package:todo_app/ui/pages/setting/setting_provider.dart';
import 'package:todo_app/ui/pages/setting/widgets/item_setting.dart';
import 'package:todo_app/ui/widgets/app_bar/app_bar_widget.dart';

class SettingViewArguments {
  final int completedTodos;
  final int inCompleteTodos;

  SettingViewArguments({
    required this.completedTodos,
    required this.inCompleteTodos,
  });
}

class SettingPage extends StatelessWidget {
  final SettingViewArguments arguments;
  const SettingPage({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SettingProvider(
          navigator: SettingNavigator(context: context),
          authRepository: context.read<AuthRepository>(),
        );
      },
      child: SettingChildPage(
        completedTodos: arguments.completedTodos,
        inCompleteTodos: arguments.inCompleteTodos,
      ),
    );
  }
}

class SettingChildPage extends StatefulWidget {
  final int completedTodos;
  final int inCompleteTodos;
  const SettingChildPage({
    super.key,
    required this.completedTodos,
    required this.inCompleteTodos,
  });

  @override
  State<SettingChildPage> createState() => _SettingChildPageState();
}

class _SettingChildPageState extends State<SettingChildPage> {
  late SettingProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = context.read<SettingProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Setting",
        imageBackground: AppImages.header2,
        onPressed: () {
          _provider.navigator.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: AppDimens.marginNormal,
          left: AppDimens.paddingNormal,
          right: AppDimens.paddingNormal,
          bottom: AppDimens.paddingNormal,
        ),
        child: _buildBodyPage(),
      ),
    );
  }

  Widget _buildBodyPage() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          _buildProfile(),
          const SizedBox(height: 32.0),
          _buildSettingApp(),
          const SizedBox(height: 16.0),
          _buildSettingAccount(),
          const SizedBox(height: 16.0),
          _buildSettingOther(),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        Text("Profile", style: AppTextStyles.bMaxLargeSemiBold),
        const SizedBox(height: 24),
        CircleAvatar(
          radius: 50,
          backgroundImage: const AssetImage(AppImages.defaultProfile),
        ),
        const SizedBox(height: 10),
        Text("No Name", style: AppTextStyles.bMediumSemiBold),
        const SizedBox(height: 24.0),
        Row(
          spacing: 20,
          children: [
            Expanded(
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text(
                    "${widget.inCompleteTodos} Task left",
                    style: AppTextStyles.wMediumMedium,
                  ),
                ),
              ),
            ),

            Expanded(
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Center(
                  child: Text(
                    "${widget.completedTodos} Task done",
                    style: AppTextStyles.wMediumMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingApp() {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Settings", style: AppTextStyles.bMedium),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconSetting,
          title: "App Settings",
          onPressed: () {
            log("Setting");
          },
        ),
      ],
    );
  }

  Widget _buildSettingAccount() {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Account", style: AppTextStyles.bMedium),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconUser,
          title: "Change account name",
          onPressed: () {
            log("Change account name");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconKey,
          title: "Change account password",
          onPressed: () {
            log("Change account password");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconCamera,
          title: "Change account Image",
          onPressed: () {
            log("Change account Image");
          },
        ),
      ],
    );
  }

  Widget _buildSettingOther() {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Todo", style: AppTextStyles.bMedium),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconMenu,
          title: "About US",
          onPressed: () {
            log("About US");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconCircle,
          title: "FAQ",
          onPressed: () {
            log("FAQ");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconFlash,
          title: "Help & Feedback",
          onPressed: () {
            log("Help & Feedback");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconLike,
          title: "Support US",
          onPressed: () {
            log("Support US");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconLogout,
          title: "Log out",
          color: Colors.red,
          onPressed: () {
            _provider.logout();
          },
        ),
      ],
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_svgs.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/models/enum/language.dart';
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
  late TodoProvider _todoProvider;


  @override
  void initState() {
    super.initState();
    _provider = context.read<SettingProvider>();
    _todoProvider = context.read<TodoProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.select<TodoProvider, Locale>((p) => p.locale);
    return Scaffold(
      appBar: AppBarWidget(
        title: S.of(context).setting_title,
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
        child: _buildBodyPage(locale),
      ),
    );
  }

  Widget _buildBodyPage(Locale locale) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children: [
          _buildProfile(),
          const SizedBox(height: 32.0),
          _buildSettingApp(locale),
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
        Text(S.of(context).setting_title_profile, style: AppTextStyles.bMaxLargeSemiBold),
        const SizedBox(height: 24),
        CircleAvatar(
          radius: 50,
          backgroundImage: const AssetImage(AppImages.defaultProfile),
        ),
        const SizedBox(height: 10),
        Text(S.of(context).setting_user_name_default, style: AppTextStyles.bMediumSemiBold),
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
                    S.of(context).setting_count_task_left(widget.inCompleteTodos),
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
                    S.of(context).setting_count_task_done(widget.completedTodos),
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

  Widget _buildSettingApp(Locale locale) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).setting_menu_settings, style: AppTextStyles.bMedium),

        ItemSettingWidget(
          assetIcon: locale == Language.english.local? AppSvgs.iconFlagEnglish : AppSvgs.iconFlagVietNam,
          title: S.of(context).setting_menu_settings_1,
          onPressed: () {
            _todoProvider.changeLocale();
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
        Text(S.of(context).setting_menu_account, style: AppTextStyles.bMedium),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconUser,
          title: S.of(context).setting_menu_account_1,
          onPressed: () {
            log("Change account name");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconKey,
          title: S.of(context).setting_menu_account_2,
          onPressed: () {
            log("Change account password");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconCamera,
          title: S.of(context).setting_menu_account_3,
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
        Text(S.of(context).setting_menu_other, style: AppTextStyles.bMedium),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconMenu,
          title: S.of(context).setting_menu_other_1,
          onPressed: () {
            log("About US");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconCircle,
          title: S.of(context).setting_menu_other_2,
          onPressed: () {
            log("FAQ");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconFlash,
          title: S.of(context).setting_menu_other_3,
          onPressed: () {
            log("Help & Feedback");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconLike,
          title: S.of(context).setting_menu_other_4,
          onPressed: () {
            log("Support US");
          },
        ),

        ItemSettingWidget(
          assetIcon: AppSvgs.iconLogout,
          title: S.of(context).setting_menu_logout,
          color: Colors.red,
          onPressed: () {
            _provider.logout();
          },
        ),
      ],
    );
  }
}

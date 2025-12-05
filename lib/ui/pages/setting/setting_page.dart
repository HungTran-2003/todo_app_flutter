import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:loader_overlay/loader_overlay.dart';
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
import 'package:todo_app/repositories/notification_repository.dart';
import 'package:todo_app/repositories/user_repository.dart';
import 'package:todo_app/ui/pages/setting/setting_navigator.dart';
import 'package:todo_app/ui/pages/setting/setting_provider.dart';
import 'package:todo_app/ui/pages/setting/widgets/avatar_image_cache.dart';
import 'package:todo_app/ui/pages/setting/widgets/item_setting.dart';
import 'package:todo_app/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/ui/widgets/text_field/app_text_field.dart';

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
          notificationRepository: context.read<NotificationRepository>(),
          userRepository: context.read<UserRepository>(),
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
    _setup();
  }

  void _setup() async {
    await _provider.fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
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
        child: LoaderOverlay(child: _buildBodyPage()),
      ),
    );
  }

  Widget _buildBodyPage() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        children:
            [
                  _buildProfile(),
                  const SizedBox(height: 32.0),
                  _buildSettingApp(),
                  const SizedBox(height: 16.0),
                  _buildSettingAccount(),
                  const SizedBox(height: 16.0),
                  _buildSettingOther(),
                ]
                .animate(interval: 50.ms)
                .fade(duration: 250.ms)
                .slideX(begin: 0.5, end: 0),
      ),
    );
  }

  Widget _buildProfile() {
    return Column(
      children: [
        Selector<SettingProvider, String>(
          builder: (context, avatarUrl, child) {
            return AvatarImageCache(url: avatarUrl);
          },
          selector: (context, provider) => provider.userInfo?.avatarUrl ?? "",
        ),
        const SizedBox(height: 10),
        Selector<SettingProvider, String>(
          builder: (context, userName, child) {
            return Text(
              userName.isEmpty
                  ? S.of(context).setting_user_name_default
                  : userName,
              style: AppTextStyles.bMediumSemiBold,
            );
          },
          selector: (context, provider) => provider.userInfo?.userName ?? "",
        ),
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
                    S
                        .of(context)
                        .setting_count_task_left(widget.inCompleteTodos),
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
                    S
                        .of(context)
                        .setting_count_task_done(widget.completedTodos),
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
        Text(S.of(context).setting_menu_settings, style: AppTextStyles.bMedium),

        Selector<TodoProvider, Locale>(
          selector: (context, provider) => provider.locale,
          builder: (context, locale, child) {
            return ItemSettingWidget(
              assetIcon: locale == Language.english.local
                  ? AppSvgs.iconFlagEnglish
                  : AppSvgs.iconFlagVietNam,
              title: S.of(context).setting_menu_settings_1,
              onPressed: () {
                _todoProvider.changeLocale();
              },
            );
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
          onPressed: () async {
            final result = await showPopupInput(context);
            if (result != null) {
              _provider.changeUserName(result);
            }
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
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return SizedBox(
                  height: 200,
                  child: Column(
                    spacing: 8,
                    children: [
                      Text("Chon ", style: AppTextStyles.bMediumMedium),

                      ListTile(
                        leading: const Icon(Icons.photo_camera_outlined),
                        title: const Text("Chụp ảnh"),
                        onTap: () async {
                          Navigator.pop(context);
                          await _provider.changeImage(1);
                        },
                      ),

                      ListTile(
                        leading: const Icon(Icons.photo_library_outlined),
                        title: const Text("Chọn từ thư viện"),
                        onTap: () async {
                          Navigator.pop(context);
                          await _provider.changeImage(2);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
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

  Future<String?> showPopupInput(BuildContext context) async {
    final textController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return await showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.paddingNormal),
            child: Form(
              key: formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppDimens.marginLarge,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16.0,
                  children: [
                    Text(
                      S.of(context).dialog_title_change_name,
                      style: AppTextStyles.bMediumMedium,
                    ),
                    AppTextField(
                      controller: textController,
                      title: S.of(context).dialog_title_input_change_name,
                      hint: S.of(context).dialog_title_input_hint,
                    ),
                    AppButton(label: S.of(context).dialog_confirm, onPressed: (){
                      Navigator.pop(context, textController.text);
                    },)
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

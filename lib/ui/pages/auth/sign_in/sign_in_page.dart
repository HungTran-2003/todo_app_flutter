import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/pages/auth/sign_in/sign_in_navigator.dart';
import 'package:todo_app/ui/pages/auth/sign_in/sign_in_provider.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/ui/widgets/decoration/app_shape_decoration.dart';
import 'package:todo_app/ui/widgets/text_field/app_password_text_field.dart';
import 'package:todo_app/ui/widgets/text_field/app_text_field.dart';
import 'package:todo_app/utils/app_validator.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SignInProvider(
          navigator: SignInNavigator(context: context),
          authRepository: context.read<AuthRepository>(),
          todoRepository: context.read<TodoRepository>(),
        );
      },
      child: SignInChildPage(),
    );
  }
}

class SignInChildPage extends StatefulWidget {
  const SignInChildPage({super.key});

  @override
  State<SignInChildPage> createState() => _SignInChildPageState();
}

class _SignInChildPageState extends State<SignInChildPage> {
  late SignInProvider _provider;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _provider = context.read<SignInProvider>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LoaderOverlay(
        child: Stack(
          children: [
            ..._buildDeco(screenHeight, screenWidth),

            Container(
              padding: const EdgeInsets.only(top: 97, left: 31, right: 31),
              height: screenHeight,
              width: screenWidth,
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        spacing: 26,
                        children: [
                          Text(
                            S.of(context).sign_in_title,
                            style: AppTextStyles.bMaxLargeSemiBold,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 67.0,
                            ),
                            child: Text(
                              S.of(context).sign_in_description,
                              style: AppTextStyles.bMediumMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40.0),
                      // Text Field
                      AppTextField(
                        controller: _emailController,
                        title: S.of(context).sign_in_email,
                        hint: S.of(context).sign_in_email_hint,
                        validator: (value) {
                          return AppValidator.validateEmail(value);
                        },
                      ),
                      const SizedBox(height: 16.0),
                      AppPasswordTextField(
                        controller: _passwordController,
                        title: S.of(context).sign_in_password,
                        hint: S.of(context).sign_in_password_hint,
                        validator: (value) {
                          return AppValidator.validatePassword(value);
                        },
                      ),
                      const SizedBox(height: 8.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            log("Forgot Password");
                          },
                          child: Text(
                            S.of(context).sign_in_forgot_password,
                            style: AppTextStyles.bMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                label: S.of(context).sign_in,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    _provider.signIn(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          formKey.currentState?.reset();
                          _provider.navigator.openSignUp();
                        },
                        child: Text(
                          S.of(context).sign_in_create_account,
                          style: AppTextStyles.bMediumMedium,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(S.of(context).sign_in_or_continue_with, style: AppTextStyles.bMedium),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDeco(double screenHeight, double screenWidth) {
    return <Widget>[
      Positioned(
        top: -screenHeight * 0.4,
        right: -screenWidth * 0.8,
        child: AppShapeDecoration(
          size: screenHeight * 0.7,
          shape: BoxShape.circle,
        ),
      ),

      Positioned(
        top: -screenHeight * 0.15,
        right: -screenWidth * 0.14,
        child: AppShapeDecoration(
          size: screenHeight * 0.5,
          shape: BoxShape.circle,
          color: Colors.transparent,
          boxBorder: Border.all(color: AppColors.btBGLightBlue, width: 3.0),
        ),
      ),

      Positioned(
        top: screenHeight * 0.7,
        right: screenWidth * 0.8,
        child: AppShapeDecoration(
          size: screenHeight * 0.4,
          color: Colors.transparent,
          boxBorder: Border.all(color: AppColors.btBGLightBlue, width: 2.0),
        ),
      ),

      Positioned(
        top: screenHeight * 0.7,
        right: screenWidth * 0.8,
        child: Transform.rotate(
          angle: 0.3,
          child: AppShapeDecoration(
            size: screenHeight * 0.4,
            color: Colors.transparent,
            boxBorder: Border.all(color: AppColors.btBGLightBlue, width: 2.0),
          ),
        ),
      ),
    ];
  }
}

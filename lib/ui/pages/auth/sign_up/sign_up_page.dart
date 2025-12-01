import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_colors.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/repositories/auth_repository.dart';
import 'package:todo_app/ui/pages/auth/sign_up/sign_up_navigator.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/ui/widgets/decoration/app_shape_decoration.dart';
import 'package:todo_app/ui/widgets/text_field/app_password_text_field.dart';
import 'package:todo_app/ui/widgets/text_field/app_text_field.dart';
import 'package:todo_app/utils/app_validartor.dart';

import 'sign_up_provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SignUpProvider(
          navigator: SignUpNavigator(context: context),
          authRepository: context.read<AuthRepository>(),
        );
      },
      child: SignupChildPage(),
    );
  }
}

class SignupChildPage extends StatefulWidget {
  const SignupChildPage({super.key});

  @override
  State<SignupChildPage> createState() => _SignupChildPageState();
}

class _SignupChildPageState extends State<SignupChildPage> {
  late SignUpProvider _provider;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _provider = context.read<SignUpProvider>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                            "Create New Account",
                            style: AppTextStyles.bMaxLargeSemiBold,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Text(
                              "Create an account so you can explore all the existing jobs",
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
                        title: "Email",
                        hint: "Email",
                        validator: (value) {
                          return AppValidator.validateEmail(value);
                        },
                      ),
                      const SizedBox(height: 16.0),
                      AppPasswordTextField(
                        controller: _passwordController,
                        title: "Password",
                        hint: "Password",
                        validator: (value) {
                          return AppValidator.validatePassword(value);
                        },
                      ),
                      const SizedBox(height: 16.0),
                      AppPasswordTextField(
                        controller: _confirmPasswordController,
                        title: "Confirm password",
                        hint: "Confirm password",
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Password does not match";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24.0),
                      SizedBox(
                        height: 60,
                        child: Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                label: 'Sign Up',
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    _provider.signUp(
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
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          _provider.navigator.openSignIn();
                        },
                        child: Text(
                          "Already have an account",
                          style: AppTextStyles.bMediumMedium,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text("Or continue with", style: AppTextStyles.bMedium),
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

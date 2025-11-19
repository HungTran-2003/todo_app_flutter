import 'package:flutter/material.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/ui/pages/app_start/on_boarding/widgets/page_indicator/page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final assetsImages = AppImages.onBoardImages;
  final titles = ["Manage your tasks","Create daily routine","Orgonaize your tasks"];
  final descriptions = [
    "You can easily manage all of your daily tasks in Todo for free",
    "In Todo you can create your personalized routine to stay productive",
    "You can organize your daily tasks by adding your tasks into separate categories"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: Row(
                children: [
                  TextButton(onPressed: (){}, child: Text("SKIP", style: TextStyle(color: Colors.black), )),
                ],
              ),
            ),
            Expanded(
              child: PageView(
                children: [
                  _buildOnboardingPage(0),
                  _buildOnboardingPage(1),
                  _buildOnboardingPage(2),
                ]
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage(int index) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(assetsImages[index]),
        SizedBox(height: 52,),
      ],
    );
  }
}

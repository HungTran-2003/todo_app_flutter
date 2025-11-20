import 'package:flutter/material.dart';
import 'package:todo_app/common/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.header1),
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  Text("Helllo"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


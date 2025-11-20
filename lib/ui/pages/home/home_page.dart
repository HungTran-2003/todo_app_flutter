import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_provider.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/ui/pages/home/home_provider.dart';
import 'package:todo_app/ui/pages/home/widgets/todo_item.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/utils/app_date_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: _MyPageBody(),
    );
  }
}

class _MyPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final time = context.select<TodoProvider, DateTime>((p) => p.currentTime);

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(AppImages.header1),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      AppDateUtil.toDateString(time),
                      style: AppTextStyles.wMediumSemiBold,
                    ),
                    const SizedBox(height: 23.0),
                    Text(
                      "My Todo List",
                      style: AppTextStyles.wMaxLargeSemiBold,
                    ),
                    const SizedBox(height: 32.0),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index){
                          final bool isFirst = index == 0;
                          final bool isLast = index == 9;

                          return TodoItem(onPressed: () {
                            log("press");
                          }, checkboxPress: () {
                            log("checkbox");
                          }, first: isFirst, last: isLast,);
                        },

                        itemCount: 10,
                        physics: ClampingScrollPhysics(),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    AppButton(label: "Add New Task", onPressed: () {}),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

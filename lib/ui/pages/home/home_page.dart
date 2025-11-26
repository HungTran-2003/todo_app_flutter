import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/global_provider/app_provider.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/ui/pages/home/home_navigator.dart';
import 'package:todo_app/ui/pages/home/home_provider.dart';
import 'package:todo_app/ui/pages/home/widgets/todo_sections.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/utils/app_date_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return HomeProvider(navigator: HomeNavigator(context: context));
      },
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<StatefulWidget> createState() => _MyPageState();
}

class _MyPageState extends State<HomeChildPage> {

  late HomeProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = context.read<HomeProvider>();
  }

  List<TodoEntity> _todos = [];
  List<TodoEntity> _completedTodos = [];

  @override
  Widget build(BuildContext context) {
    final time = context.select<TodoProvider, DateTime>((p) => p.currentTime);
    _todos = context.select<TodoProvider, List<TodoEntity>>((p) => p.todos);
    _completedTodos = context.select<TodoProvider, List<TodoEntity>>(
      (p) => p.completedTodos,
    );

    return LoaderOverlay(
      child: Scaffold(
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
                      Expanded(child: _buildBodyPage()),
                      const SizedBox(height: 24.0),
                      AppButton(label: "Add New Task", onPressed: () {
                        _provider.openPageDetail();
                      }),
                      const SizedBox(height: 10.0),
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

  Widget _buildBodyPage() {
    if (_todos.isEmpty && _completedTodos.isEmpty) {
      return Center(
        child: Text(
          "Let's create a new task",
          style: AppTextStyles.bMediumSemiBold,
        ),
      );
    }
    return SlidableAutoCloseBehavior(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          TodoSections(
            todos: _todos,
            provider: _provider,
          ),
          TodoSections(
            todos: _completedTodos,
            sectionTitle: "Completed",
            provider: _provider,
          ),
        ],
      ),
    );
  }

  void clickItem() {
    log("item");
  }

  void clickCheckBox() {
    log("checkbox");
  }
}

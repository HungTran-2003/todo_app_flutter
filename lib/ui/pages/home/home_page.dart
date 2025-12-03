import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_svgs.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/repositories/notification_repository.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/pages/home/home_navigator.dart';
import 'package:todo_app/ui/pages/home/home_provider.dart';
import 'package:todo_app/ui/pages/home/widgets/todo_sections.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/ui/widgets/button/app_icon_button.dart';
import 'package:todo_app/utils/app_date_util.dart';

class HomePage extends StatelessWidget {
  final List<TodoEntity> todos;
  const HomePage({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return HomeProvider(
          navigator: HomeNavigator(context: context),
          todos: todos,
          todoRepository: context.read<TodoRepository>(),
          notificationRepository: context.read<NotificationRepository>(),
        );
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
    _setup();
  }

  List<TodoEntity> _inCompleteTodos = [];
  List<TodoEntity> _completedTodos = [];

  void _setup() {
    _provider.startMinuteTimer();
  }

  @override
  Widget build(BuildContext context) {
    final time = context.select<HomeProvider, DateTime>((p) => p.currentTime);
    _inCompleteTodos = context.select<HomeProvider, List<TodoEntity>>(
      (p) => p.inCompleteTodos,
    );
    _completedTodos = context.select<HomeProvider, List<TodoEntity>>(
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
                      _buildAppBar(time),
                      const SizedBox(height: 23.0),
                      Text(
                        S.of(context).home_title,
                        style: AppTextStyles.wMaxLargeSemiBold,
                      ),
                      const SizedBox(height: 32.0),
                      Expanded(child: _buildListItemsWidgets()),
                      const SizedBox(height: 24.0),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          margin: const EdgeInsets.all(16.0),
          child: AppButton(
            label: S.of(context).home_button_add_new_task,
            onPressed: () {
              _provider.openPageDetail();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(DateTime time) {
    return Row(
      children: [
        SizedBox(width: 38),
        Expanded(
          child: Center(
            child: Text(
              AppDateUtil.toDateString(time),
              style: AppTextStyles.wMediumSemiBold,
            ),
          ),
        ),
        AppIconButton(
          assetIcon: AppSvgs.iconSetting,
          onPressed: () {
            _provider.navigator.openSettingPage(
              completedTodos: _completedTodos.length,
              inCompleteTodos: _inCompleteTodos.length,
            );
          },
        ),
      ],
    );
  }

  Widget _buildListItemsWidgets() {
    if (_inCompleteTodos.isEmpty && _completedTodos.isEmpty) {
      return Center(
        child: Text(
          S.of(context).home_empty_list_todo,
          style: AppTextStyles.bMediumSemiBold,
        ),
      );
    }
    return SlidableAutoCloseBehavior(
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          _inCompleteTodos.isNotEmpty
              ? TodoSections(
                  todos: _inCompleteTodos,
                  onPressed: (index) {
                    _provider.openPageDetail(todo: _inCompleteTodos[index]);
                  },
                  clickCheckBox: (index) {
                    _provider.completedTodo(index);
                  },
                  delete: (value, index) {
                    _provider.deleteTodo(index, value);
                  },
                )
              : const SizedBox(height: 80.0),
          TodoSections(
            todos: _completedTodos,
            sectionTitle: S.of(context).home_completed,
            onPressed: (index) {},
            clickCheckBox: (index) {},
            delete: (value, index) {
              _provider.deleteTodo(index, value);
            },
          ),
        ],
      ),
    );
  }
}

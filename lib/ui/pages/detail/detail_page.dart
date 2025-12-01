import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_svgs.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/generated/l10n.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/ui/pages/detail/detail_navigator.dart';
import 'package:todo_app/ui/pages/detail/detail_provider.dart';
import 'package:todo_app/ui/widgets/button/app_icon_button.dart';
import 'package:todo_app/ui/widgets/app_bar/app_bar_widget.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/ui/widgets/picker/app_date_input.dart';
import 'package:todo_app/ui/widgets/text_field/app_text_field.dart';
import 'package:todo_app/utils/app_date_util.dart';
import 'package:todo_app/utils/app_validator.dart';

class DetailPage extends StatelessWidget {
  final TodoEntity? todo;
  const DetailPage({super.key, this.todo});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return DetailProvider(
          navigator: DetailNavigator(context: context),
          todo: todo,
          todoRepository: context.read<TodoRepository>(),
        );
      },
      child: DetailChildPage(),
    );
  }
}

class DetailChildPage extends StatefulWidget {
  const DetailChildPage({super.key});

  @override
  State<DetailChildPage> createState() => _DetailChildPageState();
}

class _DetailChildPageState extends State<DetailChildPage> {
  final _formKey = GlobalKey<FormState>();
  late DetailProvider _localProvider;

  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _localProvider = context.read<DetailProvider>();
    _setup();
  }

  void _setup() {
    if (_localProvider.todo != null) {
      _titleController.text = _localProvider.todo!.title;
      _dateController.text = AppDateUtil.toDatePickerString(
        _localProvider.todo!.duaDate,
      );
      _timeController.text = AppDateUtil.toTimePickerString(
        _localProvider.todo!.duaDate,
      );
      _noteController.text = _localProvider.todo!.note ?? "";
      _localProvider.setCategoryInit();
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryIndex = context.select<DetailProvider, int>(
      (p) => p.categoryIndex,
    );
    return Scaffold(
      appBar: AppBarWidget(
        title: _localProvider.todo == null ? S.of(context).detail_title_add_task : S.of(context).detail_title_detail,
        onPressed: () {
          _localProvider.navigator.pop(extra: false);
        },
        imageBackground: AppImages.header2,
      ),
      body: LoaderOverlay(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(
              left: AppDimens.marginNormal,
              right: AppDimens.marginNormal,
              top: AppDimens.marginLarge,
            ),
            child: _buildBodyPage(categoryIndex),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingNormal),
        child: AppButton(
          label: S.of(context).detail_button_save,
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              log("title: ${_titleController.text}");
              log("date: ${_dateController.text}");
              log("time: ${_timeController.text}");
              log("note: ${_noteController.text}");
              _localProvider.saveTodo(
                _titleController.text,
                _dateController.text,
                _timeController.text,
                _noteController.text,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildBodyPage(int categoryIndex) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: AppDimens.marginLarge,
          children: [
            AppTextField(
              controller: _titleController,
              title: S.of(context).detail_task_title,
              hint: S.of(context).detail_task_title_hint,
              validator: (value) {
                return AppValidator.validateEmpty(value);
              },
            ),

            Row(
              children: [
                Text(S.of(context).detail_category, style: AppTextStyles.bSmallSemiBold),
                const SizedBox(width: 24.0),
                AppIconButton(
                  assetIcon: AppSvgs.note,
                  onPressed: () {
                    _localProvider.changeCategory(1);
                  },
                  colorBorder: categoryIndex == 1 ? Colors.black : Colors.white,
                ),
                const SizedBox(width: 16.0),
                AppIconButton(
                  assetIcon: AppSvgs.calendar,
                  onPressed: () {
                    _localProvider.changeCategory(2);
                  },
                  colorBorder: categoryIndex == 2 ? Colors.black : Colors.white,
                ),
                const SizedBox(width: 16.0),
                AppIconButton(
                  assetIcon: AppSvgs.goal,
                  onPressed: () {
                    _localProvider.changeCategory(3);
                  },
                  colorBorder: categoryIndex == 3 ? Colors.black : Colors.white,
                ),
              ],
            ),
            Row(
              spacing: 8.0,
              children: [
                Expanded(
                  child: AppDateInput(
                    controller: _dateController,
                    hintText: S.of(context).detail_date,
                    title: S.of(context).detail_date_hint,
                    assetIcon: AppSvgs.iconCalendar,
                    validator: (value) {
                      String? errorText;
                      errorText = AppValidator.validateEmpty(value);
                      errorText ??= AppValidator.validateTime(
                        _dateController.text,
                        _timeController.text,
                      );
                      return errorText;
                    },
                  ),
                ),

                Expanded(
                  child: AppDateInput(
                    controller: _timeController,
                    hintText: S.of(context).detail_time,
                    title: S.of(context).detail_time_hint,
                    assetIcon: AppSvgs.iconClock,
                    isTime: true,
                    validator: (value) {
                      String? errorText;
                      errorText = AppValidator.validateEmpty(value);
                      errorText ??= AppValidator.validateTime(
                        _dateController.text,
                        _timeController.text,
                      );
                      return errorText;
                    },
                  ),
                ),
              ],
            ),

            AppTextField(
              controller: _noteController,
              title: S.of(context).detail_notes,
              hint: S.of(context).detail_notes_hint,
              maxLines: null,
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}

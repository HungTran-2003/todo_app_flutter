import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/app_dimens.dart';
import 'package:todo_app/common/app_images.dart';
import 'package:todo_app/common/app_svgs.dart';
import 'package:todo_app/common/app_text_style.dart';
import 'package:todo_app/models/entities/todo_entity.dart';
import 'package:todo_app/ui/pages/detail/detail_navigator.dart';
import 'package:todo_app/ui/pages/detail/detail_provider.dart';
import 'package:todo_app/ui/pages/detail/widgets/buttons/app_icon_button.dart';
import 'package:todo_app/ui/widgets/button/app_button.dart';
import 'package:todo_app/ui/widgets/text_field/app_text_field.dart';

class DetailPage extends StatelessWidget {
  final int? todoId;
  const DetailPage({super.key, this.todoId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return DetailProvider(navigator: DetailNavigator(context: context));
      },
      child: DetailChildPage(todoId: todoId),
    );
  }
}

class DetailChildPage extends StatefulWidget {
  final int? todoId;

  const DetailChildPage({super.key, this.todoId});

  @override
  State<DetailChildPage> createState() => _DetailChildPageState();
}

class _DetailChildPageState extends State<DetailChildPage> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            children: [Image.asset(AppImages.header2), _buildBodyPage()],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyPage() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(
          left: AppDimens.marginNormal,
          right: AppDimens.marginNormal,
          bottom: AppDimens.marginSmall,
        ),
        child: Column(
          spacing: AppDimens.marginLarge,
          children: [
            Row(
              children: [
                AppIconButton(assetIcon: AppSvgs.closeX, onPressed: () {}),
                Expanded(
                  child: Center(
                    child: Text(
                      widget.todoId == null ? 'Add New Task' : 'Detail Task',
                      style: AppTextStyles.wMediumSemiBold,
                    ),
                  ),
                ),
                SizedBox(height: AppDimens.btNormal, width: AppDimens.btNormal),
              ],
            ),

            SizedBox(
              height: 78,
              child: AppTextField(
                controller: _titleController,
                title: "Task Title",
                hint: "Task Title",
              ),
            ),

            Row(
              children: [
                Text("Category", style: AppTextStyles.bSmallSemiBold),
                const SizedBox(width: 24.0),
                AppIconButton(
                  assetIcon: AppSvgs.note,
                  onPressed: () {},
                  colorBorder: Colors.black,
                ),
                const SizedBox(width: 16.0),
                AppIconButton(
                  assetIcon: AppSvgs.calendar,
                  onPressed: () {},
                  colorBorder: Colors.white,
                ),
                const SizedBox(width: 16.0),
                AppIconButton(
                  assetIcon: AppSvgs.goal,
                  onPressed: () {},
                  colorBorder: Colors.white,
                ),
              ],
            ),

            SizedBox(
              height: 78.0,
              child: Row(
                spacing: 8.0,
                children: [
                  Expanded(
                    child: AppTextField(
                      controller: _dateController,
                      title: "Date",
                      hint: "Date",
                      enabled: false,
                    ),
                  ),

                  Expanded(
                    child: AppTextField(
                      controller: _timeController,
                      title: "Time",
                      hint: "Time",
                      enabled: false,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 200.0,
              child: AppTextField(
                controller: _titleController,
                title: "Task Title",
                hint: "Task Title",
                maxLines: null,
              ),
            ),

            const Spacer(),
            AppButton(label: "Save", onPressed: (){},)
          ],
        ),
      ),
    );
  }
}

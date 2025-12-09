// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Manage your tasks`
  String get title_onboard_1 {
    return Intl.message(
      'Manage your tasks',
      name: 'title_onboard_1',
      desc: '',
      args: [],
    );
  }

  /// `Create daily routine`
  String get title_onboard_2 {
    return Intl.message(
      'Create daily routine',
      name: 'title_onboard_2',
      desc: '',
      args: [],
    );
  }

  /// `Organize your tasks`
  String get title_onboard_3 {
    return Intl.message(
      'Organize your tasks',
      name: 'title_onboard_3',
      desc: '',
      args: [],
    );
  }

  /// `You can easily manage all of your daily tasks in Todo for free`
  String get description_onboard_1 {
    return Intl.message(
      'You can easily manage all of your daily tasks in Todo for free',
      name: 'description_onboard_1',
      desc: '',
      args: [],
    );
  }

  /// `In Todo you can create your personalized routine to stay productive`
  String get description_onboard_2 {
    return Intl.message(
      'In Todo you can create your personalized routine to stay productive',
      name: 'description_onboard_2',
      desc: '',
      args: [],
    );
  }

  /// `You can organize your daily tasks by adding your tasks into separate categories`
  String get description_onboard_3 {
    return Intl.message(
      'You can organize your daily tasks by adding your tasks into separate categories',
      name: 'description_onboard_3',
      desc: '',
      args: [],
    );
  }

  /// `NEXT`
  String get button_next {
    return Intl.message('NEXT', name: 'button_next', desc: '', args: []);
  }

  /// `SKIP`
  String get button_skip {
    return Intl.message('SKIP', name: 'button_skip', desc: '', args: []);
  }

  /// `Login`
  String get button_login {
    return Intl.message('Login', name: 'button_login', desc: '', args: []);
  }

  /// `Create Account`
  String get text_button_create_account {
    return Intl.message(
      'Create Account',
      name: 'text_button_create_account',
      desc: '',
      args: [],
    );
  }

  /// `Login as guest`
  String get text_button_login_as_guest {
    return Intl.message(
      'Login as guest',
      name: 'text_button_login_as_guest',
      desc: '',
      args: [],
    );
  }

  /// `GET STARTED`
  String get button_get_started {
    return Intl.message(
      'GET STARTED',
      name: 'button_get_started',
      desc: '',
      args: [],
    );
  }

  /// `BACK`
  String get button_back {
    return Intl.message('BACK', name: 'button_back', desc: '', args: []);
  }

  /// `Welcome to Todo`
  String get title_app_start {
    return Intl.message(
      'Welcome to Todo',
      name: 'title_app_start',
      desc: '',
      args: [],
    );
  }

  /// `Login, create a new account, or skip signing in and continue enjoying the app.`
  String get description_app_start {
    return Intl.message(
      'Login, create a new account, or skip signing in and continue enjoying the app.',
      name: 'description_app_start',
      desc: '',
      args: [],
    );
  }

  /// `Signing in`
  String get splash_message_signing_in {
    return Intl.message(
      'Signing in',
      name: 'splash_message_signing_in',
      desc: '',
      args: [],
    );
  }

  /// `Fetching data`
  String get splash_message_fetching_data {
    return Intl.message(
      'Fetching data',
      name: 'splash_message_fetching_data',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get splash_message_done {
    return Intl.message(
      'Done',
      name: 'splash_message_done',
      desc: '',
      args: [],
    );
  }

  /// `Login here`
  String get sign_in_title {
    return Intl.message(
      'Login here',
      name: 'sign_in_title',
      desc: '',
      args: [],
    );
  }

  /// `Welcome back you’ve been missed!`
  String get sign_in_description {
    return Intl.message(
      'Welcome back you’ve been missed!',
      name: 'sign_in_description',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get sign_in_email {
    return Intl.message('Email', name: 'sign_in_email', desc: '', args: []);
  }

  /// `Email`
  String get sign_in_email_hint {
    return Intl.message(
      'Email',
      name: 'sign_in_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get sign_in_password {
    return Intl.message(
      'Password',
      name: 'sign_in_password',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get sign_in_password_hint {
    return Intl.message(
      'Password',
      name: 'sign_in_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get sign_in_forgot_password {
    return Intl.message(
      'Forgot your password?',
      name: 'sign_in_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get sign_in {
    return Intl.message('Sign in', name: 'sign_in', desc: '', args: []);
  }

  /// `Create new account`
  String get sign_in_create_account {
    return Intl.message(
      'Create new account',
      name: 'sign_in_create_account',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get sign_in_or_continue_with {
    return Intl.message(
      'Or continue with',
      name: 'sign_in_or_continue_with',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get login_message_failed {
    return Intl.message(
      'Login failed',
      name: 'login_message_failed',
      desc: '',
      args: [],
    );
  }

  /// `Login success`
  String get login_message_success {
    return Intl.message(
      'Login success',
      name: 'login_message_success',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up_title {
    return Intl.message('Sign Up', name: 'sign_up_title', desc: '', args: []);
  }

  /// `Create an account so you can explore all the existing jobs`
  String get sign_up_description {
    return Intl.message(
      'Create an account so you can explore all the existing jobs',
      name: 'sign_up_description',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get sign_up_email {
    return Intl.message('Email', name: 'sign_up_email', desc: '', args: []);
  }

  /// `Email`
  String get sign_up_email_hint {
    return Intl.message(
      'Email',
      name: 'sign_up_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get sign_up_password {
    return Intl.message(
      'Password',
      name: 'sign_up_password',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get sign_up_password_hint {
    return Intl.message(
      'Password',
      name: 'sign_up_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get sign_up_confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'sign_up_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get sign_up_confirm_password_hint {
    return Intl.message(
      'Confirm password',
      name: 'sign_up_confirm_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Already have an account`
  String get sign_up_already_have_account {
    return Intl.message(
      'Already have an account',
      name: 'sign_up_already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Or continue with`
  String get sign_up_or_continue_with {
    return Intl.message(
      'Or continue with',
      name: 'sign_up_or_continue_with',
      desc: '',
      args: [],
    );
  }

  /// `Sign up failed`
  String get sign_up_message_failed {
    return Intl.message(
      'Sign up failed',
      name: 'sign_up_message_failed',
      desc: '',
      args: [],
    );
  }

  /// `Sign up successful`
  String get sign_up_message_success {
    return Intl.message(
      'Sign up successful',
      name: 'sign_up_message_success',
      desc: '',
      args: [],
    );
  }

  /// `My Todo List`
  String get home_title {
    return Intl.message('My Todo List', name: 'home_title', desc: '', args: []);
  }

  /// `Add New Task`
  String get home_button_add_new_task {
    return Intl.message(
      'Add New Task',
      name: 'home_button_add_new_task',
      desc: '',
      args: [],
    );
  }

  /// `Let's create a new task`
  String get home_empty_list_todo {
    return Intl.message(
      'Let\'s create a new task',
      name: 'home_empty_list_todo',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get home_completed {
    return Intl.message(
      'Completed',
      name: 'home_completed',
      desc: '',
      args: [],
    );
  }

  /// `Overdue`
  String get home_overdue {
    return Intl.message('Overdue', name: 'home_overdue', desc: '', args: []);
  }

  /// `Completed Task Successful`
  String get home_message_complete_task {
    return Intl.message(
      'Completed Task Successful',
      name: 'home_message_complete_task',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task Successful`
  String get home_message_delete_task {
    return Intl.message(
      'Delete Task Successful',
      name: 'home_message_delete_task',
      desc: '',
      args: [],
    );
  }

  /// `You have completed all of your tasks`
  String get home_title_empty_list_todo {
    return Intl.message(
      'You have completed all of your tasks',
      name: 'home_title_empty_list_todo',
      desc: '',
      args: [],
    );
  }

  /// `Password does not match`
  String get validator_message_confirm_password {
    return Intl.message(
      'Password does not match',
      name: 'validator_message_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get dialog_title_confirm {
    return Intl.message(
      'Confirm',
      name: 'dialog_title_confirm',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get dialog_title_delete {
    return Intl.message(
      'Delete',
      name: 'dialog_title_delete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this task?`
  String get dialog_description_delete {
    return Intl.message(
      'Are you sure you want to delete this task?',
      name: 'dialog_description_delete',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get dialog_cancel {
    return Intl.message('Cancel', name: 'dialog_cancel', desc: '', args: []);
  }

  /// `Yes`
  String get dialog_confirm {
    return Intl.message('Yes', name: 'dialog_confirm', desc: '', args: []);
  }

  /// `Change Username`
  String get dialog_title_change_name {
    return Intl.message(
      'Change Username',
      name: 'dialog_title_change_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new name`
  String get dialog_title_input_change_name {
    return Intl.message(
      'Enter a new name',
      name: 'dialog_title_input_change_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new name`
  String get dialog_title_input_hint {
    return Intl.message(
      'Enter a new name',
      name: 'dialog_title_input_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add New Task`
  String get detail_title_add_task {
    return Intl.message(
      'Add New Task',
      name: 'detail_title_add_task',
      desc: '',
      args: [],
    );
  }

  /// `Detail Task`
  String get detail_title_detail {
    return Intl.message(
      'Detail Task',
      name: 'detail_title_detail',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get detail_button_save {
    return Intl.message('Save', name: 'detail_button_save', desc: '', args: []);
  }

  /// `Task Title`
  String get detail_task_title {
    return Intl.message(
      'Task Title',
      name: 'detail_task_title',
      desc: '',
      args: [],
    );
  }

  /// `Task Title`
  String get detail_task_title_hint {
    return Intl.message(
      'Task Title',
      name: 'detail_task_title_hint',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get detail_category {
    return Intl.message(
      'Category',
      name: 'detail_category',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get detail_date {
    return Intl.message('Date', name: 'detail_date', desc: '', args: []);
  }

  /// `Date`
  String get detail_date_hint {
    return Intl.message('Date', name: 'detail_date_hint', desc: '', args: []);
  }

  /// `Time`
  String get detail_time {
    return Intl.message('Time', name: 'detail_time', desc: '', args: []);
  }

  /// `Time`
  String get detail_time_hint {
    return Intl.message('Time', name: 'detail_time_hint', desc: '', args: []);
  }

  /// `Notes`
  String get detail_notes {
    return Intl.message('Notes', name: 'detail_notes', desc: '', args: []);
  }

  /// `Notes`
  String get detail_notes_hint {
    return Intl.message('Notes', name: 'detail_notes_hint', desc: '', args: []);
  }

  /// `Add Task Successful`
  String get detail_message_add_task_successful {
    return Intl.message(
      'Add Task Successful',
      name: 'detail_message_add_task_successful',
      desc: '',
      args: [],
    );
  }

  /// `Add Task Task Error`
  String get detail_message_add_task_error {
    return Intl.message(
      'Add Task Task Error',
      name: 'detail_message_add_task_error',
      desc: '',
      args: [],
    );
  }

  /// `Change Task Successful`
  String get detail_message_change_task_successful {
    return Intl.message(
      'Change Task Successful',
      name: 'detail_message_change_task_successful',
      desc: '',
      args: [],
    );
  }

  /// `Change Task Error`
  String get detail_message_change_task_error {
    return Intl.message(
      'Change Task Error',
      name: 'detail_message_change_task_error',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting_title {
    return Intl.message('Setting', name: 'setting_title', desc: '', args: []);
  }

  /// `Profile`
  String get setting_title_profile {
    return Intl.message(
      'Profile',
      name: 'setting_title_profile',
      desc: '',
      args: [],
    );
  }

  /// `No Name`
  String get setting_user_name_default {
    return Intl.message(
      'No Name',
      name: 'setting_user_name_default',
      desc: '',
      args: [],
    );
  }

  /// `{count} Task left`
  String setting_count_task_left(Object count) {
    return Intl.message(
      '$count Task left',
      name: 'setting_count_task_left',
      desc: '',
      args: [count],
    );
  }

  /// `{count} Task done`
  String setting_count_task_done(Object count) {
    return Intl.message(
      '$count Task done',
      name: 'setting_count_task_done',
      desc: '',
      args: [count],
    );
  }

  /// `App Settings`
  String get setting_menu_settings {
    return Intl.message(
      'App Settings',
      name: 'setting_menu_settings',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get setting_menu_settings_1 {
    return Intl.message(
      'Change Language',
      name: 'setting_menu_settings_1',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get setting_menu_account {
    return Intl.message(
      'Account',
      name: 'setting_menu_account',
      desc: '',
      args: [],
    );
  }

  /// `Change account name`
  String get setting_menu_account_1 {
    return Intl.message(
      'Change account name',
      name: 'setting_menu_account_1',
      desc: '',
      args: [],
    );
  }

  /// `Change account password`
  String get setting_menu_account_2 {
    return Intl.message(
      'Change account password',
      name: 'setting_menu_account_2',
      desc: '',
      args: [],
    );
  }

  /// `Change account Image`
  String get setting_menu_account_3 {
    return Intl.message(
      'Change account Image',
      name: 'setting_menu_account_3',
      desc: '',
      args: [],
    );
  }

  /// `Todo`
  String get setting_menu_other {
    return Intl.message('Todo', name: 'setting_menu_other', desc: '', args: []);
  }

  /// `About US`
  String get setting_menu_other_1 {
    return Intl.message(
      'About US',
      name: 'setting_menu_other_1',
      desc: '',
      args: [],
    );
  }

  /// `FAQ`
  String get setting_menu_other_2 {
    return Intl.message(
      'FAQ',
      name: 'setting_menu_other_2',
      desc: '',
      args: [],
    );
  }

  /// `Help & Feedback`
  String get setting_menu_other_3 {
    return Intl.message(
      'Help & Feedback',
      name: 'setting_menu_other_3',
      desc: '',
      args: [],
    );
  }

  /// `Support US`
  String get setting_menu_other_4 {
    return Intl.message(
      'Support US',
      name: 'setting_menu_other_4',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get setting_menu_logout {
    return Intl.message(
      'Log out',
      name: 'setting_menu_logout',
      desc: '',
      args: [],
    );
  }

  /// `Login session has expired`
  String get error_message_session_expired {
    return Intl.message(
      'Login session has expired',
      name: 'error_message_session_expired',
      desc: '',
      args: [],
    );
  }

  /// `System Error`
  String get error_message_system {
    return Intl.message(
      'System Error',
      name: 'error_message_system',
      desc: '',
      args: [],
    );
  }

  /// `Unable to connect to the server.`
  String get error_message_network {
    return Intl.message(
      'Unable to connect to the server.',
      name: 'error_message_network',
      desc: '',
      args: [],
    );
  }

  /// `Completed Task Error`
  String get error_message_complete_task {
    return Intl.message(
      'Completed Task Error',
      name: 'error_message_complete_task',
      desc: '',
      args: [],
    );
  }

  /// `Delete Task Error`
  String get error_message_delete_task {
    return Intl.message(
      'Delete Task Error',
      name: 'error_message_delete_task',
      desc: '',
      args: [],
    );
  }

  /// `Change Task Error`
  String get error_message_change_task {
    return Intl.message(
      'Change Task Error',
      name: 'error_message_change_task',
      desc: '',
      args: [],
    );
  }

  /// `Bây giờ nhiệm vụ của bạn đã đến hạn.`
  String get notification_body {
    return Intl.message(
      'Bây giờ nhiệm vụ của bạn đã đến hạn.',
      name: 'notification_body',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

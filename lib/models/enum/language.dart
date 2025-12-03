import 'package:flutter/material.dart';

enum Language {
  english(code: "en"),
  vietnamese(code: "vi");

  final String code;

  const Language({required this.code});

  static Language? languageFromCode(String code) {
    if (code == Language.english.code) {
      return Language.english;
    } else if (code == Language.vietnamese.code) {
      return Language.vietnamese;
    } else {
      return null;
    }
  }
}

extension LanguageExt on Language {
  Locale get local {
    switch (this) {
      case Language.english:
        return const Locale('en');
      case Language.vietnamese:
        return const Locale('vi');
    }
  }

  String get code {
    switch (this) {
      case Language.english:
        return 'en';
      case Language.vietnamese:
        return 'vi';
    }
  }
}

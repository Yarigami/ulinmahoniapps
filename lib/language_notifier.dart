import 'package:flutter/cupertino.dart';

class LanguageNotifier extends ValueNotifier<int>{
  LanguageNotifier() : super(0);

  void setLanguage(int lang){
    value = lang;
  }
}
import 'package:ulinmahoniapps/language_notifier.dart';
import 'package:flutter/widgets.dart';

class LanguageProvider extends InheritedWidget {
  final LanguageNotifier notifier;
  const LanguageProvider({required this.notifier, required Widget child, Key? key,}) : super(key: key, child: child);

  static LanguageProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LanguageProvider>()!;
    // assert(result != null, 'No LanguageProvider found in context');
    // return result!;
  }

  @override
  bool updateShouldNotify(LanguageProvider oldWidget) {
    return notifier != oldWidget.notifier;
  }
}

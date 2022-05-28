import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/state_of_application.dart';

import 'model/theme.dart';
import 'view/chat_app.dart';

/// moving to second branch
final settings = ValueNotifier(ThemeSettings(
  sourceColor: Colors.pink,
  themeMode: ThemeMode.system,
));
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateOfApplication(),
      builder: (context, _) => DynamicColorBuilder(
        builder: (lightDynamic, darkDynamic) => ThemeProvider(
          lightDynamic: lightDynamic,
          darkDynamic: darkDynamic,
          settings: settings,
          child: ChatApp(),
        ),
      ),
    ),
  );
}
// 
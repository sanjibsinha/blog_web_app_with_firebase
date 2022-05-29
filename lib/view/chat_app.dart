import 'package:flutter/material.dart';
//import 'package:dynamic_color/dynamic_color.dart';

//import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'chat_home_page.dart';
import '../model/theme.dart';

class ChatApp extends StatelessWidget {
  ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeProvider.of(context);
    return MaterialApp(
      title: 'Provider Firebase Blog',
      debugShowCheckedModeBanner: false,
      theme: theme.dark(settings.value.sourceColor),
      home: const ChatHomePage(),
    );
  }
}

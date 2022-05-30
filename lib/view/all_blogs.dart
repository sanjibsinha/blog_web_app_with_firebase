import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controller/all_widgets.dart';
import '../controller/authenticate_to_firebase.dart';
import '../model/state_of_application.dart';

class AllBlogs extends StatefulWidget {
  const AllBlogs({
    required this.messages,
  });

  final messages;

  @override
  State<AllBlogs> createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Provider Firebase Blog',
            style: TextStyle(
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
        ),
        body: ListView(
          children: [
            for (var message in widget.messages)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogDetailScreen(
                        name: message.name,
                        title: message.title,
                        body: message.body,
                      ),
                    ),
                  );
                },
                child: Paragraph('${message.name}: ${message.title}'),
              ),
          ],
        ));
  }
} // AllBlogs state ends

class BlogDetailScreen extends StatelessWidget {
  // static const routename = '/product-detail';

  const BlogDetailScreen({
    Key? key,
    required this.name,
    required this.title,
    required this.body,
  }) : super(key: key);
  final String name;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: SingleChildScrollView(
        child: Consumer<StateOfApplication>(
          builder: (context, appState, _) => Column(
            children: <Widget>[
              if (appState.loginState == UserStatus.loggedIn) ...[
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    'https://cdn.pixabay.com/photo/2018/03/24/00/36/girl-3255402_960_720.png',
                    width: 250,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 60.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: Text(
                    body,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

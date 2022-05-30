import 'dart:async';

import 'package:blog_web_app_with_firebase/view/all_blogs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controller/all_widgets.dart';
import '../controller/authenticate_to_firebase.dart';
import '../model/state_of_application.dart';

class LetUsChatMessage {
  LetUsChatMessage({
    required this.name,
    required this.title,
    required this.body,
  });
  final String name;
  final String title;
  final String body;
}

class LetUsChat extends StatefulWidget {
  const LetUsChat({
    required this.addMessageOne,
    required this.messages,
  });
  final FutureOr<void> Function(String messageOne, String messageTwo)
      addMessageOne;
  final List<LetUsChatMessage> messages;

  @override
  State<LetUsChat> createState() => _LetUsChatState();
}

class _LetUsChatState extends State<LetUsChat> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_LetUsBlog');
  final _controllerOne = TextEditingController();
  final _controllerTwo = TextEditingController();

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controllerOne,
                decoration: InputDecoration(
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(
                      color: Theme.of(context).highlightColor,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.purple,
                      width: 2.0,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your message to continue';
                  }
                  return null;
                },
              ),
              Expanded(
                child: SizedBox(
                  height: 150.0,
                  child: TextFormField(
                    controller: _controllerTwo,
                    maxLines: 10,
                    decoration: InputDecoration(
                      hintText: 'Body',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(
                          color: Theme.of(context).highlightColor,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              StyledButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await widget.addMessageOne(
                        _controllerOne.text, _controllerTwo.text);
                    _controllerOne.clear();
                    _controllerTwo.clear();
                  }
                },
                child: Row(
                  children: const [
                    Icon(Icons.send),
                    SizedBox(width: 6),
                    Text('SUBMIT'),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AllBlogs(messages: widget.messages),
                      ),
                    );
                  },
                  child: Text(
                    'All Titles',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
} // LetUsChat state ends


import 'dart:async';

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
          ),
        ),
      ),
    );
  }
} // LetUsChat state ends

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
                    color: Colors.yellow,
                    backgroundColor: Colors.red,
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
                      color: Colors.black26,
                      backgroundColor: Colors.lightBlue[300],
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

/**
 Consumer<StateOfApplication>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loginState == UserStatus.loggedIn) ...[
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LetUsChat(
                            addMessageOne: (title, body) =>
                                appState.addMessageToChatBook(title, body),
                            messages: appState.chatBookMessages,
                          ),
                        ),
                      );
                    },
                    child: Text(
                      'Let\'s Blog',
                      style: GoogleFonts.laila(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow,
                        backgroundColor: Colors.red,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
  
 */
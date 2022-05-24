import 'dart:async';

import 'package:flutter/material.dart';

import '../controller/all_widgets.dart';

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
  _LetUsChatState createState() => _LetUsChatState();
}

class _LetUsChatState extends State<LetUsChat> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_LetUsBlog');
  final _controllerOne = TextEditingController();
  final _controllerTwo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Firebase Blog'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controllerOne,
                  decoration: const InputDecoration(
                    hintText: 'title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your message to continue';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: _controllerTwo,
                  decoration: const InputDecoration(
                    hintText: 'Body',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your message to continue';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 10),
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
                        builder: (context) =>
                            BlogPage(messages: widget.messages),
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

class BlogPage extends StatefulWidget {
  const BlogPage({
    Key? key,
    required this.messages,
  }) : super(key: key);
  final List<LetUsChatMessage> messages;

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var message in widget.messages) Text('$message'),
      ],
    );
  }
}

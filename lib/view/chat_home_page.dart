import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../controller/all_widgets.dart';
import '../controller/authenticate_to_firebase.dart';
import '../model/state_of_application.dart';
import 'let_us_chat.dart';

class ChatHomePage extends StatelessWidget {
  const ChatHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider Firebase Blog'),
      ),
      body: ListView(
        children: <Widget>[
          Image.network(
            'https://cdn.pixabay.com/photo/2018/03/24/00/36/girl-3255402_960_720.png',
            width: 250,
            height: 250,
          ),
          const SizedBox(height: 8),
          Consumer<StateOfApplication>(
            builder: (context, appState, _) => AuthenticationForFirebase(
              email: appState.email,
              loginState: appState.loginState,
              startLoginFlow: appState.startLoginFlow,
              verifyEmail: appState.verifyEmail,
              signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
              cancelRegistration: appState.cancelRegistration,
              registerAccount: appState.registerAccount,
              signOut: appState.signOut,
            ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("Write your Blog"),
          const Paragraph(
            'Join your friends and write your blog!',
          ),
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
        ],
      ),
    );
  }
}

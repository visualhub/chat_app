import 'package:chap_app/views/chat/chat_page.dart';
import 'package:chap_app/views/user_auth/log_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final User? user = snapshot.data;
        return user != null ? const ChatPage() : const LogIn();
      },
    );
  }
}

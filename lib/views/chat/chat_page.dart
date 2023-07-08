import 'package:chap_app/utils/app_snack_bar.dart';
import 'package:chap_app/views/chat/widgets/message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  String _currentUser = '';
  late final TextEditingController _messageController;

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('messages').add({
          'senderUid': _currentUser,
          'seen': false,
          'text': _messageController.text,
          'sentAt': Timestamp.now(),
        });
        _messageController.clear();
      } on FirebaseException catch (error) {
        debugPrint(error.message);
      }
    }
  }

  void _singOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (error) {
      AppSnackBar.showSnackBar(
        context,
        message: error.message ?? 'Something Went Wrong',
      );
    }
  }

  @override
  void initState() {
    _currentUser = FirebaseAuth.instance.currentUser!.uid;
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('assets/images/1.png'),
              ),
            ),
            const SizedBox(width: 10),
            const Text('Chat Page')
          ],
        ),
        leading: const SizedBox(),
        leadingWidth: 0,
        actions: [
          IconButton(
            onPressed: _singOut,
            icon: const Icon(
              Icons.logout,
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('messages').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey.shade100,
                  child: ListView(
                    reverse: true,
                    children: [
                      const SizedBox(height: 20),
                      for (final msg in snapshot.data!.docs)
                        MessageCard(
                          isCurretnUser:
                              msg.data()['senderUid'] == _currentUser,
                          msg: msg,
                        ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                width: double.infinity,
                color: Colors.blueGrey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: TextField(
                          controller: _messageController,
                          cursorColor: Colors.blueGrey,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 18),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(99),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'Type Your Message Here',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    IconButton(
                      onPressed: _sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

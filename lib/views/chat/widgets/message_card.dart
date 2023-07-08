import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
    required this.isCurretnUser,
    required this.msg,
    this.isSeen = false,
  });

  final QueryDocumentSnapshot msg;
  final bool isCurretnUser, isSeen;

  void _markAsSeen() {
    FirebaseFirestore.instance.collection('messages').doc(msg.id).update({
      'seen': true,
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isCurretnUser && !msg['seen']) _markAsSeen();
    return Row(
      mainAxisAlignment:
          isCurretnUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 15,
            bottom: 20,
            right: 15,
          ),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: isCurretnUser ? Colors.blueGrey.shade200 : Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 10,
                ),
              ]),
          alignment:
              isCurretnUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                msg['text'],
                style: TextStyle(
                  color: isCurretnUser ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (!isCurretnUser && msg['seen'])
                Icon(
                  Icons.check,
                  size: 16,
                  color: isSeen ? Colors.green : Colors.black45,
                ),
              Text(
                formatTime(msg['sentAt'].toDate()),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatTime(DateTime dt) => '${dt.hour}:${dt.minute}';
}

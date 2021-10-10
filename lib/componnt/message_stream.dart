import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageStram extends StatelessWidget {
  final fireStore;
  final User logIn;
  MessageStram({this.fireStore, this.logIn});
  @override
  Widget build(BuildContext context) {
    return // stream- -> that where data comes from
        // builder build stargey --> provide the logic for the stream should actually do
        // each update will provide an Async snap shot which the most interaction with stream
        StreamBuilder<QuerySnapshot>(
      stream: fireStore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          ));
        }

        // now we have access to context and snap shot that contain streams
        // this snap shot cntain Query Snap Shot from fire base
        // to specify what kind of returnded data --> make stream builder of Query Snap Shot
        final messages = snapshot.data.docs.reversed;
        // return list of Query Document Snap Shot
        // so we must iterate in it to get all its elemnts
        List<MessageBubble> messageBubbles = [];

        for (var message in messages) {
          final mapData = message.data() as Map<String, dynamic>;
          final messageText = mapData['text'];
          final messageSnder = mapData['sender'];

          // get loggined user email
          final currentUser = logIn.email;

          messageBubbles.add(MessageBubble(
            mText: messageText,
            mSender: messageSnder,
            isUser: messageSnder == currentUser,
          ));
        }

        return Expanded(
          child: ListView(
            reverse: true,
            // to make it sticky to last message
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  // provide text and sender
  // make them final to be intialize once at conxtructor
  final String mText, mSender;
  final isUser;

  MessageBubble({this.mText, this.mSender, this.isUser});
  @override
  Widget build(BuildContext context) {
    // to change background of text
    // wrap it in material
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment:
          isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Text(
            mSender,
            style: TextStyle(
                fontSize: 12,
                // color to make it little lighter
                color: Colors.black54),
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Material(
                elevation: 5,
                // put border for each side excet the side of right or left depending on the user
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(isUser ? 0 : 30)),
                color: isUser ? Colors.lightBlueAccent : Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    mText,
                    style: TextStyle(
                        fontSize: 20,
                        color: isUser ? Colors.white : Colors.black54),
                  ),
                ))),
      ],
    );
  }
}

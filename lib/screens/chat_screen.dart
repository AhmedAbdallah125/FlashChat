import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/componnt/message_stream.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void dispose() {
    super.dispose();
    // remove textController if not used to release resources
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textSendController.dispose();
  }

  /// make edit text Controller
  // Create a text controller. Later, use it to retrieve the
  // current value of the TextField.
  final _textSendController = TextEditingController();

  // store our messages get from user
  String messageText;
  final _fireStore = FirebaseFirestore.instance;

  //make variable to hold current usr for logged in user
  User loggedIn;
  final _auth = FirebaseAuth.instance;
  // method for get last successful e-mail signed-in
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedIn = user;
        print('done' + user.email.toString());
      }
    } catch (e) {
      print(e);
    }
  }

// // make method
  // void getMessages() async {
  //   /// get first collection reference then get this collection
  //   /// Snapshot is the result of the Future or Stream you are listening to in your FutureBuilder.
  //   final snapShot = await _fireStore.collection('messages').get();
  //   // to get all document in collection
  //   for (var message in snapShot.docs) {
  //     // get data in this document
  //     print(message.data());
  //   }
//   }

  @override
  void initState() {
    getCurrentUser();

    super.initState();
  }

  /// to listen to stream of data
  /// notify for any new messages
  void messageStream() async {
    // another way to listen to streams
    // _fireStore.collection('collectionPath').snapshots().listen((event) {
    //   for (var e in event.docs) {
    //     print(e.data());
    //   }
    // });

    // notify all documents in this collection
    // snapshot return stream so we want one query --> use for each
    // then we want only doc --> use another for each
    await for (var snapShot in _fireStore.collection('messages').snapshots()) {
      // return all docs
      for (var message in snapShot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                final user = _auth.signOut();
                if (user != null) print('done');
                messageStream();
                //Implement logout functionality
                // try {
                //   await _auth.signOut();
                //   if (_auth.currentUser == null) {
                //     Navigator.pop(context);
                //   }
                // } catch (e) {
                //   print(e);
                // }
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // stream- -> that where data comes from
            // builder build stargey --> provide the logic for the stream should actually do
            // each update will provide an Async snap shot which the most interaction with stream
            /// refactor it in another widget
            MessageStram(
              fireStore: _fireStore,
              logIn: loggedIn,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textSendController,
                      onChanged: (value) {
                        //get input text from user
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      _textSendController.clear();
                      //Implement send functionality.
                      await _fireStore
                          .collection('messages')
                          .add({'text': messageText, 'sender': loggedIn.email});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

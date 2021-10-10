import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

// to initialize firebase
// make connection to it
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData.light().copyWith(
        //   textTheme: TextTheme(
        //     bodyText2: TextStyle(color: Colors.black54),
        //   ),

        initialRoute: WelcomeScreen.id,
        // if U use slash style
        //U must define route as / nothing or your app will be crashed
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
        });
  }
}

///advice for all coming years
///if U change any thing or add in build.gradle
///and U get error search about solutions that change
/// classpath("com.android.tools.build:gradle:3.5.2")
///because at probably this is problem because version can make conflict with other thing

///8 REFACTOR
//if there are repeated widget --> U must refactor it to make your code clean and simple
//like we did with rounded button.
// if there is constant thing and u use it more than one -->
///must put it in constant file like decoration
//and u can change some properties in it by using key Word
/// COPY WITH()

///9 hero animation which takes place in
/*
 screen transition which is simplest way
 from page 1 to page 2 but this require shared element
 which known in android shared element transition
 1- hero animation require two hero in two pages
 2- shared tag property so flutter know what will be animated
 3- navigation between two pages
*/
/// fade transition to hide and  show elements or pop up or not
// custom animation --> change the background or size or each property or move something
//there are 4 main concept ticker-animation controller-animation value
//1- ticker look like in clock tick - something to count
//each tick of our clock that our animation will change
// it looks like flip book to make animation
//2- animation controller is the manager that set the values and tell animation to
// start or to stop or forward or reverse
//3-animation value usually from 0 to 1
// change upper bound  to 100 to use it
// this will change increasing
// to change in shape like a curve
/// curve animation as non linear
// https://flutter.dev/docs/development/ui/animations/tutorial
//  to know which curve must use
// https://api.flutter.dev/flutter/animation/Curves-class.html
//
/// Animation that translate between two values --> use tween Animation
// like starting color and end color
// this type is explicit
// there is type called implicit for container or not
// u have to mange life cycle of controller
// which all of them are code based animation

///10 lesson with and mixin
// reusing class code meaning be able to inherit from that class.
// the normal way of it, is using extends but U can extend only one class
//class duck extends bird{}
//but there is another way to reuse part of classes's code
//U don't have to inherit from any body but U can reuse bits of code
//mixin canFly{ void fly(){print('can fly')}}
//mixin canSwim{ void fly(){print('can swim')}}
// class Duck extends animal with canFly, canSwim{ }

///lesson with prepackaged. there are  a lot of available animation
// like flutter sequence animation. instance animation change color size and so on
// rubber, sprung and animated text kit to animate text

// refactor  by using android studio flutter outline --> extract widget
/// put constant like decoration in constant not tob make spaghetti
/// to edit some constant use write with
// do some refactor . make it straight forward

///11 Firebase cloud
// must apply all instruction for android or ios but ios requires mac and iphone to test it
// we need cloud_firebase and its authentication.
// available features of firebase --> https://github.com/FirebaseExtended/flutterfire
// must apply fireBaseCore first before U need
/// link for some problem faced because of android
///https://blog.londonappbrewery.com/troubleshooting-firebase-x-flutter-a974b2645689#003a

///12 Authentication user with firebase
//first U get changed value of text field and store in a variable for registration and login screen
// must change som editing to be more best UI
// use call back on changed to get value user enter and save it in variable
// change property align in text field to align it in center
// override duration of text field to make suffix icon in it to change security of this text
// property called obscure text
// to make g-mail keyboard show on screen instead of custom one
///                       keyboardType:TextInputType.emailAddress,
/// make secure or not (جدعنه منى دى)
/*
if (secure == true) {
                                setState(() {
                                  secure = false;
                                  iconPassword = Icons.panorama_fish_eye;
                                });
                              } else {
                                setState(() {
                                  secure = true;
                                  iconPassword = Icons.remove_red_eye;
                                });
                              }
*/

/// core firebase is responsible for connecting your application to Firebase.
// U must initialize first in Your main and us binding widget to ensure initialing
// U must enable register new user in in firebase authentication

///(16) ## Authentication Users with firebase ##
/// sign in by existing user in log-in screen by using method sign-in email and password then wait for response
/// so if response not null so go to chat screen
/*
try {
                        final signedINUser =
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                        if (signedINUser != null) {
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      } on FirebaseAuthException catch (e) {
                        print(e.message);
                      }
                    },
 */
/// in chat screen make method to retrieve last successful sign in
/// // method for get last successful e-mail signed-in
/// //make variable for logged in user
//   User loggedIn;
//  void getCurrentUser() async {
//     try {
//       final currentUser = _auth.currentUser;
//       if (currentUser != null) {
//         print('done' + loggedIn.email.toString());
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
/// call this method in initState
///
///(17) ## make spinner upon registration or log in while getting or sending to firebase ##
/// using package -> modal_progress_hud 0.1.3

///18 fire store (firebase cloud)
/// summary
/// if we hit send all messages will go to our DB which will find it in fire base data base.
/// this is no sql database while working in test mode but U must change it after testing to locked mode
/// collection is the thing that U care about it and in our case is Messages
/// make messages collection to store all messages and then create two fields (String,String) text and User
/// by current loggend in user send theses messages
/// make instance of fire store then send this to our store by using
///Implement send functionality.
//                       await _fireStore
//                           .collection('messages')
//                           .add({'text': messageText, 'sender': loggedIn.email});
// we can use this method getMessage()
// make method
  // void getMessages() async {
   /// get first collection reference then get this collection
     /// Snapshot is the result of the Future or Stream you are listening to in your FutureBuilder.
     /// stream tells us that the data is ready instad of calling it by my self
     ///  1/ we use only query at at time by this method
     /// To read a collection or document once,
     ///  call the Query.get or DocumentReference.get methods. 


  //   final message = await _fireStore.collection('messages').get();
  //   // to get all document in collection
  //   for (var snapShot in message.docs) {
  //     print(snapShot.data());
  //   }
  // }
  /// {sender: ahmed@email.com, text: hifcgh}

  // but to get always updated message --> U must call it again and again 
  //so for eample check for nw messages two times and it returns future 
  /// but the bettr approach to  do it instantly message, U want to get every updated messages.
  /// /// to listen to stream of data
  /// 2/ real time data
  /// notify for any new messages
  /// autoatically pushed to our app instead of calling it agagin and again .....
  /// going to listen to changes happenes in this collection listen to the stream
  ///     // snapshot return stream so we want one query --> use for each
    // then we want only doc --> use another for each

  // void messageStream() async{
  //   // notify all documents in this collection
  // wait for until this complete
  //    await for( var snapShot in _fireStore.collection('messages').snapshots()){
  //      // return all docs
  //      for(var message in snapShot.docs ){
  //        print(message.data());
  //      }
  //    }
  // }

  // another way to listen to streams
    // _fireStore.collection('collectionPath').snapshots().listen((event) {
    //   for (var e in event.docs) {
    //     print(e.data());
    //   }
    // });

// or by using stream builder in fire base website

///21 How to convert stream to widgets by two steps
///1- just display data in widget
/// by using stream builder- it's able to rebuild itself each time new value comes from stream builder
///which helps automatically manage the streams state and disposal of the stream when it's no longer used within your app.
/// need two important 1-stream 2-builder
///             // stream- -> that where data comes from
            // builder build stargey --> provide the logic for the stream should actually do
            // each update will provide an Async snap shot which the most interaction with stream
            // StreamBuilder<QuerySnapshot>(
            //   stream: _fireStore.collection('messages').snapshots(),
            //   builder: (context, snapshot) {
            //     if (!snapshot.hasData) {
            //       return CircularProgressIndicator();
            //     }
            //     // now we have access to context and snap shot that contain streams
            //     // this snap shot cntain Query Snap Shot from fire base
            //     // to specify what kind of returnded data --> make stream builder of Query Snap Shot
            //     final messages = snapshot.data.docs;
            //     // return list of Query Document Snap Shot
            //     // so we must iterate in it to get all its elemnts
            //     List<Text> listWidget = [];
            //     for (var message in messages) {
            //       final mapData = message.data() as Map<String, dynamic>;
            //       final messageText = mapData['text'];
            //       final messageSnder = mapData['sender'];
            //       final textWidget = Text('$messageText from $messageSnder');
            //       // then add it to list
            //       listWidget.add(textWidget);
            //     }

            //     return Column(
            //       children: listWidget,
            //     );
            //   },
            // ),
            //
            //       /// we use simple circular indicartor instead of progress HuD which provide when to spin or not by attribute isAyncCall
        /// 2- improving the styling and user Experience of our chat App
            /// first wrap widget to listview instead of usual column
            ///  so we can scroll it then wrap it to expanded to take available space 
            /// then add some horiaontal and vertical padding 
            /// then instead of using usual text --> make own styl by create new widget (MessageBubble)
            ///   // provide text and sender
  // final String mText,mSender;
  // MessageBubble({this.mText, this.mSender});
/// add some padding and by using materil widget ad color background
/// separte each seender and text and wrap them in clolumn
///  return Column(
    //   mainAxisAlignment: MainAxisAlignment.start,
    //   crossAxisAlignment: CrossAxisAlignment.end,
    //   children: [
    //     Text(
    //       mSender,
    //       style: TextStyle(fontSize: 10,color:Colors.black56),
                  // color to make it little lighter

    //     ),
    //     Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    //         child: Material(
      /// give some shadow 
    //             elevation: 5,
    /// to make it bubble
    //             borderRadius: BorderRadius.circular(30),
    //             color: Colors.lightBlue,
    //             child: Padding(
    //               padding: EdgeInsets.all(10),
    //               child: Text(
    //                 mText,
    //                 style: TextStyle(fontSize: 20, color: Colors.white),
    //               ),
    //             ))),
    //   ],
    // );
 ///refactor chat scren to be more readable to be bit simpler--> extract stream builder in separate widget
 ///put it in another file and put with it Message Bubble widget also
 ///pass to them _fireStore object
 /// we want to remove what user write in text filed after sending it and showing in our chat screen by using textEditor
 /// make final objct --> connect to text field --> // remove textController if not used to release resources
    // Clean up the controller when the widget is removed from the
    // widget tree.
 /// -->Finally, listen to the TextEditingController and call method that U want to implement
 /// when the text changes. Use the addListener() method for this purpose. put this in intiState
 /// but we only need to clear when user press send button so in send button -->call controller.clear();
 /// Note
 // use flexible widget if y want your widget to smalleer if there is littlee space
 // like in hero widget has its widgth but when u start writing --> vertial keyboard take additional space so
 //to make hero smmaller in this case wrap it in flexible widget .which is idfferent from extended widget whick full
 //the whole space of parent  
 /// 
 /// Completing improving the style to make different styl for loggined user and other user
 /// first send logged user ti message stream to check if thses document come from him or not to make different syle
 //         logIn: loggedIn,
 /// make bollean value --> true if this is logged in user and snt it to message bubble for different style
 /// because there is only two values --> one for logged in and other for others --> so we can make it by
 /// ternary operator to dtermine value depeemding on variable
 ///           isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
///                 // put border for each side excet the side of right or left depending on the user
                // borderRadius: BorderRadius.only(
                //     bottomRight: Radius.circular(30),
                //     bottomLeft: Radius.circular(30),
                //     topLeft: Radius.circular(isUser ? 30 : 0),
                //     topRight: Radius.circular(isUser ? 0 : 30)),

/// there is problem which is no order of added messages that newest recent message will show and sceenn update to show 
/// to the new messagee --> add it to the bottom of list --> by steps
/// 1
// delete collection in firebase  so there is no intilazation

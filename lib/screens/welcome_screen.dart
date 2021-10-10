import 'package:flash_chat/componnt/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  // make variable to use it for named navigator

  // check if the name is correct or not
  // use word static
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

// use word with to upgrade our class to ticker provider
// use single for only one animation
class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
//first make
  AnimationController controller;
  AnimationController controllerV;
  AnimationController tC;

  // make animation  variabl
  Animation animation;
  // animation for tween
  Animation tanimation;

  @override
  // get called at the moment create state called
  void initState() {
    super.initState();

    // initialize this variable
    controller = AnimationController(
        // period that animation will last
        duration: Duration(seconds: 1),
        // which takes ticker provide - what thing will trigger
        // which usually will be state object
        // this means welcome screen state
        vsync: this);
    // make curved animation
    // this will apply to animation controller
    // must make upper bound for animation controller that pass to the parent be 1

    animation =
        CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);
    // for every tick our animation will increase fro  to 1
    controller.forward();
// if u want to loop
// u must check status of animation
//-for forward --> complete
//- for reverse -->dismissee
    // controller.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    // to listen to our value of controller
    // call the listener every time animation change
    controller.addListener(() {
      // must use set state to trigger this animation
      setState(() {});
    });
    // for me
    controllerV =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    controllerV.reverse(from: 1);
    controllerV.addListener(() {
      setState(() {});
    });
    // for tween
    tC = AnimationController(vsync: this, duration: Duration(seconds: 1));
// size tween animation
    // tanimation = SizeTween(
    //         begin: Size(double.infinity, 80), end: Size(double.infinity, 40))
    //     .animate(TC);
    tanimation =
        ColorTween(begin: Colors.lightBlue, end: Colors.white).animate(tC);
    tC.forward();
    tC.addListener(() {
      setState(() {});
    });
  }

  // use it to dispose controller when dispose screen
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tanimation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  child: Image.asset('images/logo.png'),
                  height: controller.value * 60,
                ),
              ),
              DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Flash Chat',
                          speed: Duration(milliseconds: 80)),
                    ],
                  ))
            ]),
            SizedBox(
              height: controllerV.value * 100,
            ),
            SizedBox(
              height: 20,
            ),
            RoundedButton(
              color: Colors.lightBlue,
              onpressed: () async {
                //   //Go to registration screen.
                // make firebas vaiable
                // await Firebase.initializeApp(
                //     name: 'Flash Chat',
                //     options: const FirebaseOptions(
                //         appId: '1:631651260878:android:1346d3a108f822e3ad339f',
                //         apiKey: 'AIzaSyA6V5y3qWG9Ros2DS4MeSxTSi2lmet-_JM',
                //         messagingSenderId: '631651260878',
                //         projectId: 'flash-chat-ae0ed'));

                Navigator.pushNamed(context, LoginScreen.id);
              },
              title: 'Log In',
            ),
            RoundedButton(
              color: Colors.blueAccent,
              onpressed: () async {
                //   //Go to registration screen.
                // make firebas vaiable
                // await Firebase.initializeApp(
                //     name: 'Flash Chat',
                //     options: const FirebaseOptions(
                //         appId: '1:631651260878:android:1346d3a108f822e3ad339f',
                //         apiKey: 'AIzaSyA6V5y3qWG9Ros2DS4MeSxTSi2lmet-_JM',
                //         messagingSenderId: 'my_messagingSenderId',
                //         projectId: 'flash-chat-ae0ed'));

                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              title: 'Register',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: TextButton(
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 42)),
                    elevation: MaterialStateProperty.all(5.0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0))),
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueGrey)),
                onPressed: () {},
                child: Text(
                  'hello',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

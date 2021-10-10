import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/componnt/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;

  /// make variable to save our data
  String email;
  String password;

  /// for spinner
  bool showSpinner = false;

  /// for securing or not in text field
  bool secure = true;
  IconData iconPassword = Icons.remove_red_eye;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: Hero(
                        tag: 'logo',
                        child: Container(
                          height: 200.0,
                          child: Image.asset('images/logo.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          //Do something with the user input.
                          email = value;
                        },
                        decoration: KTextFieldDecoration.copyWith(
                            hintText: 'Enter your email')),
                    SizedBox(
                      height: 8.0,
                    ),
                    TextField(
                      obscureText: secure,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        //Do something with the user input.
                        password = value;
                      },
                      decoration: KTextFieldDecoration.copyWith(
                          hintText: 'Enter your password.',
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: IconButton(
                              onPressed: () {
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
                              },
                              icon: Icon(iconPassword),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RoundedButton(
                      color: Colors.lightBlueAccent,
                      title: 'Log In',
                      onpressed: () async {
                        // make spinner while creating users
                        setState(() {
                          showSpinner = true;
                        });
                        //Implement login functionality.
                        print(password);

                        try {
                          final signedINUser =
                              await _auth.signInWithEmailAndPassword(
                                  email: email, password: password);
                          if (signedINUser != null) {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          print(e.message);
                        }
                      },
                    ),
                  ]))),
    );
  }
}

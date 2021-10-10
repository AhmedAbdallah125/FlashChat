import 'package:flash_chat/componnt/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  /// make instance of authentication
  /// make it final because it will not change
  /// private so other classes cant accidentally change it
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
              const SizedBox(
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
                  // override by using copy with
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: 'Enter your password')),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                title: 'Register',
                onpressed: () async {
                  // make spinner while creating users
                  setState(() {
                    showSpinner = true;
                  });
                  //Implement registration functionality.
                  /// try create users and handle thrown exception
                  /// because of invalid email or other thing
                  /// then return of this method is future so  we use async and await
                  /// put them in variable of type final  because it will not change
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      setState(() {
                        showSpinner = false;
                      });
                      // lead him to chat screen to start messaging
                      Navigator.pushNamed(context, ChatScreen.id);
                      print(newUser.user);
                    }

                    // for any firebase auth exception
                  } on FirebaseAuthException catch (e) {
                    print(e.message);
                  }

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
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../services/constants.dart';
import '../services/helper_classes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email, password;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff5ea),
      body: ModalProgressHUD(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Stack(children: [
              Positioned(
                top: -70,
                left: -70,
                child: Container(
                  width: 300.0,
                  height: 300.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff968c83),
                  ),
                ),
              ),
              Positioned(
                top: .2 * MediaQuery.of(context).size.height,
                left: .4 * MediaQuery.of(context).size.width,
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xfff7dad9),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'KaushanScript',
                          fontSize: 24.0),
                    ),
                    SizedBox(height: 30.0),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: brickRed,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                      onChanged: (value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    TextField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white70,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: brickRed,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          )),
                      onChanged: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        setState(() {
                          loader =true;
                        });
                        try {
                          var loggedInUser = await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          if (loggedInUser != null) {
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                          setState(() {
                            loader = false;
                          });
                        } catch (e) {
                          print(e);
                        }
                      },
                      textColor: Colors.black,
                      padding: const EdgeInsets.all(0.0),
                      child: BtnStyle(),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Material(
                      child: InkWell(
                        splashColor: deepBlue.withOpacity(0.6),
                        onTap: () =>
                            {
                              Navigator.pushReplacementNamed(context, '/sign')},
                        child: Text(
                          "New User: Register",
                          style: redirectTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
        inAsyncCall: loader,
      ),
    );
  }
}

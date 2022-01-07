import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymarket/applicationForm.dart';
import 'package:mymarket/services/database.dart';

import 'adminHome.dart';

class AdminLogin extends StatefulWidget {
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final _phoneController = TextEditingController();

  final _codeController = TextEditingController();

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    var uid;
    _auth.verifyPhoneNumber(
        phoneNumber: "+91" + phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            setState(() {
              uid = user.uid;
              print(uid);
            });
            print("moving...");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else {}

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("Enter OTP",
                      style: TextStyle(color: Color(0xffE24E1B))),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Color(0xffD6D4A0),
                      color: Color(0xffDA7635),
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          setState(() {
                            uid = user.uid;
                            print(uid);
                          });
                          print("moving...");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        } else {
                          return false;
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Login Failed'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('The phone number is not registered.'),
                  Text('Would you like to apply for registration?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationForm()));
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Change User"),
          backgroundColor: Color(0xff654236),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(32),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Text(
                    "Not a Buyer? Login Here.",
                    style: TextStyle(color: Color(0xffDB995A)),
                  ),
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Login",
                        style: TextStyle(
                            color: Color(0xffD6D4A0),
                            fontSize: 36,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                    BorderSide(color: Color(0xffDA7635))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                borderSide:
                                    BorderSide(color: Color(0xffE24E1B))),
                            filled: true,
                            fillColor: Colors.grey[100],
                            hintText: "Mobile Number"),
                        controller: _phoneController,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        width: double.infinity,
                        child: FlatButton(
                          child: Text("LOGIN"),
                          textColor: Color(0xffDB995A),
                          padding: EdgeInsets.all(16),
                          onPressed: () async {
                            final phone = _phoneController.text.trim();
                            if (!await Database().checkUsername(phone)) {
                              loginUser(phone, context);
                            } else {
                              _showMyDialog();
                            }
                          },
                          color: Color(0xff654236),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mymarket/adminHome.dart';
import 'package:mymarket/services/helper.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm();

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String dropdownvalue = 'Seller';
  String name = "", phone = "", address = "", shopName = "";
  var first;

  // List of items in our dropdown menu
  var items = [
    'Seller',
    'Delivery Person',
  ];

  @override
  Widget build(BuildContext context) {
    Future<bool> _showMyDialog(String title, String line1, String line2) async {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(line1),
                  Text(line2),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
    }

    // Build a Form widget using the _formKey created above.
    return Scaffold(
      appBar: AppBar(
        title: Text("Registeration Form"),
        backgroundColor: Color(0xffD8A47F),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.person),
                    hintText: 'Enter your name',
                    labelText: 'Name',
                  ),
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    icon: const Icon(Icons.phone),
                    hintText: 'Enter a phone number',
                    labelText: 'Phone',
                  ),
                  onChanged: (val) {
                    setState(() {
                      phone = val;
                    });
                  },
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text("Register as -"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        child: DropdownButton(
                          // Initial Value
                          value: dropdownvalue,

                          // Down Arrow Icon
                          icon: const Icon(Icons.keyboard_arrow_down),

                          // Array list of items
                          items: items.map((String item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                          // After selecting the desired option,it will
                          // change button value to selected value
                          onChanged: (newValue) {
                            setState(() {
                              dropdownvalue = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                if (dropdownvalue == 'Seller')
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(FontAwesomeIcons.houseUser),
                      hintText: 'Address of your shop',
                      labelText: 'Shop Address',
                    ),
                    onChanged: (val) {
                      setState(() {
                        address = val;
                      });
                    },
                  ),
                if (dropdownvalue == 'Seller')
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(FontAwesomeIcons.solidHandPointRight),
                      hintText: 'Enter shop name',
                      labelText: 'Shop Name',
                    ),
                    onChanged: (val) {
                      setState(() {
                        shopName = val;
                      });
                    },
                  ),
                new Container(
                    padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                    child: new RaisedButton(
                      color: Color(0xffEE4B6A),
                      child: const Text('Submit'),
                      onPressed: () async {
                        if (name == "" || phone == "") {
                          _showMyDialog("Field Missing!",
                              "Kindly fill all the fields.", "Thank You");
                        } else if (dropdownvalue == "Seller" && address == "") {
                          _showMyDialog("Field Missing!",
                              "Kindly fill all the fields.", "Thank You");
                        } else if (dropdownvalue == "Seller") {
                          bool confirm = await _showMyDialog(
                              "Confirm Registration",
                              "You are registering as a seller. Please make sure you've written your complete address.",
                              "If not sure, press cancel.");
                          if (confirm) {
                            print("Registering...");
                            final query = address;
                            var addresses = await Geocoder.local
                                .findAddressesFromQuery(query);

                            setState(() {
                              first = addresses.first;
                            });

                            print(
                                "${first.featureName} : ${first.coordinates}");
                            if (await loginUser(phone, context)) {
                              print("Phone Number Verified");
                              Firestore.instance
                                  .collection("users")
                                  .document(uid)
                                  .setData({
                                "userId": uid,
                                "name": name,
                                "phoneNumber": phone,
                                "type": dropdownvalue,
                                "applicant": true,
                                "shopName": shopName,
                                "shopLat": first.coordinates.latitude,
                                "shopLong": first.coordinates.longitude,
                                "shopAddress": address
                              });
                              HelperFunc.saveUserloggedIn(true);
                              HelperFunc.saveType("SellerApplicant");
                              HelperFunc.saveUsername(uid);
                            }
                          }
                        }
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final _codeController = TextEditingController();
  var uid;

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    FirebaseUser user;
    _auth.verifyPhoneNumber(
        phoneNumber: "+91" + phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          user = result.user;

          if (user != null) {
            setState(() {
              uid = user.uid;
              print(uid);
            });

            print("Phone Number Verified");
            Firestore.instance.collection("users").document(uid).setData({
              "userId": uid,
              "name": name,
              "phoneNumber": phone,
              "type": dropdownvalue,
              "applicant": true,
              "shopName": shopName,
              "shopLat": first.coordinates.latitude,
              "shopLong": first.coordinates.longitude,
              "shopAddress": address
            });
            HelperFunc.saveUserloggedIn(true);
            HelperFunc.saveType("SellerApplicant");
            HelperFunc.saveUsername(uid);
            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
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
                          print("Phone Number Verified");
                          Firestore.instance
                              .collection("users")
                              .document(uid)
                              .setData({
                            "userId": uid,
                            "name": name,
                            "phoneNumber": phone,
                            "type": dropdownvalue,
                            "applicant": true,
                            "shopName": shopName,
                            "shopLat": first.coordinates.latitude,
                            "shopLong": first.coordinates.longitude,
                            "shopAddress": address
                          }).then((value) async {
                            HelperFunc.saveUserloggedIn(true);
                            print(await HelperFunc.getUserloggedIn());
                            HelperFunc.saveType("SellerApplicant");
                            HelperFunc.saveUsername(uid);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          });
                        } else {}
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);

    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseUser user;

  HomeScreen({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shop Details"),
        backgroundColor: Color(0xffE24E1B),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(child: Image.asset("assets/image/ad.jpeg")),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Unique ID:",
              style: TextStyle(color: Color(0xffDB995A), fontSize: 22),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "${user.uid}",
              style: TextStyle(
                color: Color(0xff654236),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Phone Number:",
              style: TextStyle(color: Color(0xffDB995A), fontSize: 22),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "${user.phoneNumber}",
              style: TextStyle(
                color: Color(0xff654236),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Aadhar:",
              style: TextStyle(color: Color(0xffDB995A), fontSize: 22),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "optional",
              style: TextStyle(
                color: Color(0xff654236),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/image/tex.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Text(
                      "Username",
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Divider(
                  thickness: 3,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.store,
                            color: Color(0xff88498F)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "Products",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff88498F)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.shoppingBag,
                            color: Color(0xff88498F)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "Upload Photos",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff88498F)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.tags,
                            color: Color(0xff88498F)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "Upload Offers",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff88498F)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          FontAwesomeIcons.moneyBill,
                          color: Color(0xff88498F),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "Account",
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff88498F)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(FontAwesomeIcons.phoneAlt,
                            color: Color(0xff88498F)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Text(
                            "Update Contact Details",
                            style: TextStyle(
                                fontSize: 18, color: Color(0xff88498F)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/login", (route) => false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(FontAwesomeIcons.signOutAlt,
                              color: Color(0xff88498F)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(
                              "Log Out",
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xff88498F)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

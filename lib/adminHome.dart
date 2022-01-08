import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mymarket/services/database.dart';
import 'package:mymarket/services/helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var uid;

  @override
  void initState() {
    readyState();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Database().getDocument(uid),
      builder: (context, snapshot) {
         if (!snapshot.hasData) return CircularProgressIndicator();
        return Scaffold(
          appBar: AppBar(
            title: Text("Shop Details"),
            backgroundColor: Color(0xffE24E1B),
          ),
          body: SingleChildScrollView(
            child: Container(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Container(child: Image.asset("assets/image/ad.jpeg")),
                          ),
                        ),
                        if(snapshot.data.documents[0]["applicant"]==true)
                        Column(
                          children: [
                            SizedBox(
                          height: 32,
                        ),
                        Text(
                          "Application in progress",
                          style: TextStyle(color: Color(0xffEF8354), fontSize: 22),
                        ),
                          ],
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          "Username: ",
                          style: TextStyle(color: Color(0xffDB995A), fontSize: 22),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          snapshot.data.documents[0]["name"],
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
                          snapshot.data.documents[0]['phoneNumber'],
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
                          snapshot.data.documents[0]['name'],
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
    );
  }

  Future<void> readyState() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = user.uid;
    });
  }
}

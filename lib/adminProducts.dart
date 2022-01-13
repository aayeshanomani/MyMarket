import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mymarket/editProduct.dart';
import 'package:mymarket/services/database.dart';
import 'package:mymarket/uploadProduct.dart';

class AdminProducts extends StatefulWidget {
  const AdminProducts();

  @override
  _AdminProductsState createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  String uid = "";

  Future<void> readyState() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      uid = user.uid;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    readyState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Products"),
        backgroundColor: Color(0xff04030F),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: StreamBuilder(
                stream: Database().getSellerProducts(uid),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return CircularProgressIndicator();
                  return Column(
                    children: [
                      if (snapshot.data.documents.length == 0)
                        Padding(
                          padding: const EdgeInsets.all(63.0),
                          child: Text("No product uploaded yet!"),
                        ),
                      if (snapshot.data.documents.length > 0)
                        for (int i = 0; i < snapshot.data.documents.length; i++)
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xff6A8D73),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(snapshot
                                              .data.documents[i]['photo']),
                                        ),
                                        borderRadius: BorderRadius.circular(6)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data.documents[i]
                                                ['prodName'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Rs. " +
                                                snapshot.data.documents[i]
                                                    ['price']
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Min. Quantity: " +
                                                snapshot.data.documents[i]
                                                    ['minQuantity'],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Category: " +
                                                snapshot.data.documents[i]
                                                    ['category'],
                                          ),
                                        )
                                      ]),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                            color: Color(0xffE4FFE1),
                                            onPressed: () {
                                              print(snapshot.data.documents[i]
                                                  .documentID);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProduct(snapshot
                                                              .data
                                                              .documents[i]
                                                              .documentID)));
                                            },
                                            child: Text("Edit")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                            color: Color(0xffFFE8C2),
                                            onPressed: () {
                                              print(snapshot.data.documents[i]
                                                  .documentID);
                                              Database().deleteProd(snapshot
                                                  .data
                                                  .documents[i]
                                                  .documentID);
                                            },
                                            child: Text("Delete")),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                            color: Color(0xffF4FDD9),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UploadProducts()));
                            },
                            child: Text("Upload Item")),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}

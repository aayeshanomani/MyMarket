import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mymarket/services/database.dart';
import 'package:mymarket/services/widgets.dart';
import 'package:path/path.dart';

class EditProduct extends StatefulWidget {
  final String prodId;
  const EditProduct(this.prodId);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  PickedFile imageFile;
  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Color(0xff38023B)),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Color(0xffA288E3),
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Color(0xffBBD5ED),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Color(0xffCEFDFF),
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Color(0xffCCFFCB),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool load = false;
  String name = "", price = "", minq = "";
  String dropdownvalue = 'Change category';
  var items = [
    'Change category',
    'Grocery',
    'Staitionery',
    'Electronic',
    'Restaurant',
    'Beauty',
    'Refurbished'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Edit Product"), backgroundColor: Color(0xffF0A868)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Leave blank if not willing to change"),
              ),
              ModalProgressHUD(
                inAsyncCall: load,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 26, horizontal: 36),
                          child: Text(
                            "Product",
                            style: TextStyle(
                                color: Color(0xff6A8D73),
                                fontSize: 28,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Text("Select category -"),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (dropdownvalue != "Change category") {
                                Firestore.instance
                                    .collection("products")
                                    .document(widget.prodId)
                                    .setData({"category": dropdownvalue},
                                        merge: true).then((value) {
                                  showMyDialog(context, "Success",
                                      "Category updated.", "");
                                });
                              }
                            },
                            child: Text("Update Category"),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff9B1D20)),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              name = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffF4FDD9), width: 5.0),
                              borderRadius: BorderRadius.circular(72),
                            ),
                            hintText: "Name of the Product",
                            hintStyle: TextStyle(
                                fontSize: 18, color: Color(0xffA30B37)),
                            alignLabelWithHint: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (name != "") {
                                Firestore.instance
                                    .collection("products")
                                    .document(widget.prodId)
                                    .setData({"prodName": name},
                                        merge: true).then((value) {
                                  showMyDialog(
                                      context, "Success", "Name updated.", "");
                                });
                              }
                            },
                            child: Text("Update Name"),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff9B1D20)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 26, horizontal: 36),
                          child: Text(
                            "Price",
                            style: TextStyle(
                                color: Color(0xff6A8D73),
                                fontSize: 28,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              price = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffF4FDD9), width: 5.0),
                              borderRadius: BorderRadius.circular(72),
                            ),
                            hintText: "Price of the Product",
                            hintStyle: TextStyle(
                                fontSize: 18, color: Color(0xffA30B37)),
                            alignLabelWithHint: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (price != "") {
                                Firestore.instance
                                    .collection("products")
                                    .document(widget.prodId)
                                    .setData({"price": price},
                                        merge: true).then((value) {
                                  showMyDialog(
                                      context, "Success", "Price updated.", "");
                                });
                              }
                            },
                            child: Text("Update Price"),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff9B1D20)),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 26, horizontal: 36),
                          child: Text(
                            "Minimum quantity allowed",
                            style: TextStyle(
                                color: Color(0xff6A8D73),
                                fontSize: 28,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0),
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              minq = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xffF4FDD9), width: 5.0),
                              borderRadius: BorderRadius.circular(72),
                            ),
                            hintText: "Min. Quantity",
                            hintStyle: TextStyle(
                                fontSize: 18, color: Color(0xffA30B37)),
                            alignLabelWithHint: true,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (minq != "") {
                                Firestore.instance
                                    .collection("products")
                                    .document(widget.prodId)
                                    .setData({"minQuantity": minq},
                                        merge: true).then((value) {
                                  showMyDialog(context, "Success",
                                      "Minimum Quantity updated.", "");
                                });
                              }
                            },
                            child: Text("Update Name"),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xff9B1D20)),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 47.0),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      color: Color(0xffFFE8C2),
                                      child: (imageFile == null)
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Choose Image",
                                                style: TextStyle(
                                                    color: Color(0xffF0A868)),
                                              ),
                                            )
                                          : Image.file(File(imageFile.path)),
                                    ),
                                  ),
                                  RaisedButton(
                                    onPressed: () async {
                                      _showChoiceDialog(context);
                                    },
                                    child: Text("Select Image"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        uploadImageToFirebase(context);
                                      },
                                      child: Text("Update Image"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff9B1D20)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 25,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }

  Future<String> uploadImageToFirebase(BuildContext context) async {
    if (imageFile == null) {
      showMyDialog(context, "Error", "Image file not uploaded", "");
      setState(() {
        load = false;
      });
    }
    File _imageFile = File(imageFile.path);
    String fileName = basename(_imageFile.path);
    String url = "";
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    print("loading url");
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    print(dowurl);
    url = dowurl.toString();
    print(url);
    if (url != "") {
      Firestore.instance
          .collection("products")
          .document(widget.prodId)
          .setData({"photo": url}, merge: true).then((value) {
        showMyDialog(context, "Success", "Image updated.", "");
      });
    }
  }
}

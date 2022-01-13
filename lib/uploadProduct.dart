import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:mymarket/services/database.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:mymarket/services/widgets.dart';

class UploadProducts extends StatefulWidget {
  const UploadProducts();

  @override
  _UploadProductsState createState() => _UploadProductsState();
}

class _UploadProductsState extends State<UploadProducts> {
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
  String dropdownvalue = 'Grocery';
  var items = [
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
      backgroundColor: Color(0xffBBD5ED),
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Color(0xffA288E3),
      ),
      body: ModalProgressHUD(
        inAsyncCall: load,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(27.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                  child: Text(
                    "Product",
                    style: TextStyle(
                        color: Color(0xffA288E3),
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
                TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffCCFFCB), width: 5.0),
                      borderRadius: BorderRadius.circular(72),
                    ),
                    hintText: "Name of the Product",
                    hintStyle:
                        TextStyle(fontSize: 18, color: Color(0xffCEFDFF)),
                    alignLabelWithHint: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                  child: Text(
                    "Price",
                    style: TextStyle(
                        color: Color(0xffA288E3),
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
                      borderSide: BorderSide(color: Color(0xffCCFFCB), width: 5.0),
                      borderRadius: BorderRadius.circular(72),
                    ),
                    hintText: "Price of the Product",
                    hintStyle:
                        TextStyle(fontSize: 18, color: Color(0xffCEFDFF)),
                    alignLabelWithHint: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                  child: Text(
                    "Minimum quantity allowed",
                    style: TextStyle(
                        color: Color(0xffA288E3),
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
                      borderSide: BorderSide(color: Color(0xffCCFFCB), width: 5.0),
                      borderRadius: BorderRadius.circular(72),
                    ),
                    hintText: "Min. Quantity",
                    hintStyle:
                        TextStyle(fontSize: 18, color: Color(0xffCEFDFF)),
                    alignLabelWithHint: true,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 47.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Color(0xff38023B),
                              child: (imageFile == null)
                                  ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Choose Image", style: TextStyle(color: Color(0xffA288E3)),),
                                  )
                                  : Image.file(File(imageFile.path)),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              _showChoiceDialog(context);
                            },
                            child: Text("Select Image"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(37),
                  child: RaisedButton(
                      onPressed: () async {
                        setState(() {
                          load = true;
                        });
                        uploadImageToFirebase(context);
                      },
                      child: Text(
                        'Add the Product',
                        style: TextStyle(color: Color(0xffBBD5ED)),
                      ),
                      color: Color(0xffCEFDFF),
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      )),
                )
              ],
            ),
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

    if (name != "" && price != "" && minq != "" && url != "") {
      Map<String, dynamic> data = {
        "prodName": name,
        "price": price,
        "minQuantity": minq,
        "photo": url,
        "category": dropdownvalue,
        "uploadedBy": (await FirebaseAuth.instance.currentUser()).uid
      };

      Database().uploadProduct(data);
      showMyDialog(context, "Success", "Product added to database", "")
          .then((value) {
        setState(() {
          load = false;
          Navigator.pop(context);
        });
      });
    } else {
      showMyDialog(context, "Error", "Fill in all the fields.", "");
    }
  }
}

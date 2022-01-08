import 'package:flutter/material.dart';

class AdminProducts extends StatefulWidget {
  const AdminProducts();

  @override
  _AdminProductsState createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Products"),
        backgroundColor: Color(0xff2A2A72),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: (){

                  }, child: Text("Upload Item")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
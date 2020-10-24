import 'package:flutter/material.dart';
import 'package:fluttercontact/view/contact_page.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacts")),
      body: Center(
        child: Text("No Contact yet"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ContactPage()),
          );
        },
      ),
    );
  }
}

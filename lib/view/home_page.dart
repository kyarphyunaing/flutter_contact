import 'package:flutter/material.dart';
import 'package:fluttercontact/db/dao/contact_dao.dart';
import 'package:fluttercontact/db/entity/contact.dart';
import 'package:fluttercontact/view/contact_page.dart';
import 'package:provider/provider.dart';

import 'edit_contact_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _contactDao = Provider.of<ContactDao>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Contact Book")),
      body: Container(
          child: StreamBuilder(
        stream: _contactDao.getAllContact(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data.isEmpty){
              return Center(
                child: Image.asset('assets/img/contact.svg',
                width: 100,
                height: 100)
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCard(
                      contact: snapshot.data[index],
                      context: context,
                      contactDao: _contactDao);
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error!"),
            );
          } else {
            return Center(
              child: Text("Loading ... "),
            );
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.contacts),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ContactPage()),
          );
        },
      ),
    );
  }

  Card _buildCard(
      {Contact contact, BuildContext context, ContactDao contactDao}) {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            contact.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            contact.telephone,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
        leading:IconButton(
            icon: Icon(Icons.contacts_outlined,color: Colors.blue),
        // Container(
         // child: //Image.asset('assets/img/contact.svg',
              //width: 40,
              //height: 40),
          ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit,color: Colors.blue),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditContactPage(),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.
                    settings: RouteSettings(arguments: contact),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete,color: Colors.blue),
              onPressed: () {
                showAlertDialog(context, contactDao, contact);
              },
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(
      BuildContext context, ContactDao contactDao, Contact contact) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Confirm"),
      onPressed: () async {
        await contactDao.deleteContact(contact);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Contact"),
      content: Text("Are you sure you want to delete?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

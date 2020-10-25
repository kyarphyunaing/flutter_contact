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
      appBar: AppBar(title: Text("Contacts")),
      body: Container(
          child: StreamBuilder(
        stream: _contactDao.getAllContact(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.hasData) {
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
        child: Icon(Icons.add),
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
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditContactPage(),
                    // Pass the arguments as part of the RouteSettings. The
                    // DetailScreen reads the arguments from these settings.
                    settings: RouteSettings(
                      arguments: contact
                    ),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
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
      child: Text("Continue"),
      onPressed: () async {
        await contactDao.deleteContact(contact);
        Navigator.pop(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to delete?"),
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

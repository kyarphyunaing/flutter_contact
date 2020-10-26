import 'package:flutter/material.dart';
import 'package:fluttercontact/db/dao/contact_dao.dart';
import 'package:fluttercontact/db/entity/contact.dart';
import 'package:provider/provider.dart';
class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _contactDao=Provider.of<ContactDao>(context);
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text("Contact Info"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
              Center(
                  child: Image.asset('assets/img/contact.svg',
                          width: 80,
                          height: 80)
              ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 2)
                )
              ),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                  hintText: "Telephone",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                  )
              ),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(width: 2)
                  )
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                if(_nameController.text!="" && _phoneController.text!="" && _emailController.text!=""){
                  await _contactDao.insertContact(Contact(id:null,name: _nameController.text,telephone: _phoneController.text,email: _emailController.text));
                  Navigator.pop(context);
                }

                print(_nameController.text);
              },
              child: Text('Create Contact'),
            ),
          ],
        )
      )
      );
  }
}

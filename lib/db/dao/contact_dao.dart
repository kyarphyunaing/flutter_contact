import 'package:floor/floor.dart';
import 'package:fluttercontact/db/entity/contact.dart';
@dao
abstract class ContactDao {
  @Query("SELECT * FROM contact")
  Future<List<Contact>> getAllContact();

  @Query("SELECT * FROM contact where id =: id")
  Future<Contact> findContactById(int id);

  @insert
  Future<void> insertContact(Contact contact);

  @update
  Future<int> updateContact(Contact contact);

  @delete
  Future<void> deleteContact(int id);

}
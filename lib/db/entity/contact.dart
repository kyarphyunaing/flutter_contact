import 'package:floor/floor.dart';
@entity
class Contact{
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String name;
  final String telephone;
  final String email;

  Contact({this.id, this.name, this.telephone, this.email});

}
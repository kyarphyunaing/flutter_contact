import 'package:floor/floor.dart';
import 'package:fluttercontact/db/dao/contact_dao.dart';
import 'package:fluttercontact/db/entity/contact.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'db.g.dart';

@Database(version: 1, entities: [Contact])
abstract class AppDatabase extends FloorDatabase {
  ContactDao get contactDao;
}

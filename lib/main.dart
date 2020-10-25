import 'package:flutter/material.dart';
import 'package:fluttercontact/db/db.dart';
import 'package:fluttercontact/view/home_page.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:provider/provider.dart';
import 'db/dao/contact_dao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _injector = Injector.getInjector();
  final database = await $FloorAppDatabase.databaseBuilder("test.db").build();
  _injector.map<AppDatabase>((_) => database);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _injector = Injector.getInjector();
  AppDatabase get _database => _injector.get<AppDatabase>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ContactDao>(
            create:(context)=>_database.contactDao
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}

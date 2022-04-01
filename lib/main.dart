import 'package:flutter/material.dart';

import 'package:hive_admon/homepage.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void>main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
   Box box = await Hive.openBox("Contact_list");


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}


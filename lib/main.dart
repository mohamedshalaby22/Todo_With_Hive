import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/models/model_task.dart';
import 'package:flutter_application_1/screens/my_home.dart';
import 'package:hive_flutter/adapters.dart';

late Box box;
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Task>(TaskAdapter());
  box = await Hive.openBox<Task>("tasks");
  // box.add(Task(
  //     title: 'this is First Task',
  //     note: 'We Will Test Our First Note In flutter Note App',
  //     creation_date: DateTime.now()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              elevation: 0.0,
              backgroundColor: Colors.white,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark))),
      // ignore: prefer_const_constructors
      home: MyHome(),
    );
  }
}

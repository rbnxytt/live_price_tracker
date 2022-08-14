import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sample_hive/app_controller.dart';
import 'package:sample_hive/model/data_model.dart';

import 'home_page.dart';

late Box box;
Future main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Data>(DataAdapter());
  box = await Hive.openBox<Data>("data");

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const HomePage(),
      ),
    );
  }
}

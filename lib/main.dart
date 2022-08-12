import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sample_hive/custom_line_chart.dart';
import 'package:sample_hive/model/data_model.dart';

late Box box;
void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter<Data>(DataAdapter());
  box = await Hive.openBox<Data>("data");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Price Tracker - Pigs'),
      ),
      body: ValueListenableBuilder<Box<Data>>(
        valueListenable: Hive.box<Data>("data").listenable(),
        builder: (context, box, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: CustomLineChart())),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Latest Pig Price as of ${DateFormat('EEEE , MMMM d, yyyy').format(box.getAt(box.values.length - 1)!.date!)}',
                          ),
                        ),
                      ),
                      Row(
                        children: const [
                          Text('My Watchlist'),
                          Icon(Icons.keyboard_arrow_down_outlined)
                        ],
                      ),
                      Row(
                        children: const [
                          Expanded(
                            child: SizedBox(
                              child: Text('Market'),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Text('Current Price'),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Text('Previous Price'),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(child: Text('Change %')),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) => Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                      child: Text(box
                                          .getAt(box.values.length - 1 - index)!
                                          .city!))),
                              Expanded(
                                  child: SizedBox(
                                      child: Text(box
                                          .getAt(box.values.length - 1 - index)!
                                          .price
                                          .toString()))),
                              Expanded(
                                  child: SizedBox(
                                      child: box.values.length - index < 5
                                          ? const Text('-')
                                          : Text(box
                                              .getAt(box.values.length -
                                                  index -
                                                  6)!
                                              .price
                                              .toString()))),
                              Expanded(
                                child: SizedBox(
                                    child: box.values.length - index < 5
                                        ? const Text('-')
                                        : Text(
                                            '${(((box.getAt(box.values.length - 1 - index)!.price! / box.getAt(box.values.length - index - 6)!.price!) - 1) * 100).toStringAsFixed(2)} %')),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sample_hive/custom_line_chart.dart';

void main() {
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
  final List cityList = [
    'Guangzhou',
    'Maoming',
    'Foshan',
    'Shenzhen',
    'Huizhou'
  ];

  final List priceList = [12.1, 11.8, 11.8, 11.8, 11.8];
  final List dateList = [
    '08/4/2022',
    '08/4/2022',
    '08/4/2022',
    '08/4/2022',
    '08/4/2022',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Price Tracker - Pigs'),
      ),
      body: Column(
        children: [
          const CustomLineChart(),
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: SizedBox(
                        child: Text('Date'),
                      ),
                    ),
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
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      itemCount: cityList.length,
                      itemBuilder: (context, index) => Row(
                            children: [
                              Expanded(
                                  child:
                                      SizedBox(child: Text(dateList[index]))),
                              Expanded(
                                  child:
                                      SizedBox(child: Text(cityList[index]))),
                              Expanded(
                                  child: SizedBox(
                                      child:
                                          Text(priceList[index].toString()))),
                              Expanded(
                                  child: SizedBox(
                                      child:
                                          Text(priceList[index].toString()))),
                              Expanded(
                                  child: SizedBox(
                                      child: Text(priceList[index].toString())))
                            ],
                          )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

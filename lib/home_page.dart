import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sample_hive/main.dart';
import 'package:sample_hive/update_button.dart';

import 'constants.dart';
import 'custom_line_chart.dart';
import 'model/data_model.dart';
import 'widgets/my_divider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController? _scrollController;
  TextEditingController? _priceTextController1;
  TextEditingController? _priceTextController2;
  TextEditingController? _priceTextController3;
  TextEditingController? _priceTextController4;
  TextEditingController? _priceTextController5;

  @override
  void initState() {
    checkInitialvalue();
    _scrollController = ScrollController();
    _priceTextController1 = TextEditingController();
    _priceTextController2 = TextEditingController();
    _priceTextController3 = TextEditingController();
    _priceTextController4 = TextEditingController();
    _priceTextController5 = TextEditingController();

    super.initState();
  }

  void checkInitialvalue() {
    if (box.values.isEmpty) {
      for (int i = 0; i < priceList.length; i++) {
        int position = i < 5
            ? i
            : i < 10
                ? i - 5
                : i < 15
                    ? i - 10
                    : i < 20
                        ? i - 15
                        : i < 25
                            ? i - 20
                            : i - 25;
        box.add(Data(
            city: cities[position],
            date: initialDates[position],
            price: priceList[i]));
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    _priceTextController1!.dispose();
    _priceTextController2!.dispose();
    _priceTextController3!.dispose();
    _priceTextController4!.dispose();
    _priceTextController5!.dispose();
    box.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 30.0),
        child: SizedBox(
          height: 100.0,
          width: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                color: Colors.greenAccent,
                icon: const Icon(Icons.delete_forever),
                onPressed: () {
                  showDeleteConfirmation(context);
                },
              ),
              const Text(
                'Delete',
                style: TextStyle(color: Colors.greenAccent),
              )
            ],
          ),
        ),
      ),
      backgroundColor: defaultBackground,
      appBar: AppBar(
        title: const Text('Live Price Tracker - Pigs'),
      ),
      body: ValueListenableBuilder<Box<Data>>(
        valueListenable: Hive.box<Data>("data").listenable(),
        builder: (context, box, _) {
          return Padding(
            padding: const EdgeInsets.all(50.0),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.line_axis_rounded,
                                        color: Colors.greenAccent,
                                        size: 25,
                                      ),
                                      Text(
                                        'Price Trend',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 300.0,
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            'Trend View',
                                            style: TextStyle(
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.greenAccent),
                                          ),
                                          const VerticalDivider(
                                            color: Colors.white,
                                            width: 1.0,
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                              'Weekly',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                              'Monthly',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {},
                                            child: const Text(
                                              '1Y',
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Expanded(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 50.0),
                                child: CustomLineChart(),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(
                                    'Latest Pig Prices as of ${DateFormat('EEEE , MMMM d, yyyy').format(box.getAt(box.values.length - 1)!.date ?? DateTime.now())}',
                                    style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: const [
                                    Text(
                                      'My Watchlist',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18.0,
                                          color: Colors.blueAccent),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.grey,
                                    )
                                  ],
                                ),
                                UpdateButton(
                                  refresh: () {
                                    setState(() {});
                                  },
                                  box: box,
                                  priceTextController1: _priceTextController1!,
                                  priceTextController2: _priceTextController2!,
                                  priceTextController3: _priceTextController3!,
                                  priceTextController4: _priceTextController4!,
                                  priceTextController5: _priceTextController5!,
                                )
                              ],
                            ),
                            const MyDivider(),

                            // Table heading labels.
                            Row(
                              children: [
                                for (String tableHeader in tableHeaderTexts)
                                  Expanded(
                                    child: SizedBox(
                                      child: Text(
                                        tableHeader,
                                        style: tableHeaderStyle,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(
                              // List of data saved in box represented by a table.
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  String market = box
                                      .getAt(box.values.length - 1 - index)!
                                      .city!;

                                  String currentPrice = box
                                      .getAt(box.values.length - 1 - index)!
                                      .price
                                      .toString();

                                  String previousPrice = box
                                      .getAt(box.values.length - index - 6)!
                                      .price
                                      .toString();

                                  double difference =
                                      double.parse(currentPrice) -
                                          double.parse(previousPrice);

                                  String change = (((box
                                                      .getAt(box.values.length -
                                                          1 -
                                                          index)!
                                                      .price! /
                                                  box
                                                      .getAt(box.values.length -
                                                          index -
                                                          6)!
                                                      .price!) -
                                              1) *
                                          100)
                                      .toStringAsFixed(2);

                                  bool isNegative = double.parse(change) < 0;

                                  String rateOfChange() {
                                    return change == '0.00' ? ' -' : change;
                                  }

                                  Icon indicator() => difference < 0
                                      ? const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.red,
                                        )
                                      : difference == 0
                                          ? const Icon(
                                              Icons.line_axis,
                                              color: Colors.blue,
                                            )
                                          : const Icon(
                                              Icons.arrow_drop_up,
                                              color: Colors.green,
                                            );

                                  return Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(
                                          child: Text(
                                            market,
                                            style: marketTextStyle,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: Row(
                                            children: [
                                              indicator(),
                                              Text(
                                                currentPrice,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w700,
                                                    color: isNegative
                                                        ? Colors.red
                                                        : change == '0.00'
                                                            ? Colors.blue
                                                            : Colors.green),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Text(
                                                  change == '0.00'
                                                      ? ''
                                                      : isNegative
                                                          ? difference
                                                              .toStringAsFixed(
                                                                  2)
                                                          : '+${difference.toStringAsFixed(2)}',
                                                  style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: isNegative
                                                          ? Colors.redAccent
                                                          : Colors.greenAccent),
                                                  textAlign: TextAlign.end,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: box.values.length - index < 5
                                              ? const Text('-')
                                              : Text(
                                                  previousPrice,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: priceFontSize,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          child: box.values.length - index < 5
                                              ? const Text('-')
                                              : Row(
                                                  children: [
                                                    difference < 0
                                                        ? const Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Colors.red,
                                                          )
                                                        : difference == 0
                                                            ? const Text('')
                                                            : const Icon(
                                                                Icons
                                                                    .arrow_drop_up,
                                                                color: Colors
                                                                    .green,
                                                              ),
                                                    Text('${rateOfChange()} %',
                                                        style: TextStyle(
                                                            color: isNegative
                                                                ? Colors.red
                                                                : rateOfChange() ==
                                                                        ' -'
                                                                    ? Colors
                                                                        .lightBlue
                                                                    : Colors
                                                                        .green,
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<dynamic> showDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        title: const Text('Are you sure you want to delete the last entry?'),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.grey),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              for (int i = 0; i < 5; i++) {
                box.deleteAt(box.values.length - 1);
              }
              Navigator.pop(context);
              var snackBar = const SnackBar(
                content: Text('Reset Succesful'),
                backgroundColor: Colors.greenAccent,
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            child: const Text('Confirm'),
          )
        ],
      ),
    );
  }
}

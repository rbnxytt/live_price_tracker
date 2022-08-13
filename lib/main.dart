import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sample_hive/constants.dart';
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
      debugShowCheckedModeBanner: false,
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
      box.add(
          Data(city: 'Guangzhou', date: DateTime(2022, 8, 4), price: 11.92));
      box.add(Data(city: 'Shenzhen', date: DateTime(2022, 8, 4), price: 11.5));
      box.add(Data(city: 'Huizhou', date: DateTime(2022, 8, 4), price: 11.05));
      box.add(Data(city: 'Maoming', date: DateTime(2022, 8, 4), price: 11.8));
      box.add(Data(city: 'Foshan', date: DateTime(2022, 8, 4), price: 11.93));

      box.add(Data(city: 'Guangzhou', date: DateTime(2022, 8, 5), price: 11.8));
      box.add(Data(city: 'Shenzhen', date: DateTime(2022, 8, 5), price: 11.5));
      box.add(Data(city: 'Huizhou', date: DateTime(2022, 8, 5), price: 11.6));
      box.add(Data(city: 'Maoming', date: DateTime(2022, 8, 5), price: 12.1));
      box.add(Data(city: 'Foshan', date: DateTime(2022, 8, 5), price: 12.1));

      box.add(Data(city: 'Guangzhou', date: DateTime(2022, 8, 6), price: 11.8));
      box.add(Data(city: 'Shenzhen', date: DateTime(2022, 8, 6), price: 11.5));
      box.add(Data(city: 'Huizhou', date: DateTime(2022, 8, 6), price: 12));
      box.add(Data(city: 'Maoming', date: DateTime(2022, 8, 6), price: 12.1));
      box.add(Data(city: 'Foshan', date: DateTime(2022, 8, 6), price: 12.13));

      box.add(Data(city: 'Guangzhou', date: DateTime(2022, 8, 7), price: 11.8));
      box.add(Data(city: 'Shenzhen', date: DateTime(2022, 8, 7), price: 11.5));
      box.add(Data(city: 'Huizhou', date: DateTime(2022, 8, 7), price: 12.04));
      box.add(Data(city: 'Maoming', date: DateTime(2022, 8, 7), price: 12));
      box.add(Data(city: 'Foshan', date: DateTime(2022, 8, 7), price: 12.12));

      box.add(Data(city: 'Guangzhou', date: DateTime(2022, 8, 8), price: 11.8));
      box.add(Data(city: 'Shenzhen', date: DateTime(2022, 8, 8), price: 11.5));
      box.add(Data(city: 'Huizhou', date: DateTime(2022, 8, 8), price: 12.04));
      box.add(Data(city: 'Maoming', date: DateTime(2022, 8, 8), price: 12));
      box.add(Data(city: 'Foshan', date: DateTime(2022, 8, 8), price: 12.06));

      box.add(Data(city: 'Guangzhou', date: DateTime(2022, 8, 9), price: 11.8));
      box.add(Data(city: 'Shenzhen', date: DateTime(2022, 8, 9), price: 11.5));
      box.add(Data(city: 'Huizhou', date: DateTime(2022, 8, 9), price: 12.06));
      box.add(Data(city: 'Maoming', date: DateTime(2022, 8, 9), price: 11.8));
      box.add(Data(city: 'Foshan', date: DateTime(2022, 8, 9), price: 11.86));
    }
    setState(() {});
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
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: Divider(
                                height: 0.5,
                                color: Colors.blueAccent,
                              ),
                            ),

                            // Table heading labels.
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      'Market',
                                      style: tableHeaderStyle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      'Current Price (RMB)',
                                      style: tableHeaderStyle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      'Previous Price',
                                      style: tableHeaderStyle,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    child: Text(
                                      'Change %',
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
                                                        .getAt(
                                                            box.values.length -
                                                                1 -
                                                                index)!
                                                        .price! /
                                                    box
                                                        .getAt(
                                                            box.values.length -
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
                                                difference < 0
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
                                                          ),
                                                Text(
                                                  currentPrice,
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: isNegative
                                                          ? Colors.red
                                                          : change == '0.00'
                                                              ? Colors.blue
                                                              : Colors.green),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
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
                                                            : Colors
                                                                .greenAccent),
                                                    textAlign: TextAlign.end,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                                child: box.values.length -
                                                            index <
                                                        5
                                                    ? const Text('-')
                                                    : Text(
                                                        previousPrice,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize:
                                                                priceFontSize,
                                                            color: Colors.grey),
                                                      ))),
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
                                                      Text(
                                                          '${rateOfChange()} %',
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
                                  }),
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
}

class UpdateButton extends StatelessWidget with InputValidationMixin {
  const UpdateButton({
    Key? key,
    required this.priceTextController1,
    required this.priceTextController2,
    required this.priceTextController3,
    required this.priceTextController4,
    required this.priceTextController5,
    required this.box,
    required this.refresh,
  }) : super(key: key);

  final TextEditingController priceTextController1;
  final TextEditingController priceTextController2;
  final TextEditingController priceTextController3;
  final TextEditingController priceTextController4;
  final TextEditingController priceTextController5;
  final Box box;
  final void Function() refresh;

  @override
  Widget build(BuildContext context) {
    final formGlobalKey = GlobalKey<FormState>();
    void addData(
        context,
        TextEditingController textController1,
        TextEditingController textController2,
        TextEditingController textController3,
        TextEditingController textController4,
        TextEditingController textController5,
        refresh()) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          DateTime? addDate;
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: defaultBackground.withOpacity(0.3),
            body: Center(
              child: SizedBox(
                height: 800,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    color: defaultBackground,
                    child: Form(
                      key: formGlobalKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                              child: Text(
                            'Pick A Date to Update',
                            style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          )),
                          CustomAnimatedContainer(
                            child: CalendarDatePicker(
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2022, 8, 1),
                                lastDate: DateTime.now(),
                                onDateChanged: (date) {
                                  addDate = date;
                                }),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Center(
                                  child: Text(
                                    'Update Prices',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: textController1,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter Price',
                                        label: Text('Guangzhou'),
                                        labelStyle: TextStyle(
                                            color: Colors.greenAccent)),
                                    validator: (textController1) {
                                      if (isPriceValid(textController1!)) {
                                        return null;
                                      } else {
                                        return 'Invalid Value';
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: textController2,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter Price',
                                        label: Text('Shenzhen'),
                                        labelStyle: TextStyle(
                                            color: Colors.greenAccent)),
                                    validator: (textController2) {
                                      if (isPriceValid(textController2!)) {
                                        return null;
                                      } else {
                                        return 'Invalid Value';
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: textController3,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter Price',
                                        label: Text('Huizhou'),
                                        labelStyle: TextStyle(
                                            color: Colors.greenAccent)),
                                    validator: (textController3) {
                                      if (isPriceValid(textController3!)) {
                                        return null;
                                      } else {
                                        return 'Invalid Value';
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: textController4,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter Price',
                                        label: Text('Maoming'),
                                        labelStyle: TextStyle(
                                            color: Colors.greenAccent)),
                                    validator: (textController4) {
                                      if (isPriceValid(textController4!)) {
                                        return null;
                                      } else {
                                        return 'Invalid Value';
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: textController5,
                                    decoration: const InputDecoration(
                                        hintText: 'Enter Price',
                                        label: Text('Foshan'),
                                        labelStyle: TextStyle(
                                            color: Colors.greenAccent)),
                                    validator: (textController5) {
                                      if (isPriceValid(textController5!)) {
                                        return null;
                                      } else {
                                        return 'Invalid Value';
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          SizedBox(
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Back',
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      try {
                                        if (formGlobalKey.currentState!
                                            .validate()) {
                                          formGlobalKey.currentState!.save();

                                          box.get(Data(
                                              city: 'Guangzhou',
                                              date: addDate,
                                              price: double.parse(
                                                  textController1.text)));

                                          box.add(Data(
                                              city: 'Guangzhou',
                                              date: addDate,
                                              price: double.parse(
                                                  textController1.text)));
                                          box.add(Data(
                                              city: 'Shenzhen',
                                              date: addDate,
                                              price: double.parse(
                                                  textController2.text)));
                                          box.add(Data(
                                              city: 'Huizhou',
                                              date: addDate,
                                              price: double.parse(
                                                  textController3.text)));
                                          box.add(Data(
                                              city: 'Maoming',
                                              date: addDate,
                                              price: double.parse(
                                                  textController4.text)));
                                          box.add(Data(
                                              city: 'Foshan',
                                              date: addDate,
                                              price: double.parse(
                                                  textController5.text)));
                                          refresh();
                                          Navigator.pop(context);
                                          var snackbar = const SnackBar(
                                            content: Text(
                                                'Prices Updated Successfully'),
                                            backgroundColor: Colors.greenAccent,
                                            behavior: SnackBarBehavior.floating,
                                          );

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        }
                                      } on FormatException {
                                        var snackbar = const SnackBar(
                                          content: Text('Invalid Price'),
                                          backgroundColor: Colors.greenAccent,
                                          behavior: SnackBarBehavior.floating,
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      }
                                    },
                                    child: const Text("Submit")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return TextButton(
      onPressed: () {
        addData(
            context,
            priceTextController1,
            priceTextController2,
            priceTextController3,
            priceTextController4,
            priceTextController5,
            refresh);
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: const [
            Icon(
              Icons.edit,
              color: Colors.greenAccent,
              size: 20.0,
            ),
            Text(
              'Update',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

mixin InputValidationMixin {
  bool isPriceValid(String price) => double.parse(price).isFinite;
}

class CustomAnimatedContainer extends StatelessWidget {
  const CustomAnimatedContainer({Key? key, required this.child})
      : super(key: key);
  final Widget child;
  final double _width = double.infinity;
  final double _height = 300.0;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: _width,
      height: _height,
      curve: Curves.fastOutSlowIn,
      child: child,
    );
  }
}

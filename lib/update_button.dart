import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'constants.dart';
import 'custom_animated_container.dart';
import 'model/data_model.dart';

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
        Function() refresh) {
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
                              child: Padding(
                            padding: EdgeInsets.only(top: 50.0),
                            child: Text(
                              'Pick A Date to Update',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                          )),
                          CustomAnimatedContainer(
                            child: CalendarDatePicker(
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022, 8, 1),
                              lastDate: DateTime.now(),
                              onDateChanged: (date) {
                                addDate = date;
                              },
                            ),
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
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0),
                                    child: TextFormField(
                                      controller: textController1,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Price',
                                          label: const Text('Guangzhou'),
                                          labelStyle: TextStyle(
                                              fontSize: labelSize,
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
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0),
                                    child: TextFormField(
                                      controller: textController2,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Price',
                                          label: const Text('Shenzhen'),
                                          labelStyle: TextStyle(
                                              fontSize: labelSize,
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
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0),
                                    child: TextFormField(
                                      controller: textController3,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Price',
                                          label: const Text('Huizhou'),
                                          labelStyle: TextStyle(
                                              fontSize: labelSize,
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
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0),
                                    child: TextFormField(
                                      controller: textController4,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Price',
                                          label: const Text('Maoming'),
                                          labelStyle: TextStyle(
                                              fontSize: labelSize,
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
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50.0),
                                    child: TextFormField(
                                      controller: textController5,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Price',
                                          label: const Text('Foshan'),
                                          labelStyle: TextStyle(
                                              fontSize: labelSize,
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
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: SizedBox(
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

                                          List<String> currentPricesList = [
                                            textController1.text,
                                            textController2.text,
                                            textController3.text,
                                            textController4.text,
                                            textController5.text,
                                          ];

                                          for (int i = 0;
                                              i < currentPricesList.length;
                                              i++) {
                                            box.add(
                                              Data(
                                                city: cities[i],
                                                date: addDate,
                                                price: double.parse(
                                                  currentPricesList[i],
                                                ),
                                              ),
                                            );
                                          }

                                          refresh(); // refresh and updates data on screen.

                                          Navigator.pop(context);

                                          // Shows confirmation of the price change to the user.
                                          var snackbar = mySnackBar(
                                              'Prices Updated Successfully.');

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackbar);
                                        }
                                      } on FormatException {
                                        var snackbar =
                                            mySnackBar('Invalid Value');

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      }
                                    },
                                    child: const Text("Submit"),
                                  ),
                                ],
                              ),
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

  SnackBar mySnackBar(String text) {
    return SnackBar(
      content: Text(text),
      backgroundColor: Colors.greenAccent,
      behavior: SnackBarBehavior.floating,
    );
  }
}

mixin InputValidationMixin {
  bool isPriceValid(String price) => double.parse(price).isFinite;
}

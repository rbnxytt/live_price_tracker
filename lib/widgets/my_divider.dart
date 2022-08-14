import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Divider(
        height: 0.5,
        color: Colors.blueAccent,
      ),
    );
  }
}

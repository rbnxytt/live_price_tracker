import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_controller.dart';

class CustomAnimatedContainer extends StatelessWidget {
  const CustomAnimatedContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  final double _width = double.infinity;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: _width,
      height: Provider.of<AppController>(context).height,
      curve: Curves.fastOutSlowIn,
      child: child,
    );
  }
}

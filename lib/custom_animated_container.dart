import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_controller.dart';

class CustomAnimatedContainer extends StatefulWidget {
  const CustomAnimatedContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  State<CustomAnimatedContainer> createState() =>
      _CustomAnimatedContainerState();
}

class _CustomAnimatedContainerState extends State<CustomAnimatedContainer> {
  final double _width = double.infinity;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1500),
      width: _width,
      height: Provider.of<AppController>(context).height,
      curve: Curves.fastOutSlowIn,
      child: widget.child,
    );
  }
}

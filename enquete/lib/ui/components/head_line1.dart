import 'package:flutter/material.dart';

class HeadLine1 extends StatelessWidget {
  final String title;

  const HeadLine1({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

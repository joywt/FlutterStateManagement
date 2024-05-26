import 'package:flutter/material.dart';

class NoStatePage extends StatelessWidget {
  const NoStatePage(
      {Key? key,
      required this.text,
      this.backgroundColor = const Color(0xFF42A5F5)})
      : super(key: key);

  final String text;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No State Page'),
      ),
      body: Center(
          child: Container(
        color: backgroundColor,
        child: Text(text),
      )),
    );
  }
}

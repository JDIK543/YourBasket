// ignore_for_file: file_names

import 'package:flutter/material.dart';

class SamplePage extends StatelessWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SamplePage'),
        centerTitle: true,
        backgroundColor: (Colors.lightGreen),
      ),
    );
  }
}

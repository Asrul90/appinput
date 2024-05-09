import 'package:flutter/material.dart';

class Halaman_Input extends StatefulWidget {
  const Halaman_Input({super.key});

  @override
  State<Halaman_Input> createState() => _Halaman_InputState();
}

class _Halaman_InputState extends State<Halaman_Input> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dasbord'),
        backgroundColor: Colors.amber,
      ),
      body: Text('tess'),
    );
  }
}

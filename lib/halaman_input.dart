import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Halaman_Input extends StatefulWidget {
  const Halaman_Input({super.key});

  @override
  State<Halaman_Input> createState() => _Halaman_InputState();
}

class _Halaman_InputState extends State<Halaman_Input> {
  List _listdata = [];
  bool _loading = true;

  Future _getdata() async {
    try {
      final respon =
          await http.get(Uri.parse('http://192.168.11.160/api_input/read.php'));
      if (respon.statusCode == 200) {
        final data = jsonEncode(respon.body);
        setState(() {
          _listdata = data as List;
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    _getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dasbord'),
        backgroundColor: Colors.amber,
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_listdata[index]['nama']),
                    subtitle: Text(_listdata[index]['alamat']),
                  ),
                );
              }),
    );
  }
}

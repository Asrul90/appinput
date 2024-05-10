import 'dart:convert';

import 'package:appinput/detail_cafe.dart';
import 'package:appinput/edit.dart';
import 'package:appinput/lihat_cafe.dart';
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
          await http.get(Uri.parse('http://192.168.100.76/api_input/read.php'));
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

  Future _hapus(String id) async {
    try {
      final respon = await http
          .post(Uri.parse('http://192.168.100.76/api_input/delete.php'), body: {
        "id": id,
      });
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailCafe(
                                    ListData: {
                                      'id': _listdata[index]['id'],
                                      'nama': _listdata[index]['nama'],
                                      'alamat': _listdata[index]['alamat'],
                                      'notlp': _listdata[index]['notlp'],
                                      'saran': _listdata[index]['saran'],
                                    },
                                  )));
                    },
                    child: ListTile(
                      title: Text(_listdata[index]['nama']),
                      subtitle: Text(_listdata[index]['alamat']),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Edit(
                                            ListData: {
                                              'id': _listdata[index]['id'],
                                              'nama': _listdata[index]['nama'],
                                              'alamat': _listdata[index]
                                                  ['alamat'],
                                              'notlp': _listdata[index]
                                                  ['notlp'],
                                              'saran': _listdata[index]
                                                  ['saran'],
                                            },
                                          )));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: ((context) {
                                      return AlertDialog(
                                        content: Text("Hapus Data Ini ? "),
                                        actions: [
                                          ElevatedButton(
                                              onPressed: () {
                                                _hapus(_listdata[index]['id'])
                                                    .then((value) {
                                                  Navigator.pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: ((context) =>
                                                            Halaman_Input()),
                                                      ),
                                                      (route) => false);
                                                });
                                              },
                                              child: Text('Hapus')),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Batal')),
                                        ],
                                      );
                                    }));
                              },
                              icon: Icon(Icons.delete))
                        ],
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        child: Text(
          'CARI',
          style: TextStyle(fontSize: 18),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LihatCafe()));
        },
      ),
    );
  }
}

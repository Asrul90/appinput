import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LihatCafe extends StatefulWidget {
  const LihatCafe({super.key});

  @override
  State<LihatCafe> createState() => _LihatCafeState();
}

class _LihatCafeState extends State<LihatCafe> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();

  Future _simpan() async {
    final respon = await http
        .post(Uri.parse('http://192.168.11.160/api_input/create.php'), body: {
      'nama': nama.text,
      'alamat': alamat.text,
    });
    if (respon.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LihatCafeYangDiKunjungi"),
      ),
    );
  }
}

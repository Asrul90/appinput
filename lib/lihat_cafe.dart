import 'package:appinput/halaman_input.dart';
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
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama,
                decoration: InputDecoration(
                  hintText: "Nama Cafe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Nama Cafe Tidak Boleh Kosong!";
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: alamat,
                decoration: InputDecoration(
                  hintText: "Alamat Cafe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Alamat Cafe Tidak Boleh Kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    _simpan().then((value) {
                      if (value) {
                        final snackBar = SnackBar(
                          content: const Text("data berhasil disimpan"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text("data gagal disimpan"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    });
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => Halaman_Input())),
                        (route) => false);
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

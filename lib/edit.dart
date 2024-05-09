import 'package:appinput/halaman_input.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final Map ListData;
  const Edit({super.key, required this.ListData});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController notlp = TextEditingController();
  TextEditingController saran = TextEditingController();

  Future _update() async {
    final respon = await http
        .post(Uri.parse('http://192.168.11.160/api_input/edit.php'), body: {
      'id': id.text,
      'nama': nama.text,
      'alamat': alamat.text,
      'notlp': notlp.text,
      'saran': saran.text,
    });
    if (respon.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id.text = widget.ListData['id'];
    nama.text = widget.ListData['nama'];
    alamat.text = widget.ListData['alamat'];
    notlp.text = widget.ListData['notlp'];
    saran.text = widget.ListData['saran'];
    return Scaffold(
      appBar: AppBar(
        title: Text("EditYangDiKunjungi"),
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
                  hintText: "Ubah Cafe",
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
                  hintText: "Ubah Alamat",
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
              TextFormField(
                controller: notlp,
                decoration: InputDecoration(
                  hintText: "Ubah Kontak",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Kontak Cafe Tidak Boleh Kosong!";
                  }
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: saran,
                decoration: InputDecoration(
                  hintText: "Ubah Saran",
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
                    _update().then((value) {
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
                child: Text('UPDATE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

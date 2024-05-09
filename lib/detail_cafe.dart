import 'package:flutter/material.dart';

class DetailCafe extends StatefulWidget {
  final Map ListData;
  DetailCafe({Key? key, required this.ListData}) : super(key: key);
  // DetailCafe({super.key});

  @override
  State<DetailCafe> createState() => _DetailCafeState();
}

class _DetailCafeState extends State<DetailCafe> {
  TextEditingController id = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController notlp = TextEditingController();
  TextEditingController saran = TextEditingController();
  @override
  Widget build(BuildContext context) {
    id.text = widget.ListData['id'];
    nama.text = widget.ListData['nama'];
    alamat.text = widget.ListData['alamat'];
    notlp.text = widget.ListData['notlp'];
    saran.text = widget.ListData['saran'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text('ID'),
                  subtitle: Text(widget.ListData['id']),
                ),
                ListTile(
                  title: Text('NAMA CAFE'),
                  subtitle: Text(widget.ListData['nama']),
                ),
                ListTile(
                  title: Text('ALAMAT CAFEE'),
                  subtitle: Text(widget.ListData['alamat']),
                ),
                ListTile(
                  title: Text('KONTAK CAFE'),
                  subtitle: Text(widget.ListData['notlp']),
                ),
                ListTile(
                  title: Text('SARAN '),
                  subtitle: Text(widget.ListData['saran']),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

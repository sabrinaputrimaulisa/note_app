import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        Column,
        CrossAxisAlignment,
        EdgeInsets,
        ElevatedButton,
        FontWeight,
        Icon,
        Icons,
        InputDecoration,
        Key,
        MediaQuery,
        Navigator,
        OutlineInputBorder,
        Padding,
        Row,
        Scaffold,
        Size,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextEditingController,
        TextField,
        TextInputType,
        TextStyle,
        Widget,
        showDatePicker;
import 'package:intl/intl.dart';
import 'package:note_app/service/database_helper.dart';

class PemasukanPage extends StatefulWidget {
  const PemasukanPage({Key? key}) : super(key: key);

  @override
  State<PemasukanPage> createState() => _PemasukanPageState();
}

class _PemasukanPageState extends State<PemasukanPage> {
  final _dateController =
      TextEditingController(); // inisiasi controller tanggal
  final _nominalController =
      TextEditingController(); // inisiasi controller nominal
  final _keteranganController =
      TextEditingController(); // inisiasi controller keterangan

  // untuk menyimpan data yang dimasukkan
  void _saveData() async {
    final dateText = _dateController.text;
    final dateFormat = DateFormat('dd-MM-yyyy');

    final tanggal = dateFormat.parse(dateText);
    final nominal = int.tryParse(_nominalController.text) ?? 0;
    final keterangan = _keteranganController.text;
    final jenis = 1;
    int insertId = await DatabaseHelper.insertPemasukan(
        tanggal, nominal, keterangan, jenis);
    print(insertId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Pemasukan",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Text("Tanggal"),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: w * 0.75,
                  child: TextField(
                    readOnly: true,
                    controller: _dateController,
                    decoration: InputDecoration(
                        labelText: "Masukkan Tanggal",
                        border: OutlineInputBorder()),
                    onTap: () async {
                      // untuk menampilkan kalender supaya bisa memilih tanggal dengan date time picker
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime
                              .now(), // mengambil default waktu sekarang
                          firstDate: DateTime(2000), // tahun minimal
                          lastDate: DateTime(2099)); // tahun maksimal
                      if (pickedDate != null) {
                        String formattedDate = DateFormat('dd-MM-yyyy').format(
                            pickedDate); // mengubah format tanggal untuk ditampilkan
                        _dateController.text = formattedDate;
                      }
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.calendar_month)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("Nominal"),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _nominalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Masukkan Nominal", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            Text("Keterangan"),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: _keteranganController,
              decoration: InputDecoration(
                  labelText: "Masukkan Keterangan",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                _dateController.clear(); // menghapus inputan tanggal
                _nominalController.clear(); // menghapus inputan nominal
                _keteranganController.clear(); // menghapus inputan keterangan
              },
              child: Text("Clear"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: Size(double.infinity, 30)),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _saveData, // memanggil fungsi simpan data
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 30)),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // kembali ke layar sebelumnya
              },
              child: Text("<< Kembali"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  minimumSize: Size(double.infinity, 30)),
            ),
          ],
        ),
      ),
    );
  }
}

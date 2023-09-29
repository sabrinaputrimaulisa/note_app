import 'package:flutter/material.dart'
    show
        AlertDialog,
        AppBar,
        Border,
        BoxDecoration,
        BuildContext,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        FontWeight,
        Icon,
        IconButton,
        Icons,
        Key,
        ListTile,
        ListView,
        Navigator,
        Padding,
        Scaffold,
        SizedBox,
        State,
        StatefulWidget,
        Text,
        TextButton,
        TextStyle,
        Widget,
        showDialog;
import 'package:note_app/pages/home_page.dart';
import 'package:note_app/pages/pemasukan_page.dart';
import 'package:note_app/pages/pengeluaran_page.dart';
import 'package:note_app/service/database_helper.dart';
import 'package:intl/intl.dart';

class DetailCashFlowPage extends StatefulWidget {
  const DetailCashFlowPage({Key? key}) : super(key: key);

  @override
  State<DetailCashFlowPage> createState() => _DetailCashFlowPageState();
}

class _DetailCashFlowPageState extends State<DetailCashFlowPage> {
  List<Map<String, dynamic>> dataList = []; // inisiasi data transaksi

  @override
  void initState() {
    _fetchTransaksi();
    super.initState();
  }

  // untuk mengubah urutan data transaksi dari yang terbaru
  void _reverseDataList() {
    setState(() {
      dataList = dataList.reversed.toList();
    });
  }

  // untuk mengambil semua data transaksi
  void _fetchTransaksi() async {
    List<Map<String, dynamic>> transaksiList = await DatabaseHelper.getData();
    setState(() {
      dataList = transaksiList;
      _reverseDataList(); // memanggil fungsi untuk megubah urutan
    });
  }

  // untuk mengubah format dari tanggal
  String formatDate(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  // untuk mengambil kondisi icon dan warna untuk pemasukan dan pengeluaran
  Icon getTrailingIcon(int jenis) {
    if (jenis == 1) {
      // jenis 1 untuk pemasukan
      return Icon(
        Icons.arrow_back,
        color: Colors.green,
      );
    } else {
      // selain 1 untuk pengeluaran
      return Icon(
        Icons.arrow_forward,
        color: Colors.red,
      );
    }
  }

  // untuk mengambil kondisi simbol untuk pemasukan dan pengeluaran
  String getJenisSymbol(int jenis) {
    if (jenis == 1) {
      // jenis 1 untuk pemasukan
      return "+";
    } else {
      // selain jenis 1 untuk pengeluaran
      return "-";
    }
  }

  // untuk konfirmasi menghapus semua data transaksi
  void _confirmDeleteData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // untuk menampilkan alert jika lanjut untuk menghapus atau tidak
          title: Text("Konfirmasi Hapus Data"),
          content: Text("Anda yakin ingin menghapus semua data?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                _deleteData();
                Navigator.of(context).pop();
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }

  // untuk menghapus semua data transaksi
  void _deleteData() async {
    await DatabaseHelper.deleteAllData();
    _fetchTransaksi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Cash Flow",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _confirmDeleteData();
            },
          ),
        ],
      ),
      body: ListView.builder(
        // menampilkan list untuk semua data transaksi
        itemCount: dataList.length, // mengambil jumlah dari data transaksi
        itemBuilder: (context, index) {
          final jenis =
              dataList[index]['jenis']; // inisiasi jenis data transaksi
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "[ " +
                              getJenisSymbol(
                                  jenis) + // memanggil fungsi untuk simbol diatas sesuai jenis
                              " ] Rp. " +
                              dataList[index]['nominal']
                                  .toString(), // menampilkan nilai nominal dari database
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          dataList[index]['keterangan']
                              .toString(), // menampilkan nilai keterangan dari database
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          formatDate(DateTime.parse(dataList[index][
                              'tanggal'])), // menampilkan nilai tanggal dari database
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: getTrailingIcon(
                        jenis), // memanggil fungsi icon diatas sesuai jenis
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

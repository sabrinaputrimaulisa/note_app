import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:note_app/pages/detail_cash_flow_page.dart';
import 'package:note_app/pages/pemasukan_page.dart';
import 'package:note_app/pages/pengaturan_page.dart';
import 'package:note_app/pages/pengeluaran_page.dart';
import 'package:note_app/service/database_helper.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {
  int totalPemasukan = 0; // inisiasi total pemasukan
  int totalPengeluaran = 0; // inisiasi total pengeluaran
  List<FlSpot> chartData = []; // inisiasi data untuk grafik
  int xAxisValue = 0; // inisiasi untuk sumbu x pada grafik
  int yAxisValue = 0; // inisiasi untuk sumbu y pada grafik
  int maxY = 0; // inisiasi untuk nilai maksimal sumbu y pada grafik
  int maxX = 0; // inisiasi untuk nilai maksimal sumbu x pada grafik

  @override
  void initState() {
    super.initState();
    _fetchTotalAmounts();
  }

  // untuk mengambil nilai dari pemasukan, pengeluaran, dan selisih
  Future<void> _fetchTotalAmounts() async {
    final pemasukan = await DatabaseHelper
        .getTotalPemasukan(); // ambil nilai pemasukan dari database
    final pengeluaran = await DatabaseHelper
        .getTotalPengeluaran(); // ambil nilai pengeluaran dari database
    final selisih = pemasukan - pengeluaran;

    setState(() {
      totalPemasukan = pemasukan;
      totalPengeluaran = pengeluaran;
      chartData.add(FlSpot(xAxisValue.toDouble(), selisih.toDouble()));

      // kondisi dimana nilai y pada grafik akan ada pada posisi selisih yang paling besar
      if (selisih > maxY) {
        maxY = selisih.toInt();
      }

      xAxisValue++; // untuk terus menambah nilai x sebanyak 1 pada grafik
    });
  }

  void _resetChart() {
    setState(() {
      chartData.clear(); // Menghapus semua data dari chartData
      xAxisValue = 0; // Mengganti nilai xAxisValue kembali ke 0
      yAxisValue = 0; // Mengganti nilai xAxisValue kembali ke 0
      maxX = 0; // Mengganti nilai maksimal sumbu x kembali ke 0
      maxY = 0; // Mengganti nilai maksimal sumbu y kembali ke 0
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalProvider = Provider.of<TotalProvider>(context);
    final totalPemasukan = totalProvider.totalPemasukan;
    final totalPengeluaran = totalProvider.totalPengeluaran;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Rangkuman Bulan ini",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Total Pemasukan: $totalPemasukan",
                style: TextStyle(color: Colors.green),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Total Pengeluaran: $totalPengeluaran",
                style: TextStyle(color: Colors.red),
              ),
              ElevatedButton(
                onPressed: () {
                  totalProvider.updateTotals();
                  _fetchTotalAmounts(); // memanggil method untuk mengambil nilai pengeluaran dan pemasukan
                },
                style: ElevatedButton.styleFrom(minimumSize: Size(50, 30)),
                child: Text('Refresh Totals'),
              ),
              ElevatedButton(
                onPressed: () {
                  _resetChart(); // Memanggil method untuk mereset grafik
                },
                style: ElevatedButton.styleFrom(minimumSize: Size(50, 30)),
                child: Text('Reset Chart'),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: LineChart(
                  LineChartData(
                    minX: 0,
                    maxX: xAxisValue.toDouble(),
                    minY: 0,
                    maxY: maxY.toDouble(),
                    lineBarsData: [
                      LineChartBarData(
                        spots: chartData,
                        isCurved: false,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // jika di klik maka akan masuk ke halaman yang dituju
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PemasukanPage()));
                        },
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [Icon(Icons.money), Text("Pemasukan")],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // jika di klik maka akan masuk ke halaman yang dituju
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PengeluaranPage()));
                        },
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.money_off_csred_outlined),
                              Text("Pengeluaran")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // jika di klik maka akan masuk ke halaman yang dituju
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailCashFlowPage()),
                          );
                        },
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.list_alt_outlined),
                              Text("Detail Cash Flow")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // jika di klik maka akan masuk ke halaman yang dituju
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PengaturanPage()));
                        },
                        child: Container(
                          width: 125,
                          height: 125,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.settings),
                              Text("Pengaturan")
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

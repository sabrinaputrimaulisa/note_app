import 'package:flutter/material.dart'
    show
        BuildContext,
        ChangeNotifier,
        MaterialApp,
        StatelessWidget,
        Widget,
        runApp;
import 'package:note_app/pages/detail_cash_flow_page.dart';
import 'package:note_app/pages/home_page.dart';
import 'package:note_app/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:note_app/service/database_helper.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TotalProvider(),
      child: MyApp(),
    ),
  );
}

class TotalProvider with ChangeNotifier {
  int _totalPemasukan = 0;
  int _totalPengeluaran = 0;

  int get totalPemasukan => _totalPemasukan;
  int get totalPengeluaran => _totalPengeluaran;

  // update total nilai transaksi
  Future<void> updateTotals() async {
    final pemasukan = await DatabaseHelper.getTotalPemasukan();
    final pengeluaran = await DatabaseHelper.getTotalPengeluaran();
    _totalPemasukan = pemasukan;
    _totalPengeluaran = pengeluaran;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

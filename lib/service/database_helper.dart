import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // inisiai database
  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'note.db');
    return openDatabase(path, version: 3, onCreate: _createDatabase);
  }

  // membuat tabel transaksi
  static Future<void> _createDatabase(Database db, int version) async {
    await db.execute("""
      CREATE TABLE IF NOT EXISTS transaksi (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tanggal DATETIME,
        nominal INTEGER,
        keterangan TEXT,
        jenis INTEGER
      )
      """);
  }

  // melakukan insert untuk data transaksi
  static Future<int> insertPemasukan(
      DateTime tanggal, int nominal, String keterangan, int jenis) async {
    final db = await _openDatabase();
    final data = {
      'tanggal': tanggal.toIso8601String(),
      'nominal': nominal,
      'keterangan': keterangan,
      'jenis': jenis
    };
    return await db.insert('transaksi', data);
  }

  // untuk mendapatkan data dari tabel transaksi
  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await _openDatabase();
    return await db.query('transaksi');
  }

  // untuk menghapus semua data transaksi
  static Future<void> deleteAllData() async {
    final db = await _openDatabase();
    await db.delete('transaksi');
  }

  // untuk mendapatkan jumlah pemasukan
  static Future<int> getTotalPemasukan() async {
    final db = await _openDatabase();
    final result = await db.rawQuery(
        'SELECT SUM(nominal) as total FROM transaksi WHERE jenis = 1');
    final total = result.first['total'] as int?;
    return total ?? 0;
  }

  // untuk mendapatkan jumlah pengeluaran
  static Future<int> getTotalPengeluaran() async {
    final db = await _openDatabase();
    final result = await db.rawQuery(
        'SELECT SUM(nominal) as total FROM transaksi WHERE jenis = 2');
    final total = result.first['total'] as int?;
    return total ?? 0;
  }
}

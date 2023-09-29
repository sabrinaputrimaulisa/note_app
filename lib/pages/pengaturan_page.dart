import 'package:flutter/material.dart'
    show
        Border,
        BoxDecoration,
        BuildContext,
        Center,
        Colors,
        Column,
        Container,
        CrossAxisAlignment,
        EdgeInsets,
        ElevatedButton,
        FontWeight,
        Image,
        InputDecoration,
        MainAxisAlignment,
        Navigator,
        OutlineInputBorder,
        Padding,
        Row,
        Scaffold,
        ScaffoldMessenger,
        Size,
        SizedBox,
        SnackBar,
        State,
        StatefulWidget,
        Text,
        TextEditingController,
        TextField,
        TextStyle,
        Widget;

class PengaturanPage extends StatefulWidget {
  const PengaturanPage({super.key});

  @override
  State<PengaturanPage> createState() => _PengaturanPageState();
}

class _PengaturanPageState extends State<PengaturanPage> {
  TextEditingController _currentPasswordController =
      TextEditingController(); // inisiasi controller password sekarang
  TextEditingController _newPasswordController =
      TextEditingController(); // inisiasi controller password baru
  String storedPassword = "user";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Pengaturan",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 40,
                ),
                Text("Password saat ini"),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _currentPasswordController,
                  obscureText: true, // menyembunyikan inputan dengan simbol
                  decoration: InputDecoration(
                      labelText: "Masukkan password saat ini",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Password baru"),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _newPasswordController,
                  obscureText: true, // menyembunyikan inputan dengan simbol
                  decoration: InputDecoration(
                      labelText: "Masukkan password baru",
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    String currentPassword = _currentPasswordController.text;
                    String newPassword = _newPasswordController.text;
                    // kondisi dimana jika password sekarang sama dengan password awal maka password berhasil diganti
                    if (currentPassword == storedPassword) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password berhasil diganti."),
                        ),
                      );
                    } else {
                      // kondisi jika password sekarang berbeda dengan password awal dan maka tidak akan berhasil
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Password saat ini salah. Coba lagi."),
                        ),
                      );
                    }
                  },
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
                    Navigator.pop(context); // kembali ke halaman sebelumnya
                  },
                  child: Text("<< Kembali"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      minimumSize: Size(double.infinity, 30)),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 125,
                      height: 125,
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                          child: Image.asset('assets/images/person1.png')),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About This App",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Text("Aplikasi ini dibuat oleh:"),
                        Text("Nama:...."),
                        Text("NIM:..."),
                        Text("Tanggal 25/09/2023")
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

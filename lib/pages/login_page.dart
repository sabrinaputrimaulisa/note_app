import 'package:flutter/material.dart'
    show
        BuildContext,
        Colors,
        Column,
        EdgeInsets,
        ElevatedButton,
        FontWeight,
        Image,
        InputDecoration,
        Key,
        MaterialPageRoute,
        Navigator,
        Padding,
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
import 'package:note_app/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController =
      TextEditingController(); // inisiasi controller untuk username
  TextEditingController _passwordController =
      TextEditingController(); // inisiasi controller untuk password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Image.asset(
              'assets/images/logo.jpg',
              width: 170,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "MyCashBook v1.0",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(
              height: 70,
            ),
            TextField(
              controller: _usernameController, // memanggil controller username
              decoration: InputDecoration(labelText: "Masukkan username"),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _passwordController, // memanggil controller password
              obscureText: true, // menyembunyikan inputan dengan simbol
              decoration: InputDecoration(labelText: "Masukkan password"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;

                if (username == "user" && password == "user") {
                  // Login berhasil, lakukan navigasi ke halaman berikutnya
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                } else {
                  // Login gagal, tampilkan pesan kesalahan.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Login gagal. Coba lagi."),
                    ),
                  );
                }
              },
              child: Text("Submit"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 30)),
            ),
          ],
        ),
      ),
    );
  }
}

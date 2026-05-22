import 'package:flutter/material.dart';

class RadiobuttonPage extends StatefulWidget {
  const RadiobuttonPage({super.key});

  @override
  State<RadiobuttonPage> createState() => _RadiobuttonPageState();
}

class _RadiobuttonPageState extends State<RadiobuttonPage> {
  String? _jk;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Radio Button"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            RadioListTile(
              value: "Laki-laki",
              groupValue: _jk,
              onChanged: (String? value) {
                setState(() {
                  _jk = value;
                });
              },
              activeColor: Colors.blue,
              title: Text("Laki-laki"),
            ),
            RadioListTile(
              value: "Perempuan",
              groupValue: _jk,
              onChanged: (String? value) {
                setState(() {
                  _jk = value;
                });
              },
              activeColor: Colors.blue,
              title: Text("Perempuan"),
            ),
          ],
        ),
      ),
    );
  }
}
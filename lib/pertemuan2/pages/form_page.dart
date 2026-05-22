import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  String? _selectedJurusan;

  String? _resultNim;
  String? _resultNama;
  String? _resultJurusan;

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _resultNim = _nimController.text;
        _resultNama = _namaController.text;
        _resultJurusan = _selectedJurusan;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil disubmit')),
      );
    }
  }

  @override
  void dispose() {
    _nimController.dispose();
    _namaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'NIM tidak boleh kosong' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value!.isEmpty ? 'Nama tidak boleh kosong' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedJurusan,
              decoration: const InputDecoration(
                labelText: 'Jurusan',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                    value: 'Sistem Informasi',
                    child: Text('Sistem Informasi')),
                DropdownMenuItem(
                    value: 'Teknik Informatika',
                    child: Text('Teknik Informatika')),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedJurusan = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Pilih jurusan terlebih dahulu' : null,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitData,
              child: const Text('Submit'),
            ),
            const SizedBox(height: 30),
            if (_resultNim != null &&
                _resultNama != null &&
                _resultJurusan != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hasil Input:',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('NIM    : $_resultNim'),
                  Text('Nama   : $_resultNama'),
                  Text('Jurusan: $_resultJurusan'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
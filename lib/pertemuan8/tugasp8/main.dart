import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'mahasiswa_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp4());
}

class MyApp4 extends StatelessWidget {
  const MyApp4({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Akademik',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Mengubah warna tema menjadi Teal (Hijau Kebiruan)
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper();
  
  final nimController = TextEditingController();
  final namaController = TextEditingController();
  final jurusanController = TextEditingController();
  final searchController = TextEditingController();
  
  List<Mahasiswa> listMahasiswa = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    setState(() => isLoading = true);
    final List<Map<String, dynamic>> maps = await dbHelper.getMahasiswa();
    setState(() {
      listMahasiswa = maps.map((mhs) => Mahasiswa.fromMap(mhs)).toList();
      isLoading = false;
    });
  }

  Future<void> _searchData(String keyword) async {
    setState(() => isLoading = true);
    final List<Map<String, dynamic>> maps = 
        await dbHelper.searchMahasiswa(keyword);
    setState(() {
      listMahasiswa = maps.map((mhs) => Mahasiswa.fromMap(mhs)).toList();
      isLoading = false;
    });
  }

  Future<void> _saveData(int? id) async {
    if (nimController.text.isEmpty || namaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('NIM dan Nama tidak boleh kosong!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (id != null) {
      // Update
      final updatedMhs = Mahasiswa(
        id: id,
        nim: nimController.text,
        nama: namaController.text,
        jurusan: jurusanController.text,
      );
      await dbHelper.updateMahasiswa(updatedMhs.toMap());
    } else {
      // Insert
      await dbHelper.insertMahasiswa({
        'nim': nimController.text,
        'nama': namaController.text,
        'jurusan': jurusanController.text,
      });
    }

    // Tutup bottom sheet
    if (!mounted) return;
    Navigator.of(context).pop();
    
    // Bersihkan form dan refresh data
    nimController.clear();
    namaController.clear();
    jurusanController.clear();
    await _refreshData();
  }

  Future<void> _deleteData(int id) async {
    await dbHelper.deleteMahasiswa(id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data berhasil dihapus')),
    );
    await _refreshData();
  }

  // --- Form Bottom Sheet ---
  void _showForm(BuildContext context, [Mahasiswa? mhs]) {
    // Jika mhs tidak null, berarti sedang edit data
    if (mhs != null) {
      nimController.text = mhs.nim;
      namaController.text = mhs.nama;
      jurusanController.text = mhs.jurusan;
    } else {
      nimController.clear();
      namaController.clear();
      jurusanController.clear();
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true, // Agar form naik saat keyboard muncul
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Container(
        padding: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          // Menambahkan padding bawah sesuai tinggi keyboard
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              mhs == null ? 'Tambah Mahasiswa' : 'Edit Data Mahasiswa',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nimController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'NIM',
                prefixIcon: const Icon(Icons.badge_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: namaController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: jurusanController,
              decoration: InputDecoration(
                labelText: 'Jurusan',
                prefixIcon: const Icon(Icons.school_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _saveData(mhs?.id),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                mhs == null ? 'SIMPAN DATA' : 'UPDATE DATA',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text('Data Akademik', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search Bar Modern
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primary,
            child: TextField(
              controller: searchController,
              onChanged: (value) => _searchData(value), // Pencarian Real-time
              decoration: InputDecoration(
                hintText: 'Cari Nama atau NIM...',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          _refreshData();
                          FocusScope.of(context).unfocus();
                        },
                      )
                    : null,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Daftar Mahasiswa
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : listMahasiswa.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.folder_open, size: 80, color: Colors.grey.shade400),
                            const SizedBox(height: 16),
                            Text('Belum ada data mahasiswa', 
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: listMahasiswa.length,
                        padding: const EdgeInsets.only(top: 8, bottom: 80), // bottom padding untuk FAB
                        itemBuilder: (context, index) {
                          final mhs = listMahasiswa[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(16),
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                child: Text(
                                  mhs.nama[0].toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                              title: Text(
                                mhs.nama,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.badge, size: 16, color: Colors.grey),
                                        const SizedBox(width: 8),
                                        Text(mhs.nim),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.school, size: 16, color: Colors.grey),
                                        const SizedBox(width: 8),
                                        Text(mhs.jurusan),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              trailing: PopupMenuButton<String>(
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _showForm(context, mhs);
                                  } else if (value == 'delete') {
                                    _confirmDelete(mhs);
                                  }
                                },
                                // BAGIAN YANG DIPERBAIKI (Dilengkapi)
                                itemBuilder: (BuildContext context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit, color: Colors.blue),
                                        SizedBox(width: 8),
                                        Text('Edit'),
                                      ],
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete, color: Colors.red),
                                        SizedBox(width: 8),
                                        Text('Hapus'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      // Tombol Mengambang (FAB) untuk Tambah Data
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showForm(context),
        icon: const Icon(Icons.add),
        label: const Text('Tambah Data'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _confirmDelete(Mahasiswa mhs) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Yakin ingin menghapus ${mhs.nama}?'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteData(mhs.id!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nimController.dispose();
    namaController.dispose();
    jurusanController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
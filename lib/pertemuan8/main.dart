import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'item_model.dart';

// main() dibungkus MaterialApp agar file ini tetap bisa di-run mandiri saat proses testing
void main() {
  // Pastikan binding Flutter diinisialisasi sebelum mengakses database
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp3(),
  ));
}

class MyApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PERBAIKAN 1: Hapus MaterialApp, ganti dengan Theme agar warna aplikasi tidak berubah
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      child: HomePage(), // Langsung memanggil HomePage
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper();
  final nameController = TextEditingController();
  final descController = TextEditingController();
  final searchController = TextEditingController();
  List<Item> items = [];
  bool isLoading = true;
  Item? editingItem;

  @override
  void initState() {
    super.initState();
    _refreshItemList();
  }

  Future<void> _refreshItemList() async {
    setState(() => isLoading = true);
    final List<Map<String, dynamic>> itemMaps = await dbHelper.getItems();
    setState(() {
      items = itemMaps.map((item) => Item.fromMap(item)).toList();
      isLoading = false;
    });
  }

  Future<void> _searchItems() async {
    if (searchController.text.isEmpty) {
      await _refreshItemList();
      return;
    }
    setState(() => isLoading = true);
    final List<Map<String, dynamic>> itemMaps = 
        await dbHelper.searchItems(searchController.text);
    setState(() {
      items = itemMaps.map((item) => Item.fromMap(item)).toList();
      isLoading = false;
    });
  }

  Future<void> _saveItem() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama tidak boleh kosong')),
      );
      return;
    }

    if (editingItem != null) {
      final updatedItem = editingItem!.copyWith(
        name: nameController.text,
        description: descController.text,
      );
      await dbHelper.updateItem(updatedItem.toMap());
      editingItem = null;
    } else {
      await dbHelper.insertItem({
        'name': nameController.text,
        'description': descController.text,
      });
    }

    nameController.clear();
    descController.clear();
    FocusScope.of(context).unfocus();
    await _refreshItemList();
  }

  Future<void> _deleteItem(int id) async {
    await dbHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Item berhasil dihapus')),
    );
    await _refreshItemList();
  }

  void _editItem(Item item) {
    setState(() {
      editingItem = item;
      nameController.text = item.name;
      descController.text = item.description;
    });
  }

  void _cancelEdit() {
    setState(() {
      editingItem = null;
      nameController.clear();
      descController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Database Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        
        // PERBAIKAN 2: Tambahkan tombol Back di sini
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Fungsi untuk kembali ke menu sebelumnya (MateriPage)
          },
        ),
      ),
      body: Column(
        children: [
          // Form Input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      editingItem != null ? 'Edit Item' : 'Tambah Item Baru',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Item',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.label),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descController,
                      decoration: const InputDecoration(
                        labelText: 'Deskripsi',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        if (editingItem != null)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _cancelEdit,
                              child: const Text('Batal'),
                            ),
                          ),
                        if (editingItem != null) const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _saveItem,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            child: Text(editingItem != null ? 'Update' : 'Simpan'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Cari Item',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    _refreshItemList();
                  },
                ),
              ),
              onSubmitted: (_) => _searchItems(),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Item List
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : items.isEmpty
                    ? const Center(child: Text('Tidak ada data'))
                    : ListView.builder(
                        itemCount: items.length,
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                            child: ListTile(
                              title: Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text(item.description),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => _editItem(item),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _confirmDelete(item),
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
    );
  }

  void _confirmDelete(Item item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: Text('Hapus item "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteItem(item.id!);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descController.dispose();
    searchController.dispose();
    super.dispose();
  }
}
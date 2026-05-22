import 'package:flutter/material.dart';
import 'package:mobileprogramming/main.dart';
import 'package:mobileprogramming/pertemuan2/latihan1.dart';
import 'package:mobileprogramming/pertemuan3/latihan1.dart';
import 'package:mobileprogramming/pertemuan4/latihan1.dart';
import 'package:mobileprogramming/pertemuan4/tugas.dart';
import 'package:mobileprogramming/pertemuan5/latihan1.dart';
import 'package:mobileprogramming/pertemuan5/tugas.dart';
import 'package:mobileprogramming/pertemuan7/main.dart';
import 'package:mobileprogramming/pertemuan8/main.dart';
import 'package:mobileprogramming/pertemuan8/tugasp8/main.dart';
import 'package:mobileprogramming/pertemuan9/main.dart';
import 'package:mobileprogramming/uts/main.dart';


// Halaman Materi (Home)
class MateriPage extends StatelessWidget {
  const MateriPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: const Icon(Icons.bookmark, color: Colors.white),
        title: const Text(
          'Mobile Programming',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: const [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selamat datang,',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Ibnu Said',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Grid Menu
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.0,
                children: [
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Colors.green,
                    label: 'Pertemuan 1',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageEmpat(),
                           // kelas lain yang dipanggil
                        ),
                        
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Colors.green,
                    label: 'Pertemuan 2',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp2(),
                           // kelas lain yang dipanggil
                        ),
                        
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Colors.green,
                    label: 'Pertemuan 3',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageBasicList(),
                           // kelas lain yang dipanggil
                        ),
                        
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Colors.green,
                    label: 'Pertemuan 4',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                           // kelas lain yang dipanggil
                        ),
                        
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Color.fromARGB(255, 30, 167, 208),
                    label: 'Tugas Pertemuan 4',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuUtama1(),
                           // kelas lain yang dipanggil
                        ),
                        
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Colors.green,
                    label: 'Pertemuan 5',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyListView(),
                           // kelas lain yang dipanggil
                        ),
                        
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Color.fromARGB(255, 30, 167, 208),
                    label: 'Tugas Pertemuan 5',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(),
                           // kelas lain yang dipanggil
                        ),
                        
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Colors.green,
                    label: 'Pertemuan 7',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp1(),
                           // kelas lain yang dipanggil
                        ),
                    
                        
                      );
                    },
                  ),
                   _buildMenuItem(
                    icon: Icons.folder,
                    color: Color.fromARGB(255, 30, 167, 208),
                    label: 'UTS',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GamingForgeHubApp(),
                           // kelas lain yang dipanggil
                        ),
                    
                        
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Colors.green,
                    label: 'Pertemuan 8',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp3(),
                           // kelas lain yang dipanggil
                        ),
                    
                        
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Color.fromARGB(255, 30, 167, 208),
                    label: 'Tugas Pertemuan 8',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp4(),
                           // kelas lain yang dipanggil
                        ),  
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.folder,
                    color: Color.fromARGB(255, 30, 167, 208),
                    label: 'Pertemuan 9',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp9(),
                           // kelas lain yang dipanggil
                        ),  
                      );
                    },
                  ),
                ],
                
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,size: 32,color: color,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Halaman Navigasi
class NavigasiPage extends StatelessWidget {
  const NavigasiPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          'Navigasi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNavigasiCard(
            context,
            icon: Icons.map,
            title: 'Peta Kampus',
            subtitle: 'Lihat denah dan lokasi kampus',
            color: Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildNavigasiCard(
            context,
            icon: Icons.school,
            title: 'Ruang Kelas',
            subtitle: 'Cari lokasi ruang kelas',
            color: Colors.green,
          ),
          const SizedBox(height: 12),
          _buildNavigasiCard(
            context,
            icon: Icons.local_library,
            title: 'Perpustakaan',
            subtitle: 'Lokasi dan jam operasional',
            color: Colors.orange,
          ),
          const SizedBox(height: 12),
          _buildNavigasiCard(
            context,
            icon: Icons.restaurant,
            title: 'Kantin',
            subtitle: 'Temukan kantin terdekat',
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigasiCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        required Color color,
      }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Membuka $title'),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }
}

// Halaman Profile
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.blue[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ibnu Said',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Mahasiswa',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildProfileOption(
                    context,
                    icon: Icons.email,
                    title: 'Email',
                    subtitle: 'ibnusaid500@gmail.com',
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.phone,
                    title: 'Telepon',
                    subtitle: '+62 877-7634-7658',
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.badge,
                    title: 'NIM',
                    subtitle: '241011700906',
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.school,
                    title: 'Program Studi',
                    subtitle: 'Sistem Informasi',
                  ),
                  const SizedBox(height: 16),
                  _buildProfileOption(
                    context,
                    icon: Icons.settings,
                    title: 'Pengaturan',
                    subtitle: 'Kelola akun Anda',
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.help,
                    title: 'Bantuan',
                    subtitle: 'Pusat bantuan dan FAQ',
                  ),
                  _buildProfileOption(
                    context,
                    icon: Icons.logout,
                    title: 'Keluar',
                    subtitle: 'Logout dari aplikasi',
                    isLogout: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
        bool isLogout = false,
      }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isLogout
                ? Colors.red.withOpacity(0.1)
                : Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isLogout ? Colors.red : Colors.blue,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isLogout ? Colors.red : Colors.black87,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: isLogout ? Colors.red : Colors.grey,
        ),
        onTap: () {
          if (isLogout) {
            _showLogoutDialog(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Membuka $title'),
                duration: const Duration(seconds: 2),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Berhasil logout'),
                    duration: Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
class Mahasiswa {
  final int? id;
  final String nim;
  final String nama;
  final String jurusan;

  const Mahasiswa({
    this.id,
    required this.nim,
    required this.nama,
    required this.jurusan,
  });

  // Konversi dari Object ke Map untuk disimpan di SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nim': nim,
      'nama': nama,
      'jurusan': jurusan,
    };
  }

  // Factory constructor untuk konversi dari Map ke Object
  factory Mahasiswa.fromMap(Map<String, dynamic> map) {
    return Mahasiswa(
      id: map['id'],
      nim: map['nim'],
      nama: map['nama'],
      jurusan: map['jurusan'],
    );
  }

  // Method copyWith untuk memudahkan update data
  Mahasiswa copyWith({
    int? id,
    String? nim,
    String? nama,
    String? jurusan,
  }) {
    return Mahasiswa(
      id: id ?? this.id,
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      jurusan: jurusan ?? this.jurusan,
    );
  }

  // Untuk memudahkan debugging di console
  @override
  String toString() {
    return 'Mahasiswa{id: $id, nim: $nim, nama: $nama, jurusan: $jurusan}';
  }
}
class Item {
  int? id;
  String name;
  String description;

  Item({
    this.id,
    required this.name,
    required this.description,
  });

  // Konversi dari Object ke Map untuk penyimpanan di database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  // Factory constructor untuk konversi dari Map ke Object
  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      description: map['description'],
    );
  }

  // Untuk debugging
  @override
  String toString() {
    return 'Item{id: $id, name: $name, description: $description}';
  }

  // Copy with method untuk memudahkan update
  Item copyWith({
    int? id,
    String? name,
    String? description,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }
}
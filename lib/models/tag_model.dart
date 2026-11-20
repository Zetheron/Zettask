class TagModel {
  const TagModel({
    this.id,
    required this.name,
    this.colorHex = '#2563EB',
  });

  final int? id;
  final String name;
  final String colorHex;

  TagModel copyWith({
    int? id,
    String? name,
    String? colorHex,
  }) {
    return TagModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'colorHex': colorHex,
    };
  }

  factory TagModel.fromMap(Map<String, dynamic> map) {
    return TagModel(
      id: (map['id'] as num?)?.toInt(),
      name: (map['name'] as String?) ?? '',
      colorHex: (map['colorHex'] as String?) ?? '#2563EB',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TagModel &&
        other.id == id &&
        other.name == name &&
        other.colorHex == colorHex;
  }

  @override
  int get hashCode => Object.hash(id, name, colorHex);
}

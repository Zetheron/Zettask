class ProjectProgress {
  const ProjectProgress({
    this.completedCount = 0,
    this.totalCount = 0,
  });

  final int completedCount;
  final int totalCount;

  double get ratio => totalCount == 0 ? 0.0 : completedCount / totalCount;

  int get percentage => (ratio * 100).round().clamp(0, 100);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectProgress &&
        other.completedCount == completedCount &&
        other.totalCount == totalCount;
  }

  @override
  int get hashCode => Object.hash(completedCount, totalCount);
}

class ProjectModel {
  ProjectModel({
    this.id,
    required this.name,
    this.colorHex = '#0D9488',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  final int? id;
  final String name;
  final String colorHex;
  final DateTime createdAt;

  ProjectModel copyWith({
    int? id,
    String? name,
    String? colorHex,
    DateTime? createdAt,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      colorHex: colorHex ?? this.colorHex,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'colorHex': colorHex,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ProjectModel.fromMap(Map<String, dynamic> map) {
    return ProjectModel(
      id: (map['id'] as num?)?.toInt(),
      name: (map['name'] as String?) ?? '',
      colorHex: (map['colorHex'] as String?) ?? '#0D9488',
      createdAt: DateTime.tryParse((map['createdAt'] as String?) ?? '') ??
          DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProjectModel &&
        other.id == id &&
        other.name == name &&
        other.colorHex == colorHex &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => Object.hash(id, name, colorHex, createdAt);
}

class NoteModel {
  NoteModel({
    this.id,
    required this.title,
    this.content = '',
    this.colorHex = '#0D9488',
    this.tagId,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  final int? id;
  final String title;
  final String content;
  final String colorHex;
  final int? tagId;
  final DateTime updatedAt;

  NoteModel copyWith({
    int? id,
    String? title,
    String? content,
    String? colorHex,
    int? tagId,
    bool clearTag = false,
    DateTime? updatedAt,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      colorHex: colorHex ?? this.colorHex,
      tagId: clearTag ? null : (tagId ?? this.tagId),
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'content': content,
      'colorHex': colorHex,
      'tagId': tagId,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: (map['id'] as num?)?.toInt(),
      title: (map['title'] as String?) ?? '',
      content: (map['content'] as String?) ?? '',
      colorHex: (map['colorHex'] as String?) ?? '#0D9488',
      tagId: (map['tagId'] as num?)?.toInt(),
      updatedAt: DateTime.tryParse((map['updatedAt'] as String?) ?? '') ??
          DateTime.now(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is NoteModel &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.colorHex == colorHex &&
        other.tagId == tagId &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode =>
      Object.hash(id, title, content, colorHex, tagId, updatedAt);
}

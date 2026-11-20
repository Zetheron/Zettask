class AuthUser {
  const AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.providerId = 'password',
  });

  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final String providerId;

  String get displayLabel {
    final name = displayName?.trim();
    if (name != null && name.isNotEmpty) return name;
    final mail = email?.trim();
    if (mail != null && mail.isNotEmpty) return mail;
    return 'Akun Zettask';
  }

  String get providerLabel {
    if (providerId == 'google.com') return 'Google';
    return 'Email';
  }

  String get initials {
    final source = displayLabel.trim();
    if (source.isEmpty) return 'Z';
    final parts = source.split(RegExp(r'[\s@._-]+')).where((p) => p.isNotEmpty).toList();
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return source.substring(0, source.length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthUser &&
        other.uid == uid &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoUrl == photoUrl &&
        other.providerId == providerId;
  }

  @override
  int get hashCode =>
      Object.hash(uid, email, displayName, photoUrl, providerId);
}

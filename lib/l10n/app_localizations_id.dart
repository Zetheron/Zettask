// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Timeline';

  @override
  String get navBoard => 'Board';

  @override
  String get navUnplanned => 'Unplanned';

  @override
  String get navMore => 'More';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get close => 'Tutup';

  @override
  String get delete => 'Hapus';

  @override
  String get edit => 'Edit';

  @override
  String get undo => 'Urungkan';

  @override
  String get back => 'Kembali';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get clear => 'Bersihkan';

  @override
  String get all => 'Semua';

  @override
  String get or => 'atau';

  @override
  String get continueAction => 'Lanjutkan';

  @override
  String get understand => 'Mengerti';

  @override
  String get useAction => 'Gunakan';

  @override
  String get today => 'Hari Ini';

  @override
  String get tomorrow => 'Besok';

  @override
  String get yesterday => 'Kemarin';

  @override
  String get toDo => 'To Do';

  @override
  String get overdue => 'Terlambat';

  @override
  String get unplanned => 'Unplanned';

  @override
  String get allDay => 'Sepanjang Hari';

  @override
  String get scheduled => 'Terjadwal';

  @override
  String get addTaskToday => 'Tambah tugas hari ini';

  @override
  String get addTask => 'Tambah tugas';

  @override
  String get noTasksForDate => 'Belum ada tugas untuk tanggal ini.';

  @override
  String get savedToUnplanned => 'Disimpan ke Unplanned';

  @override
  String get savedToUnplannedNoDate => 'Disimpan ke Unplanned (tanpa tanggal)';

  @override
  String scheduledForDate(String date) {
    return 'Dijadwalkan untuk $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Tugas dijadwalkan untuk $date';
  }

  @override
  String get taskDeleted => 'Tugas dihapus';

  @override
  String get searchTasksTooltip => 'Cari tugas';

  @override
  String get timelineOptionsTooltip => 'Opsi timeline';

  @override
  String get addTaskTooltip => 'Tambah Tugas';

  @override
  String get completedLabel => 'Selesai';

  @override
  String get uncompleteLabel => 'Batal selesai';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total sub-tugas';
  }

  @override
  String get repeatingTaskLabel => 'Tugas berulang';

  @override
  String get quickAddHint => 'Tambahkan tugas baru...';

  @override
  String get expandTooltip => 'Perluas';

  @override
  String get saveTaskTooltip => 'Simpan tugas';

  @override
  String get newTask => 'Tugas Baru';

  @override
  String get editTask => 'Edit Tugas';

  @override
  String get taskTitleLabel => 'Judul tugas';

  @override
  String get taskTitleHint => 'Contoh: Review catatan sprint';

  @override
  String get taskTitleRequired => 'Judul tugas wajib diisi';

  @override
  String get descriptionLabel => 'Deskripsi';

  @override
  String get descriptionHint => 'Tambahkan catatan atau konteks...';

  @override
  String get pickDate => 'Pilih Tanggal';

  @override
  String get pickOnCalendar => 'Pilih di kalender...';

  @override
  String get noDateUnplanned => 'Tanpa tanggal (Unplanned)';

  @override
  String get noDate => 'Tanpa tanggal';

  @override
  String get taskTime => 'Waktu Tugas';

  @override
  String get changeTime => 'Ubah jam';

  @override
  String get clearTimeAllDay => 'Hapus jam (Sepanjang Hari)';

  @override
  String get timeLabel => 'Jam';

  @override
  String get reminderLabel => 'Pengingat';

  @override
  String get noReminder => 'Tanpa pengingat';

  @override
  String get atTime => 'Tepat waktu';

  @override
  String get minutesBefore10 => '10 menit sebelum';

  @override
  String get minutesBefore30 => '30 menit sebelum';

  @override
  String get hourBefore1 => '1 jam sebelum';

  @override
  String get reminderShort10m => '10 mnt';

  @override
  String get reminderShort30m => '30 mnt';

  @override
  String get reminderShort1h => '1 jam';

  @override
  String get projectLabel => 'Proyek';

  @override
  String get noProject => 'Tanpa proyek';

  @override
  String get tagLabel => 'Tag';

  @override
  String get noTag => 'Tanpa tag';

  @override
  String get priorityLabel => 'Prioritas';

  @override
  String get priorityLow => 'Rendah';

  @override
  String get priorityMedium => 'Sedang';

  @override
  String get priorityHigh => 'Tinggi';

  @override
  String get saveTask => 'Simpan Tugas';

  @override
  String get saveChanges => 'Simpan Perubahan';

  @override
  String get checklistLabel => 'Checklist';

  @override
  String get addChecklistHint => 'Tambah item checklist...';

  @override
  String get repeatLabel => 'Pengulangan';

  @override
  String get noRepeat => 'Tidak berulang';

  @override
  String get repeatDaily => 'Setiap hari';

  @override
  String get repeatWeekly => 'Setiap minggu';

  @override
  String get repeatMonthly => 'Setiap bulan';

  @override
  String get colorLabel => 'Warna';

  @override
  String get timelineOptionsTitle => 'Opsi Timeline';

  @override
  String get viewModeLabel => 'Mode Tampilan';

  @override
  String get modeTimeline => 'Mode Timeline';

  @override
  String get modeDaily => 'Mode Harian';

  @override
  String get firstDayOfWeek => 'Hari Awal Minggu';

  @override
  String get monday => 'Senin';

  @override
  String get sunday => 'Minggu';

  @override
  String get firstDayMondayOrder => 'Sen · Sel · Rab · Kam · Jum · Sab · Min';

  @override
  String get firstDaySundayOrder => 'Min · Sen · Sel · Rab · Kam · Jum · Sab';

  @override
  String get showCompletedTasks => 'Tampilkan tugas selesai';

  @override
  String get showCompletedTasksSubtitle =>
      'Sembunyikan tugas yang sudah dicentang agar fokus ke tugas aktif.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Tampilkan atau sembunyikan tugas yang sudah selesai.';

  @override
  String get overdueTasksTitle => 'Tugas Terlambat';

  @override
  String get noOverdueTasks => 'Tidak ada tugas terlambat';

  @override
  String get moveToToday => 'Pindah ke Hari Ini';

  @override
  String get moveAllToToday => 'Pindahkan semua ke Hari Ini';

  @override
  String get searchTasksHint => 'Cari tugas...';

  @override
  String get searchTasksEmpty =>
      'Ketik untuk mencari tugas, deskripsi, atau checklist.';

  @override
  String searchNoResults(String query) {
    return 'Tidak ada tugas cocok dengan \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'Acara kalender · hanya baca';

  @override
  String get prevWeekTooltip => 'Minggu sebelumnya';

  @override
  String get nextWeekTooltip => 'Minggu berikutnya';

  @override
  String get boardTitle => 'Board';

  @override
  String get allProjects => 'Semua Proyek';

  @override
  String get searchProjectHint => 'Cari nama proyek...';

  @override
  String get searchProjectTooltip => 'Cari proyek';

  @override
  String get closeSearchTooltip => 'Tutup pencarian';

  @override
  String get createProject => 'Buat Proyek';

  @override
  String get editProject => 'Edit proyek';

  @override
  String get deleteProject => 'Hapus proyek';

  @override
  String get projectOptionsTooltip => 'Opsi proyek';

  @override
  String projectDeleted(String name) {
    return 'Proyek \"$name\" dihapus';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total selesai';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total tugas selesai';
  }

  @override
  String get projectNotFound => 'Proyek tidak ditemukan';

  @override
  String get noProjectsYet => 'Belum ada proyek';

  @override
  String projectSearchEmpty(String query) {
    return 'Tidak ada proyek yang cocok dengan \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'Ketuk tombol folder di kanan bawah untuk membuat proyek pertama.';

  @override
  String get newProject => 'Proyek Baru';

  @override
  String get projectNameLabel => 'Nama proyek';

  @override
  String get projectNameHint => 'Contoh: Peluncuran Zettask';

  @override
  String get projectNameRequired => 'Nama proyek wajib diisi';

  @override
  String get projectColorLabel => 'Warna Proyek';

  @override
  String get unplannedTitle => 'Unplanned';

  @override
  String activeCountLabel(int count) {
    return '$count aktif';
  }

  @override
  String get noUnplannedTitle => 'Belum ada tugas unplanned';

  @override
  String get noUnplannedSubtitle =>
      'Ketuk + untuk mencatat tugas tanpa tanggal.';

  @override
  String get addUnplannedTooltip => 'Tambah Tugas Unplanned';

  @override
  String get workspaceTitle => 'Workspace';

  @override
  String get organizeSection => 'Organize';

  @override
  String get automationSection => 'Otomatisasi';

  @override
  String get insightsSection => 'Wawasan & Personalisasi';

  @override
  String get settingsInfoSection => 'Pengaturan & Info';

  @override
  String get tagsTitle => 'Tags';

  @override
  String get tagsSubtitleEmpty => 'Label warna untuk tugas dan catatan';

  @override
  String tagsCountSubtitle(int count) {
    return '$count tag tersimpan';
  }

  @override
  String get newTag => 'Tag Baru';

  @override
  String get editTag => 'Edit Tag';

  @override
  String get tagNameLabel => 'Nama tag';

  @override
  String get tagNameRequired => 'Nama tag wajib diisi';

  @override
  String get tagDeleted => 'Tag dihapus';

  @override
  String get noTagsYet => 'Belum ada tag';

  @override
  String tagTasksCount(int count) {
    return '$count tugas';
  }

  @override
  String get templatesTitle => 'Templates';

  @override
  String get templatesSubtitleEmpty => 'Simpan struktur tugas dan checklist';

  @override
  String templatesCountSubtitle(int count) {
    return '$count template siap pakai';
  }

  @override
  String get newTemplate => 'Template Baru';

  @override
  String get editTemplate => 'Edit Template';

  @override
  String get templateNameLabel => 'Nama template';

  @override
  String get templateNameRequired => 'Nama template wajib diisi';

  @override
  String get templateDeleted => 'Template dihapus';

  @override
  String get noTemplatesYet => 'Belum ada template';

  @override
  String get taskFromTemplateSaved => 'Tugas dari template disimpan';

  @override
  String get notesTitle => 'Notes';

  @override
  String get notesSubtitleEmpty => 'Catatan cepat tanpa tanggal';

  @override
  String notesCountSubtitle(int count) {
    return '$count catatan tersimpan';
  }

  @override
  String get newNote => 'Catatan Baru';

  @override
  String get editNote => 'Edit Catatan';

  @override
  String get noteTitleLabel => 'Judul catatan';

  @override
  String get noteTitleHint => 'Contoh: Ringkasan rapat';

  @override
  String get noteTitleRequired => 'Judul catatan wajib diisi';

  @override
  String get noteContentLabel => 'Isi catatan';

  @override
  String get noteContentHint => 'Tulis catatan di sini...';

  @override
  String get noteDeleted => 'Catatan dihapus';

  @override
  String get searchNotesHint => 'Cari catatan...';

  @override
  String get noteNotFound => 'Catatan tidak ditemukan';

  @override
  String get noNotesYet => 'Belum ada catatan';

  @override
  String noteSearchEmpty(String query) {
    return 'Tidak ada catatan cocok dengan \"$query\".';
  }

  @override
  String get noNotesSubtitle =>
      'Ketuk + untuk menulis catatan cepat tanpa tanggal.';

  @override
  String get saveNote => 'Simpan Catatan';

  @override
  String get repeatingTasksTitle => 'Tugas Berulang';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Kelola rutinitas harian, mingguan, dan bulanan';

  @override
  String repeatingActiveCount(int count) {
    return '$count rutinitas aktif';
  }

  @override
  String get noRepeatingTasks => 'Belum ada tugas berulang';

  @override
  String get repeatingActionTitle => 'Ini adalah tugas berulang';

  @override
  String get repeatingThisOnly => 'Hanya tugas ini';

  @override
  String get repeatingThisAndFollowing =>
      'Tugas ini dan semua yang akan datang';

  @override
  String get last7DaysUpper => '7 HARI TERAKHIR';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks tugas, plus $checklists item checklist';
  }

  @override
  String get statsTitle => 'Statistik';

  @override
  String get range7Days => '7 Hari';

  @override
  String get range30Days => '30 Hari';

  @override
  String get completedToday => 'Selesai Hari Ini';

  @override
  String get last7DaysLabel => '7 Hari Terakhir';

  @override
  String get last30DaysLabel => '30 Hari Terakhir';

  @override
  String get allTimeLabel => 'Sepanjang Waktu';

  @override
  String get completionRateLabel => 'Tingkat Selesai';

  @override
  String get activity7Days => 'Aktivitas 7 Hari Terakhir';

  @override
  String get activity30Days => 'Aktivitas 30 Hari Terakhir';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks tugas · $checklists checklist';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Total $days hari: $tasks tugas, plus $checklists item checklist';
  }

  @override
  String get completedByPriority => 'Tugas Selesai per Prioritas';

  @override
  String get progressByProject => 'Progres per Proyek';

  @override
  String get breakdownByTag => 'Rincian per Tag';

  @override
  String get habits30Days => 'Kebiasaan (Habits) · 30 Hari';

  @override
  String get noProjectsCreated => 'Belum ada proyek yang dibuat.';

  @override
  String get noTagsCreated => 'Belum ada tag yang dibuat.';

  @override
  String get noActiveHabits => 'Belum ada rutinitas aktif.';

  @override
  String completedCountLabel(int count) {
    return '$count selesai';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total selesai';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled selesai';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed selesai · $percent% tingkat selesai';
  }

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeAndColorsTitle => 'Tema & Warna';

  @override
  String get livePreviewSection => 'Pratinjau Langsung';

  @override
  String get appearanceModeSection => 'Mode Tampilan';

  @override
  String get colorPaletteSection => 'Palet Warna';

  @override
  String get themeLight => 'Terang';

  @override
  String get themeDark => 'Gelap';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeSystemLight => 'Sistem (Terang)';

  @override
  String get themeSystemDark => 'Sistem (Gelap)';

  @override
  String get presetDefault => 'Default';

  @override
  String get presetDefaultDesc => 'Indigo & slate';

  @override
  String get presetOcean => 'Ocean';

  @override
  String get presetOceanDesc => 'Biru tenang';

  @override
  String get presetForest => 'Forest';

  @override
  String get presetForestDesc => 'Hijau sage & emerald';

  @override
  String get presetTerracotta => 'Terracotta';

  @override
  String get presetTerracottaDesc => 'Oranye bata hangat';

  @override
  String get presetPlum => 'Plum';

  @override
  String get presetPlumDesc => 'Ungu kalem';

  @override
  String get presetMonochrome => 'Monochrome';

  @override
  String get presetMonochromeDesc => 'Arang & hitam minimalis';

  @override
  String get previewActiveTask => 'Review desain antarmuka';

  @override
  String get previewCompletedTask => 'Sinkronkan jadwal mingguan';

  @override
  String get languageTitle => 'Bahasa';

  @override
  String get deviceLanguageOption => 'Bahasa perangkat (jika didukung)';

  @override
  String get appLockTitle => 'Kunci Aplikasi';

  @override
  String get appLockSubtitle => 'Sidik jari, wajah, atau PIN perangkat';

  @override
  String get appLockLockedTitle => 'Zettask Terkunci';

  @override
  String get appLockLockedSubtitle =>
      'Gunakan sidik jari, wajah, atau PIN perangkat untuk mengakses tugas Anda.';

  @override
  String get unlockButton => 'Buka Kunci';

  @override
  String get verifyingButton => 'Memverifikasi...';

  @override
  String get appLockUnsupportedError =>
      'Perangkat belum mengaktifkan biometrik atau PIN kunci layar.';

  @override
  String get appLockCancelledError => 'Verifikasi dibatalkan atau gagal.';

  @override
  String get appLockUnlockFailedError =>
      'Autentikasi dibatalkan atau gagal. Ketuk Buka Kunci untuk mencoba lagi.';

  @override
  String get calendarSyncTitle => 'Sinkronisasi Kalender';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Aktif · $count kalender';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'Nonaktif · tampilkan acara perangkat secara read-only';

  @override
  String get grantCalendarPermission => 'Berikan Izin Kalender';

  @override
  String get exportCsvTitle => 'Ekspor CSV';

  @override
  String get exportCsvSubtitle => 'Bagikan berkas CSV tugas atau catatan';

  @override
  String get exportDataCsvTitle => 'Ekspor Data CSV';

  @override
  String get exportTasksTitle => 'Ekspor Tugas';

  @override
  String get exportTasksSubtitle =>
      'Semua tugas terjadwal, unplanned, dan proyek';

  @override
  String get exportNotesTitle => 'Ekspor Catatan';

  @override
  String get exportNotesSubtitle => 'Semua catatan cepat di Notes';

  @override
  String get exportBothTitle => 'Ekspor Keduanya';

  @override
  String get exportBothSubtitle => 'Berkas CSV tugas dan catatan sekaligus';

  @override
  String get aboutPrivacyTitle => 'Tentang & Kebijakan Privasi';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Versi $version · Offline-first & cloud opsional';
  }

  @override
  String get aboutTitle => 'Tentang Zettask';

  @override
  String versionLabel(String version) {
    return 'Versi $version';
  }

  @override
  String get privacySyncTitle => 'Privasi & Sinkronisasi';

  @override
  String get privacySyncDescription =>
      'Secara bawaan data disimpan lokal di perangkat. Sinkronisasi cloud Firebase bersifat opsional saat Anda masuk akun, dan Anda dapat menghapus akun beserta seluruh data cloud kapan saja.';

  @override
  String get privacyPolicyLabel => 'Kebijakan Privasi';

  @override
  String get privacyLinkCopied => 'Tautan Kebijakan Privasi disalin';

  @override
  String get accountAndSyncTitle => 'Akun & Sinkronisasi';

  @override
  String get signInToZettask => 'Masuk ke Akun Zettask';

  @override
  String get accountBannerSubtitle =>
      'Opsional · cadangkan & sinkronkan data ke cloud';

  @override
  String get authWelcomeTitle => 'Simpan progres dan tugas Anda';

  @override
  String get authWelcomeSubtitle =>
      'Cadangkan jadwal, proyek, dan catatan secara otomatis ke cloud. Anda tetap bisa memakai Zettask secara lokal tanpa akun.';

  @override
  String get createNewAccount => 'Buat akun baru';

  @override
  String get signIn => 'Masuk';

  @override
  String get continueWithGoogle => 'Lanjutkan dengan Google';

  @override
  String get authTermsNotice =>
      'Dengan melanjutkan, Anda menyetujui Syarat & Kebijakan Privasi Zettask.';

  @override
  String get signInToAccountTitle => 'Masuk ke akun Zettask';

  @override
  String get signInToAccountSubtitle =>
      'Data lokal akan digabungkan dengan cadangan cloud Anda.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'nama@email.com';

  @override
  String get emailRequired => 'Email tidak boleh kosong.';

  @override
  String get emailInvalid => 'Format email tidak valid.';

  @override
  String get passwordLabel => 'Kata Sandi';

  @override
  String get passwordHint => 'Masukkan kata sandi';

  @override
  String get passwordNewHint => 'Minimal 6 karakter';

  @override
  String get passwordRequired => 'Kata sandi tidak boleh kosong.';

  @override
  String get passwordTooShort => 'Kata sandi minimal 6 karakter.';

  @override
  String get forgotPassword => 'Lupa?';

  @override
  String get enterValidEmailFirst =>
      'Masukkan alamat email yang valid terlebih dahulu.';

  @override
  String passwordResetSent(String email) {
    return 'Tautan reset kata sandi dikirim ke $email.';
  }

  @override
  String get showPasswordTooltip => 'Tampilkan kata sandi';

  @override
  String get hidePasswordTooltip => 'Sembunyikan kata sandi';

  @override
  String get noAccountPrompt => 'Belum punya akun?';

  @override
  String get createAccountLink => 'Buat akun';

  @override
  String get createAccountTitle => 'Buat Akun';

  @override
  String get createAccountSubtitle =>
      'Cadangkan seluruh tugas, rutinitas, dan catatan ke cloud.';

  @override
  String get haveAccountPrompt => 'Sudah punya akun?';

  @override
  String signedInVia(String provider) {
    return 'Masuk via $provider';
  }

  @override
  String get syncNowButton => 'Sinkronkan sekarang';

  @override
  String get syncingLabel => 'Menyinkronkan...';

  @override
  String get syncDoneMessage => 'Sinkronisasi selesai.';

  @override
  String get syncFailedMessage =>
      'Gagal menyinkronkan data. Periksa koneksi internet Anda.';

  @override
  String get syncStatusIdle => 'Belum disinkronkan';

  @override
  String get syncStatusSyncing => 'Menyinkronkan...';

  @override
  String get syncStatusSynced => 'Tersinkron';

  @override
  String get syncStatusError => 'Gagal sinkronisasi';

  @override
  String lastSyncedPrefix(String time) {
    return 'Terakhir: $time';
  }

  @override
  String get neverSynced => 'Belum pernah disinkronkan';

  @override
  String get signOutButton => 'Keluar';

  @override
  String get signedOutMessage =>
      'Berhasil keluar. Data lokal tetap tersimpan di perangkat.';

  @override
  String get deleteAccountButton => 'Hapus Akun';

  @override
  String get deleteAccountStep1Title => 'Hapus Akun?';

  @override
  String get deleteAccountStep1Body =>
      'Seluruh cadangan data di cloud (tugas, rutinitas, proyek, tag, catatan, dan template) serta akun Anda akan dihapus permanen. Data lokal di perangkat tetap tersimpan.';

  @override
  String get deleteAccountStep2Title => 'Konfirmasi Penghapusan Permanen';

  @override
  String get deleteAccountStep2Body =>
      'Tindakan ini tidak dapat dibatalkan. Yakin ingin menghapus akun dan seluruh data cloud sekarang?';

  @override
  String get deleteAccountConfirmButton => 'Ya, Hapus Permanen';

  @override
  String get accountDeletedMessage =>
      'Akun dan seluruh data cloud telah dihapus permanen.';

  @override
  String get reloginRequiredTitle => 'Perlu Masuk Ulang';

  @override
  String get authErrUserNotFound => 'Akun dengan email ini belum terdaftar.';

  @override
  String get authErrWrongPassword => 'Kata sandi tidak sesuai.';

  @override
  String get authErrInvalidCredential => 'Email atau kata sandi tidak valid.';

  @override
  String get authErrInvalidEmail => 'Format email tidak valid.';

  @override
  String get authErrEmailInUse => 'Email ini sudah terdaftar pada akun lain.';

  @override
  String get authErrWeakPassword =>
      'Kata sandi terlalu lemah. Gunakan minimal 6 karakter.';

  @override
  String get authErrNetwork =>
      'Koneksi internet bermasalah. Periksa jaringan Anda.';

  @override
  String get authErrRequiresRecentLogin =>
      'Demi keamanan, keluar lalu masuk kembali sebelum menghapus akun.';

  @override
  String get authErrTooManyRequests =>
      'Terlalu banyak percobaan. Coba lagi beberapa saat lagi.';

  @override
  String get authErrUserDisabled => 'Akun ini sedang dinonaktifkan.';

  @override
  String get authErrAccountExistsDifferent =>
      'Email ini sudah terdaftar dengan metode masuk lain.';

  @override
  String get authErrOperationNotAllowed => 'Metode masuk ini belum diaktifkan.';

  @override
  String get authErrFirebaseUnavailable =>
      'Layanan akun sedang tidak tersedia. Pastikan perangkat terhubung ke internet.';

  @override
  String get authErrUnknown =>
      'Terjadi kesalahan autentikasi. Silakan coba lagi.';

  @override
  String get widgetTitle => 'Zettask · Hari Ini';

  @override
  String get widgetEmptyText => 'Semua tugas hari ini selesai.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Tugas berulang dan jadwal berikutnya dihapus';

  @override
  String get noProjectTasksTitle => 'Belum ada tugas di proyek ini';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Ketuk + untuk menambah tugas ke proyek $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'Tambah Tugas ke Proyek';

  @override
  String get noTagsSubtitle =>
      'Ketuk + untuk membuat tag warna bagi tugas dan catatan.';

  @override
  String get tagOptionsTooltip => 'Opsi tag';

  @override
  String get deleteTag => 'Hapus tag';

  @override
  String get addTagTooltip => 'Tambah Tag';

  @override
  String get noTasksWithTag => 'Belum ada tugas dengan tag ini.';

  @override
  String get addTaskWithTagTooltip => 'Tambah Tugas dengan Tag';

  @override
  String get tagNameHint => 'Contoh: Kerja, Pribadi, Urgent';

  @override
  String get tagColorLabel => 'Warna Tag';

  @override
  String get createTag => 'Buat Tag';

  @override
  String tagDeletedNamed(String name) {
    return 'Tag \"$name\" dihapus';
  }

  @override
  String get noTemplatesSubtitle =>
      'Simpan struktur tugas dan checklist yang sering dipakai agar lebih cepat dibuat.';

  @override
  String get templateOptionsTooltip => 'Opsi template';

  @override
  String get deleteTemplate => 'Hapus template';

  @override
  String get createTemplateTooltip => 'Buat Template';

  @override
  String templateDeletedNamed(String name) {
    return 'Template \"$name\" dihapus';
  }

  @override
  String get templateNameHint => 'Contoh: Rilis Mingguan';

  @override
  String get defaultTaskTitleLabel => 'Judul tugas bawaan';

  @override
  String get defaultTaskTitleHint => 'Contoh: Siapkan rilis produksi';

  @override
  String get timeOptionalLabel => 'Jam (opsional)';

  @override
  String get clearTimeTooltip => 'Hapus jam';

  @override
  String get projectOptionalLabel => 'Proyek (opsional)';

  @override
  String get tagOptionalLabel => 'Tag (opsional)';

  @override
  String get defaultSubtasksLabel => 'Sub-tugas bawaan';

  @override
  String get addTemplateSubtaskHint => 'Tambah sub-tugas template...';

  @override
  String get saveTemplate => 'Simpan Template';

  @override
  String subtasksTotalCount(int count) {
    return '$count sub-tugas';
  }

  @override
  String get useTemplateButton => 'Pakai Template';

  @override
  String get pickTemplateTitle => 'Pilih Template';

  @override
  String get repeatingTaskDeleted => 'Tugas berulang dihapus';

  @override
  String get noRepeatingTasksSubtitle =>
      'Ketuk + untuk membuat rutinitas harian, mingguan, atau bulanan.';

  @override
  String get addRepeatingTaskTooltip => 'Tambah Tugas Berulang';

  @override
  String get editRepeatingTask => 'Edit Tugas Berulang';

  @override
  String get newRepeatingTask => 'Tugas Berulang Baru';

  @override
  String get deleteTaskTooltip => 'Hapus tugas';

  @override
  String get scheduleLabel => 'Jadwal';

  @override
  String get startAndTimeLabel => 'Mulai & Jam';

  @override
  String get dateRequiredForTime => 'Perlu tanggal';

  @override
  String get clearDateTooltip => 'Hapus tanggal';

  @override
  String get pickTimeFirstReminder =>
      'Pilih jam terlebih dahulu untuk mengaktifkan pengingat.';

  @override
  String get notificationPermissionDenied =>
      'Izin notifikasi belum aktif. Aktifkan di pengaturan perangkat agar pengingat tampil.';

  @override
  String get pickDateFirstRepeat =>
      'Pilih tanggal terlebih dahulu untuk mengatur pengulangan.';

  @override
  String get subtasksLabel => 'Sub-tugas';

  @override
  String subtasksWithCount(int count) {
    return 'Sub-tugas ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Hapus sub-tugas';

  @override
  String get addSubtaskTooltip => 'Tambah sub-tugas';

  @override
  String get moveAllOverdueMoved =>
      'Semua tugas terlambat dipindah ke hari ini';

  @override
  String get moveAllShort => 'Pindah semua';

  @override
  String get noOverdueTasksSubtitle =>
      'Semua tugas dari hari sebelumnya sudah selesai.';

  @override
  String get repeatingDeletePrompt => 'Apa yang ingin dihapus?';

  @override
  String get repeatingEditPrompt => 'Apa yang ingin diubah?';

  @override
  String get repeatingDeleteSingleSub => 'Hapus hanya jadwal ini';

  @override
  String get repeatingEditSingleSub => 'Ubah hanya jadwal ini';

  @override
  String get repeatingDeleteFollowingSub =>
      'Hapus jadwal ini dan semua jadwal berikutnya';

  @override
  String get repeatingEditFollowingSub =>
      'Terapkan ke hari ini dan jadwal berikutnya';

  @override
  String get deviceCalendarTitle => 'Kalender Perangkat';

  @override
  String get selectCalendarsLabel => 'Pilih Kalender';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total aktif';
  }

  @override
  String get showCalendarEventsTitle => 'Tampilkan Acara Kalender';

  @override
  String get showCalendarEventsSubtitle =>
      'Acara perangkat tampil kronologis secara hanya baca.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Izin Kalender Ditolak Permanen';

  @override
  String get calendarPermRequiredTitle => 'Izin Baca Kalender Diperlukan';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Aktifkan izin baca kalender di Pengaturan perangkat, lalu ketuk Periksa Ulang.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask hanya meminta izin baca kalender untuk menampilkan acara Anda di timeline.';

  @override
  String get openSettingsButton => 'Buka Pengaturan';

  @override
  String get checkAgainButton => 'Periksa Ulang';

  @override
  String get noCalendarsFound =>
      'Tidak ada kalender ditemukan di perangkat ini.';

  @override
  String get eventDetailTitle => 'Detail Acara';

  @override
  String get eventNotesLabel => 'Catatan';

  @override
  String get calendarEventReadOnlyBanner =>
      'Acara dari kalender perangkat (hanya baca).';

  @override
  String get markUncompletedSemantics => 'Tandai belum selesai';

  @override
  String get markCompletedSemantics => 'Tandai selesai';

  @override
  String get deleteNoteTooltip => 'Hapus catatan';

  @override
  String repeatMonthlyDay(int day) {
    return 'Setiap bulan · tgl $day';
  }

  @override
  String get last30DaysSubtitle => '30 hari terakhir';

  @override
  String get allTimeSubtitle => 'Sepanjang waktu';

  @override
  String get taskCancelled => 'Tugas ditandai dibatalkan';

  @override
  String get taskRestored => 'Tugas diaktifkan kembali';

  @override
  String get cancelledStatusLabel => 'Dibatalkan';

  @override
  String get restoreTaskLabel => 'Aktifkan';

  @override
  String get markCancelledSemantics => 'Tandai dibatalkan';

  @override
  String get calendarPermFallbackHint =>
      'Jika dialog izin tidak muncul, buka Pengaturan Aplikasi untuk mengaktifkan izin Kalender secara manual.';

  @override
  String get calendarBadgeLabel => 'Kalender';

  @override
  String get calendarSourceLabel => 'Kalender';

  @override
  String get calendarLocationLabel => 'Lokasi';

  @override
  String get calendarReadOnlyInfo =>
      'Disinkronkan dari kalender perangkat. Item ini hanya dapat dibaca dan tidak dapat diedit di Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Sinkronisasi cloud, kalender perangkat, kunci aplikasi, dan tema OLED dalam satu paket.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Aktif — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Terima kasih telah mendukung Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'Tema AMOLED, warna aksen kustom, gaya widget & lainnya';

  @override
  String get proBenefitCloudSync => 'Sinkronisasi Cloud & Multi-Perangkat';

  @override
  String get proBenefitCalendar => 'Integrasi Kalender & Hari Libur Nasional';

  @override
  String get proBenefitAppLock =>
      'Kunci Aplikasi Biometrik & Privasi Recent Apps';

  @override
  String get proBenefitProjectsCsv => 'Proyek Tanpa Batas & Ekspor CSV';

  @override
  String get proBenefitCustomization =>
      'Tema AMOLED Pure Black, Warna Aksen Kustom & Gaya Widget';

  @override
  String get proPlanMonthlyTitle => 'Bulanan';

  @override
  String get proPlanMonthlyPrice => 'Rp19.000 / bulan';

  @override
  String get proPlanYearlyTitle => 'Tahunan';

  @override
  String get proPlanYearlyPrice => 'Rp129.000 / tahun';

  @override
  String get proPlanYearlyBadge => 'Paling Hemat';

  @override
  String get proPlanYearlySavings => 'Hemat ~43%';

  @override
  String get proPlanLifetimeTitle => 'Seumur Hidup';

  @override
  String get proPlanLifetimePrice => 'Rp299.000';

  @override
  String get proPlanLifetimeBadge => 'Sekali Bayar';

  @override
  String get proContinueButton => 'Lanjutkan';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro Aktif';

  @override
  String get proRestorePurchasesButton => 'Pulihkan Pembelian';

  @override
  String get proLegalFootnote =>
      'Langganan diperpanjang otomatis kecuali dibatalkan. Batalkan kapan saja melalui Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'Pembelian Google Play belum tersedia di perangkat ini. Coba lagi setelah terhubung ke Google Play.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro kini aktif.';

  @override
  String get proRestoreSuccessMessage =>
      'Pembelian Zettask Pro berhasil dipulihkan.';

  @override
  String get proRestoreEmptyMessage =>
      'Tidak ditemukan pembelian Zettask Pro aktif pada akun ini.';

  @override
  String get proPurchaseFailedMessage =>
      'Pembelian tidak dapat diselesaikan saat ini. Silakan coba lagi.';

  @override
  String get debugProSimulationLabel => 'Mode Pengembang: Simulasi Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED Pure Black';

  @override
  String get amoledPureBlackSubtitle =>
      'Latar gelap #000000 murni untuk hemat baterai OLED';

  @override
  String get customAccentSection => 'Warna Aksen Kustom';

  @override
  String get accentMonochrome => 'Monochrome';

  @override
  String get accentSage => 'Sage';

  @override
  String get accentIndigo => 'Indigo';

  @override
  String get accentTerracotta => 'Terracotta';

  @override
  String get accentAmber => 'Amber';

  @override
  String get widgetStyleSection => 'Gaya Home Screen Widget';

  @override
  String get widgetStyleStandard => 'Standar';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Transparan';

  @override
  String get proContextUnlimitedProjects =>
      'Paket Gratis mendukung hingga 3 proyek. Upgrade ke Zettask Pro untuk proyek tanpa batas.';

  @override
  String get proContextCalendarSync =>
      'Integrasi kalender perangkat dan Hari Libur Nasional tersedia di Zettask Pro.';

  @override
  String get proContextAppLock =>
      'Kunci Aplikasi Biometrik dan privasi Recent Apps tersedia di Zettask Pro.';

  @override
  String get proContextCsvExport =>
      'Ekspor tugas dan catatan ke berkas CSV tersedia di Zettask Pro.';

  @override
  String get proContextCloudSync =>
      'Sinkronisasi Cloud antar perangkat tersedia di Zettask Pro.';

  @override
  String get proContextCustomThemes =>
      'Tema AMOLED Pure Black dan warna aksen kustom tersedia di Zettask Pro.';

  @override
  String get proContextWidgetStyles =>
      'Gaya Home Screen Widget AMOLED dan Transparan tersedia di Zettask Pro.';

  @override
  String get cloudSyncPausedShort => 'Sinkronisasi dijeda · Data lokal aman';

  @override
  String get cloudSyncPausedTitle => 'Sinkronisasi Cloud dijeda';

  @override
  String get cloudSyncPausedBody =>
      'Langganan Zettask Pro tidak aktif. Tugas dan catatan lokal Anda tetap aman di perangkat ini.';

  @override
  String get resumeSyncWithProButton => 'Lanjutkan Sinkronisasi dengan Pro';

  @override
  String get onboardingSkip => 'Lewati';

  @override
  String get onboardingNext => 'Lanjut';

  @override
  String get onboardingGetStarted => 'Mulai Sekarang';

  @override
  String get onboardingSlide1Title => 'Catat tugas tanpa distraksi';

  @override
  String get onboardingSlide1Body =>
      'Tambahkan tugas harian dalam hitungan detik, pecah menjadi sub-tugas, dan selesaikan dengan satu ketukan.';

  @override
  String get onboardingSlide2Title => 'Timeline rapi & terencana';

  @override
  String get onboardingSlide2Body =>
      'Lihat jadwal harian secara kronologis, kelompokkan ke dalam proyek, dan tetap tepat waktu dengan pengingat lokal.';

  @override
  String get onboardingSlide3Title => 'Cepat, offline, dan privat';

  @override
  String get onboardingSlide3Body =>
      'Semua data tersimpan lokal di perangkat Anda. Tanpa wajib akun dan tetap cepat tanpa internet.';

  @override
  String get appGuideTitle => 'Panduan Aplikasi';

  @override
  String get appGuideSubtitle => 'Putar ulang panduan singkat Zettask';

  @override
  String get dynamicColorTitle => 'Material You (Warna Wallpaper)';

  @override
  String get dynamicColorSubtitle =>
      'Sesuaikan warna aksen dengan wallpaper perangkat (Android 12+)';

  @override
  String get subtaskMarkedCancelled => 'Sub-tugas dibatalkan';

  @override
  String get subtaskCancelledBadge => 'Dibatalkan';

  @override
  String get cancelSubtaskTooltip => 'Batalkan sub-tugas';

  @override
  String get restoreSubtaskTooltip => 'Pulihkan sub-tugas';

  @override
  String get notificationActionComplete => 'Selesai';

  @override
  String get notificationActionSnooze => 'Tunda';

  @override
  String get notificationActionDismiss => 'Tutup';

  @override
  String notificationSubtasksMore(int count) {
    return '+$count lainnya';
  }

  @override
  String notificationSubtasksSummary(int completed, int total) {
    return '$completed/$total selesai';
  }
}

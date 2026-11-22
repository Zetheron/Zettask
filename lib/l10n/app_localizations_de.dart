// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Zeitplan';

  @override
  String get navBoard => 'Board';

  @override
  String get navUnplanned => 'Ungeplant';

  @override
  String get navMore => 'Mehr';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get close => 'Schließen';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get undo => 'Rückgängig';

  @override
  String get back => 'Zurück';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get clear => 'Leeren';

  @override
  String get all => 'Alle';

  @override
  String get or => 'oder';

  @override
  String get continueAction => 'Weiter';

  @override
  String get understand => 'Verstanden';

  @override
  String get useAction => 'Verwenden';

  @override
  String get today => 'Heute';

  @override
  String get tomorrow => 'Morgen';

  @override
  String get yesterday => 'Gestern';

  @override
  String get toDo => 'Offen';

  @override
  String get overdue => 'Überfällig';

  @override
  String get unplanned => 'Ungeplant';

  @override
  String get allDay => 'Ganztägig';

  @override
  String get scheduled => 'Geplant';

  @override
  String get addTaskToday => 'Aufgabe für heute hinzufügen';

  @override
  String get addTask => 'Aufgabe hinzufügen';

  @override
  String get noTasksForDate => 'Keine Aufgaben für dieses Datum.';

  @override
  String get savedToUnplanned => 'Unter Ungeplant gespeichert';

  @override
  String get savedToUnplannedNoDate =>
      'Unter Ungeplant gespeichert (ohne Datum)';

  @override
  String scheduledForDate(String date) {
    return 'Geplant für $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Aufgabe geplant für $date';
  }

  @override
  String get taskDeleted => 'Aufgabe gelöscht';

  @override
  String get searchTasksTooltip => 'Aufgaben suchen';

  @override
  String get timelineOptionsTooltip => 'Zeitplan-Optionen';

  @override
  String get addTaskTooltip => 'Aufgabe hinzufügen';

  @override
  String get completedLabel => 'Erledigt';

  @override
  String get uncompleteLabel => 'Als offen markieren';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total Unteraufgaben';
  }

  @override
  String get repeatingTaskLabel => 'Wiederkehrende Aufgabe';

  @override
  String get quickAddHint => 'Neue Aufgabe hinzufügen...';

  @override
  String get expandTooltip => 'Erweitern';

  @override
  String get saveTaskTooltip => 'Aufgabe speichern';

  @override
  String get newTask => 'Neue Aufgabe';

  @override
  String get editTask => 'Aufgabe bearbeiten';

  @override
  String get taskTitleLabel => 'Aufgabentitel';

  @override
  String get taskTitleHint => 'z. B. Sprint-Notizen prüfen';

  @override
  String get taskTitleRequired => 'Aufgabentitel ist erforderlich';

  @override
  String get descriptionLabel => 'Beschreibung';

  @override
  String get descriptionHint => 'Notizen oder Details hinzufügen...';

  @override
  String get pickDate => 'Datum wählen';

  @override
  String get pickOnCalendar => 'Im Kalender wählen...';

  @override
  String get noDateUnplanned => 'Ohne Datum (Ungeplant)';

  @override
  String get noDate => 'Ohne Datum';

  @override
  String get taskTime => 'Uhrzeit';

  @override
  String get changeTime => 'Uhrzeit ändern';

  @override
  String get clearTimeAllDay => 'Uhrzeit entfernen (Ganztägig)';

  @override
  String get timeLabel => 'Uhrzeit';

  @override
  String get reminderLabel => 'Erinnerung';

  @override
  String get noReminder => 'Keine Erinnerung';

  @override
  String get atTime => 'Pünktlich';

  @override
  String get minutesBefore10 => '10 Min. vorher';

  @override
  String get minutesBefore30 => '30 Min. vorher';

  @override
  String get hourBefore1 => '1 Stunde vorher';

  @override
  String get reminderShort10m => '10 Min.';

  @override
  String get reminderShort30m => '30 Min.';

  @override
  String get reminderShort1h => '1 Std.';

  @override
  String get projectLabel => 'Projekt';

  @override
  String get noProject => 'Kein Projekt';

  @override
  String get tagLabel => 'Tag';

  @override
  String get noTag => 'Kein Tag';

  @override
  String get priorityLabel => 'Priorität';

  @override
  String get priorityLow => 'Niedrig';

  @override
  String get priorityMedium => 'Mittel';

  @override
  String get priorityHigh => 'Hoch';

  @override
  String get saveTask => 'Aufgabe speichern';

  @override
  String get saveChanges => 'Änderungen speichern';

  @override
  String get checklistLabel => 'Checkliste';

  @override
  String get addChecklistHint => 'Checklistenpunkt hinzufügen...';

  @override
  String get repeatLabel => 'Wiederholen';

  @override
  String get noRepeat => 'Keine Wiederholung';

  @override
  String get repeatDaily => 'Täglich';

  @override
  String get repeatWeekly => 'Wöchentlich';

  @override
  String get repeatMonthly => 'Monatlich';

  @override
  String get colorLabel => 'Farbe';

  @override
  String get timelineOptionsTitle => 'Zeitplan-Optionen';

  @override
  String get viewModeLabel => 'Ansichtsmodus';

  @override
  String get modeTimeline => 'Zeitplan-Modus';

  @override
  String get modeDaily => 'Tagesmodus';

  @override
  String get firstDayOfWeek => 'Wochenbeginn';

  @override
  String get monday => 'Montag';

  @override
  String get sunday => 'Sonntag';

  @override
  String get firstDayMondayOrder => 'Mo · Di · Mi · Do · Fr · Sa · So';

  @override
  String get firstDaySundayOrder => 'So · Mo · Di · Mi · Do · Fr · Sa';

  @override
  String get showCompletedTasks => 'Erledigte Aufgaben anzeigen';

  @override
  String get showCompletedTasksSubtitle =>
      'Blende abgehakte Aufgaben aus, um fokussiert zu bleiben.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Erledigte Aufgaben ein- oder ausblenden.';

  @override
  String get overdueTasksTitle => 'Überfällige Aufgaben';

  @override
  String get noOverdueTasks => 'Keine überfälligen Aufgaben';

  @override
  String get moveToToday => 'Auf Heute verschieben';

  @override
  String get moveAllToToday => 'Alle auf Heute verschieben';

  @override
  String get searchTasksHint => 'Aufgaben suchen...';

  @override
  String get searchTasksEmpty =>
      'Tippe, um Aufgaben, Beschreibungen oder Checklisten zu suchen.';

  @override
  String searchNoResults(String query) {
    return 'Keine Aufgaben für \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'Kalendertermin · schreibgeschützt';

  @override
  String get prevWeekTooltip => 'Vorherige Woche';

  @override
  String get nextWeekTooltip => 'Nächste Woche';

  @override
  String get boardTitle => 'Board';

  @override
  String get allProjects => 'Alle Projekte';

  @override
  String get searchProjectHint => 'Projektname suchen...';

  @override
  String get searchProjectTooltip => 'Projekte suchen';

  @override
  String get closeSearchTooltip => 'Suche schließen';

  @override
  String get createProject => 'Projekt erstellen';

  @override
  String get editProject => 'Projekt bearbeiten';

  @override
  String get deleteProject => 'Projekt löschen';

  @override
  String get projectOptionsTooltip => 'Projektoptionen';

  @override
  String projectDeleted(String name) {
    return 'Projekt \"$name\" gelöscht';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total erledigt';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total Aufgaben erledigt';
  }

  @override
  String get projectNotFound => 'Projekt nicht gefunden';

  @override
  String get noProjectsYet => 'Noch keine Projekte';

  @override
  String projectSearchEmpty(String query) {
    return 'Kein Projekt passt zu \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'Tippe unten auf den Ordner, um dein erstes Projekt zu erstellen.';

  @override
  String get newProject => 'Neues Projekt';

  @override
  String get projectNameLabel => 'Projektname';

  @override
  String get projectNameHint => 'z. B. Zettask Release';

  @override
  String get projectNameRequired => 'Projektname ist erforderlich';

  @override
  String get projectColorLabel => 'Projektfarbe';

  @override
  String get unplannedTitle => 'Ungeplant';

  @override
  String activeCountLabel(int count) {
    return '$count aktiv';
  }

  @override
  String get noUnplannedTitle => 'Keine ungeplanten Aufgaben';

  @override
  String get noUnplannedSubtitle =>
      'Tippe auf +, um Aufgaben ohne Datum zu erfassen.';

  @override
  String get addUnplannedTooltip => 'Ungeplante Aufgabe hinzufügen';

  @override
  String get workspaceTitle => 'Arbeitsbereich';

  @override
  String get organizeSection => 'Organisieren';

  @override
  String get automationSection => 'Automatisierung';

  @override
  String get insightsSection => 'Statistik & Design';

  @override
  String get settingsInfoSection => 'Einstellungen & Info';

  @override
  String get tagsTitle => 'Tags';

  @override
  String get tagsSubtitleEmpty => 'Farblabels für Aufgaben und Notizen';

  @override
  String tagsCountSubtitle(int count) {
    return '$count Tags gespeichert';
  }

  @override
  String get newTag => 'Neuer Tag';

  @override
  String get editTag => 'Tag bearbeiten';

  @override
  String get tagNameLabel => 'Tag-Name';

  @override
  String get tagNameRequired => 'Tag-Name ist erforderlich';

  @override
  String get tagDeleted => 'Tag gelöscht';

  @override
  String get noTagsYet => 'Noch keine Tags';

  @override
  String tagTasksCount(int count) {
    return '$count Aufgaben';
  }

  @override
  String get templatesTitle => 'Vorlagen';

  @override
  String get templatesSubtitleEmpty =>
      'Aufgaben- und Checklisten-Strukturen speichern';

  @override
  String templatesCountSubtitle(int count) {
    return '$count Vorlagen bereit';
  }

  @override
  String get newTemplate => 'Neue Vorlage';

  @override
  String get editTemplate => 'Vorlage bearbeiten';

  @override
  String get templateNameLabel => 'Vorlagenname';

  @override
  String get templateNameRequired => 'Vorlagenname ist erforderlich';

  @override
  String get templateDeleted => 'Vorlage gelöscht';

  @override
  String get noTemplatesYet => 'Noch keine Vorlagen';

  @override
  String get taskFromTemplateSaved => 'Aufgabe aus Vorlage gespeichert';

  @override
  String get notesTitle => 'Notizen';

  @override
  String get notesSubtitleEmpty => 'Schnelle Notizen ohne Datum';

  @override
  String notesCountSubtitle(int count) {
    return '$count Notizen gespeichert';
  }

  @override
  String get newNote => 'Neue Notiz';

  @override
  String get editNote => 'Notiz bearbeiten';

  @override
  String get noteTitleLabel => 'Notiztitel';

  @override
  String get noteTitleHint => 'z. B. Besprechungsnotizen';

  @override
  String get noteTitleRequired => 'Notiztitel ist erforderlich';

  @override
  String get noteContentLabel => 'Inhalt';

  @override
  String get noteContentHint => 'Notiz hier schreiben...';

  @override
  String get noteDeleted => 'Notiz gelöscht';

  @override
  String get searchNotesHint => 'Notizen suchen...';

  @override
  String get noteNotFound => 'Notiz nicht gefunden';

  @override
  String get noNotesYet => 'Noch keine Notizen';

  @override
  String noteSearchEmpty(String query) {
    return 'Keine Notiz passt zu \"$query\".';
  }

  @override
  String get noNotesSubtitle => 'Tippe auf + für eine schnelle Notiz.';

  @override
  String get saveNote => 'Notiz speichern';

  @override
  String get repeatingTasksTitle => 'Wiederkehrende Aufgaben';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Tägliche, wöchentliche und monatliche Routinen';

  @override
  String repeatingActiveCount(int count) {
    return '$count aktive Routinen';
  }

  @override
  String get noRepeatingTasks => 'Noch keine wiederkehrenden Aufgaben';

  @override
  String get repeatingActionTitle => 'Dies ist eine wiederkehrende Aufgabe';

  @override
  String get repeatingThisOnly => 'Nur diese Aufgabe';

  @override
  String get repeatingThisAndFollowing => 'Diese und alle folgenden Aufgaben';

  @override
  String get last7DaysUpper => 'LETZTE 7 TAGE';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks Aufgaben, plus $checklists Checklistenpunkte';
  }

  @override
  String get statsTitle => 'Statistik';

  @override
  String get range7Days => '7 Tage';

  @override
  String get range30Days => '30 Tage';

  @override
  String get completedToday => 'Heute erledigt';

  @override
  String get last7DaysLabel => 'Letzte 7 Tage';

  @override
  String get last30DaysLabel => 'Letzte 30 Tage';

  @override
  String get allTimeLabel => 'Gesamt';

  @override
  String get completionRateLabel => 'Abschlussrate';

  @override
  String get activity7Days => 'Aktivität der letzten 7 Tage';

  @override
  String get activity30Days => 'Aktivität der letzten 30 Tage';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks Aufgaben · $checklists Punkte';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Gesamt ($days Tage): $tasks Aufgaben, plus $checklists Checklistenpunkte';
  }

  @override
  String get completedByPriority => 'Erledigt nach Priorität';

  @override
  String get progressByProject => 'Fortschritt nach Projekt';

  @override
  String get breakdownByTag => 'Aufschlüsselung nach Tag';

  @override
  String get habits30Days => 'Gewohnheiten · 30 Tage';

  @override
  String get noProjectsCreated => 'Noch keine Projekte erstellt.';

  @override
  String get noTagsCreated => 'Noch keine Tags erstellt.';

  @override
  String get noActiveHabits => 'Noch keine aktiven Routinen.';

  @override
  String completedCountLabel(int count) {
    return '$count erledigt';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total erledigt';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled erledigt';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed erledigt · $percent% Abschlussrate';
  }

  @override
  String get themeTitle => 'Design';

  @override
  String get themeAndColorsTitle => 'Design & Farben';

  @override
  String get livePreviewSection => 'Live-Vorschau';

  @override
  String get appearanceModeSection => 'Darstellung';

  @override
  String get colorPaletteSection => 'Farbpalette';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get themeSystem => 'System';

  @override
  String get themeSystemLight => 'System (Hell)';

  @override
  String get themeSystemDark => 'System (Dunkel)';

  @override
  String get presetDefault => 'Standard';

  @override
  String get presetDefaultDesc => 'Indigo & Schiefer';

  @override
  String get presetOcean => 'Ozean';

  @override
  String get presetOceanDesc => 'Ruhiges Blau';

  @override
  String get presetForest => 'Wald';

  @override
  String get presetForestDesc => 'Salbei & Smaragd';

  @override
  String get presetTerracotta => 'Terrakotta';

  @override
  String get presetTerracottaDesc => 'Warmes Ziegelorange';

  @override
  String get presetPlum => 'Pflaume';

  @override
  String get presetPlumDesc => 'Sanftes Violett';

  @override
  String get presetMonochrome => 'Monochrom';

  @override
  String get presetMonochromeDesc => 'Anthrazit & Schwarz';

  @override
  String get previewActiveTask => 'Oberflächendesign prüfen';

  @override
  String get previewCompletedTask => 'Wochenplan synchronisieren';

  @override
  String get languageTitle => 'Sprache';

  @override
  String get deviceLanguageOption => 'Gerätesprache (falls unterstützt)';

  @override
  String get appLockTitle => 'App-Sperre';

  @override
  String get appLockSubtitle => 'Fingerabdruck, Gesicht oder Geräte-PIN';

  @override
  String get appLockLockedTitle => 'Zettask gesperrt';

  @override
  String get appLockLockedSubtitle =>
      'Entsperre mit Fingerabdruck, Gesicht oder Geräte-PIN.';

  @override
  String get unlockButton => 'Entsperren';

  @override
  String get verifyingButton => 'Wird geprüft...';

  @override
  String get appLockUnsupportedError =>
      'Auf diesem Gerät ist keine Biometrie oder PIN aktiviert.';

  @override
  String get appLockCancelledError =>
      'Bestätigung abgebrochen oder fehlgeschlagen.';

  @override
  String get appLockUnlockFailedError =>
      'Authentifizierung fehlgeschlagen. Tippe auf Entsperren.';

  @override
  String get calendarSyncTitle => 'Kalendersynchronisierung';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Aktiv · $count Kalender';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'Aus · Gerätetermine schreibgeschützt anzeigen';

  @override
  String get grantCalendarPermission => 'Kalenderzugriff erlauben';

  @override
  String get exportCsvTitle => 'CSV exportieren';

  @override
  String get exportCsvSubtitle => 'Aufgaben oder Notizen als CSV teilen';

  @override
  String get exportDataCsvTitle => 'CSV-Daten exportieren';

  @override
  String get exportTasksTitle => 'Aufgaben exportieren';

  @override
  String get exportTasksSubtitle =>
      'Alle geplanten, ungeplanten und Projektaufgaben';

  @override
  String get exportNotesTitle => 'Notizen exportieren';

  @override
  String get exportNotesSubtitle => 'Alle schnellen Notizen';

  @override
  String get exportBothTitle => 'Beides exportieren';

  @override
  String get exportBothSubtitle => 'Aufgaben- und Notizen-CSV zusammen';

  @override
  String get aboutPrivacyTitle => 'Über & Datenschutz';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Version $version · Offline-first & optionale Cloud';
  }

  @override
  String get aboutTitle => 'Über Zettask';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get privacySyncTitle => 'Datenschutz & Synchronisierung';

  @override
  String get privacySyncDescription =>
      'Standardmäßig bleiben deine Daten lokal auf dem Gerät. Firebase-Cloud-Sync ist nach Anmeldung optional, und Konto sowie Cloud-Daten lassen sich jederzeit dauerhaft löschen.';

  @override
  String get privacyPolicyLabel => 'Datenschutzerklärung';

  @override
  String get privacyLinkCopied => 'Datenschutz-Link kopiert';

  @override
  String get accountAndSyncTitle => 'Konto & Sync';

  @override
  String get signInToZettask => 'Bei Zettask anmelden';

  @override
  String get accountBannerSubtitle => 'Optional · Daten in der Cloud sichern';

  @override
  String get authWelcomeTitle => 'Sichere deinen Fortschritt';

  @override
  String get authWelcomeSubtitle =>
      'Sichere Zeitpläne, Projekte und Notizen automatisch in der Cloud. Du kannst Zettask weiterhin lokal ohne Konto nutzen.';

  @override
  String get createNewAccount => 'Neues Konto erstellen';

  @override
  String get signIn => 'Anmelden';

  @override
  String get continueWithGoogle => 'Mit Google fortfahren';

  @override
  String get authTermsNotice =>
      'Mit dem Fortfahren akzeptierst du die Bedingungen & den Datenschutz von Zettask.';

  @override
  String get signInToAccountTitle => 'Bei Zettask anmelden';

  @override
  String get signInToAccountSubtitle =>
      'Lokale Daten werden mit deiner Cloud-Sicherung zusammengeführt.';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get emailHint => 'name@email.com';

  @override
  String get emailRequired => 'E-Mail ist erforderlich.';

  @override
  String get emailInvalid => 'Ungültiges E-Mail-Format.';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get passwordHint => 'Passwort eingeben';

  @override
  String get passwordNewHint => 'Mindestens 6 Zeichen';

  @override
  String get passwordRequired => 'Passwort ist erforderlich.';

  @override
  String get passwordTooShort =>
      'Das Passwort muss mindestens 6 Zeichen lang sein.';

  @override
  String get forgotPassword => 'Vergessen?';

  @override
  String get enterValidEmailFirst =>
      'Bitte zuerst eine gültige E-Mail eingeben.';

  @override
  String passwordResetSent(String email) {
    return 'Link zum Zurücksetzen an $email gesendet.';
  }

  @override
  String get showPasswordTooltip => 'Passwort anzeigen';

  @override
  String get hidePasswordTooltip => 'Passwort ausblenden';

  @override
  String get noAccountPrompt => 'Noch kein Konto?';

  @override
  String get createAccountLink => 'Konto erstellen';

  @override
  String get createAccountTitle => 'Konto erstellen';

  @override
  String get createAccountSubtitle =>
      'Sichere alle Aufgaben, Routinen und Notizen in der Cloud.';

  @override
  String get haveAccountPrompt => 'Bereits ein Konto?';

  @override
  String signedInVia(String provider) {
    return 'Angemeldet über $provider';
  }

  @override
  String get syncNowButton => 'Jetzt synchronisieren';

  @override
  String get syncingLabel => 'Synchronisiert...';

  @override
  String get syncDoneMessage => 'Synchronisierung abgeschlossen.';

  @override
  String get syncFailedMessage =>
      'Synchronisierung fehlgeschlagen. Internetverbindung prüfen.';

  @override
  String get syncStatusIdle => 'Noch nicht synchronisiert';

  @override
  String get syncStatusSyncing => 'Synchronisiert...';

  @override
  String get syncStatusSynced => 'Synchronisiert';

  @override
  String get syncStatusError => 'Sync fehlgeschlagen';

  @override
  String lastSyncedPrefix(String time) {
    return 'Zuletzt: $time';
  }

  @override
  String get neverSynced => 'Nie synchronisiert';

  @override
  String get signOutButton => 'Abmelden';

  @override
  String get signedOutMessage =>
      'Abgemeldet. Lokale Daten bleiben auf dem Gerät.';

  @override
  String get deleteAccountButton => 'Konto löschen';

  @override
  String get deleteAccountStep1Title => 'Konto löschen?';

  @override
  String get deleteAccountStep1Body =>
      'Alle Cloud-Sicherungen und dein Konto werden dauerhaft gelöscht. Lokale Daten auf diesem Gerät bleiben erhalten.';

  @override
  String get deleteAccountStep2Title => 'Dauerhaftes Löschen bestätigen';

  @override
  String get deleteAccountStep2Body =>
      'Diese Aktion kann nicht rückgängig gemacht werden. Konto und Cloud-Daten jetzt dauerhaft löschen?';

  @override
  String get deleteAccountConfirmButton => 'Ja, dauerhaft löschen';

  @override
  String get accountDeletedMessage =>
      'Konto und alle Cloud-Daten wurden dauerhaft gelöscht.';

  @override
  String get reloginRequiredTitle => 'Erneute Anmeldung erforderlich';

  @override
  String get authErrUserNotFound => 'Kein Konto mit dieser E-Mail gefunden.';

  @override
  String get authErrWrongPassword => 'Falsches Passwort.';

  @override
  String get authErrInvalidCredential =>
      'Ungültige E-Mail oder falsches Passwort.';

  @override
  String get authErrInvalidEmail => 'Ungültiges E-Mail-Format.';

  @override
  String get authErrEmailInUse => 'Diese E-Mail wird bereits verwendet.';

  @override
  String get authErrWeakPassword =>
      'Passwort zu schwach. Mindestens 6 Zeichen verwenden.';

  @override
  String get authErrNetwork =>
      'Netzwerkfehler. Bitte Internetverbindung prüfen.';

  @override
  String get authErrRequiresRecentLogin =>
      'Aus Sicherheitsgründen bitte ab- und erneut anmelden, bevor du das Konto löschst.';

  @override
  String get authErrTooManyRequests => 'Zu viele Versuche. Bitte kurz warten.';

  @override
  String get authErrUserDisabled => 'Dieses Konto wurde deaktiviert.';

  @override
  String get authErrAccountExistsDifferent =>
      'Diese E-Mail ist mit einer anderen Anmeldemethode verknüpft.';

  @override
  String get authErrOperationNotAllowed =>
      'Diese Anmeldemethode ist nicht aktiviert.';

  @override
  String get authErrFirebaseUnavailable =>
      'Kontodienst derzeit nicht verfügbar.';

  @override
  String get authErrUnknown =>
      'Authentifizierungsfehler. Bitte erneut versuchen.';

  @override
  String get widgetTitle => 'Zettask · Heute';

  @override
  String get widgetEmptyText => 'Alle Aufgaben für heute sind erledigt.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Wiederkehrende Aufgabe und folgende Termine gelöscht';

  @override
  String get noProjectTasksTitle => 'Noch keine Aufgaben in diesem Projekt';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Tippe auf +, um eine Aufgabe zu $project hinzuzufügen.';
  }

  @override
  String get addTaskToProjectTooltip => 'Aufgabe zum Projekt hinzufügen';

  @override
  String get noTagsSubtitle =>
      'Tippe auf +, um farbige Tags für Aufgaben und Notizen zu erstellen.';

  @override
  String get tagOptionsTooltip => 'Tag-Optionen';

  @override
  String get deleteTag => 'Tag löschen';

  @override
  String get addTagTooltip => 'Tag hinzufügen';

  @override
  String get noTasksWithTag => 'Noch keine Aufgaben mit diesem Tag.';

  @override
  String get addTaskWithTagTooltip => 'Aufgabe mit Tag hinzufügen';

  @override
  String get tagNameHint => 'z. B. Arbeit, Privat, Dringend';

  @override
  String get tagColorLabel => 'Tag-Farbe';

  @override
  String get createTag => 'Tag erstellen';

  @override
  String tagDeletedNamed(String name) {
    return 'Tag \"$name\" gelöscht';
  }

  @override
  String get noTemplatesSubtitle =>
      'Speichere häufig genutzte Aufgaben- und Checklistenstrukturen.';

  @override
  String get templateOptionsTooltip => 'Vorlagenoptionen';

  @override
  String get deleteTemplate => 'Vorlage löschen';

  @override
  String get createTemplateTooltip => 'Vorlage erstellen';

  @override
  String templateDeletedNamed(String name) {
    return 'Vorlage \"$name\" gelöscht';
  }

  @override
  String get templateNameHint => 'z. B. Wöchentliches Release';

  @override
  String get defaultTaskTitleLabel => 'Standard-Aufgabentitel';

  @override
  String get defaultTaskTitleHint => 'z. B. Produktions-Release vorbereiten';

  @override
  String get timeOptionalLabel => 'Uhrzeit (optional)';

  @override
  String get clearTimeTooltip => 'Uhrzeit entfernen';

  @override
  String get projectOptionalLabel => 'Projekt (optional)';

  @override
  String get tagOptionalLabel => 'Tag (optional)';

  @override
  String get defaultSubtasksLabel => 'Standard-Unteraufgaben';

  @override
  String get addTemplateSubtaskHint => 'Vorlagen-Unteraufgabe hinzufügen...';

  @override
  String get saveTemplate => 'Vorlage speichern';

  @override
  String subtasksTotalCount(int count) {
    return '$count Unteraufgaben';
  }

  @override
  String get useTemplateButton => 'Vorlage nutzen';

  @override
  String get pickTemplateTitle => 'Vorlage wählen';

  @override
  String get repeatingTaskDeleted => 'Wiederkehrende Aufgabe gelöscht';

  @override
  String get noRepeatingTasksSubtitle =>
      'Tippe auf +, um tägliche, wöchentliche oder monatliche Routinen zu erstellen.';

  @override
  String get addRepeatingTaskTooltip => 'Wiederkehrende Aufgabe hinzufügen';

  @override
  String get editRepeatingTask => 'Wiederkehrende Aufgabe bearbeiten';

  @override
  String get newRepeatingTask => 'Neue wiederkehrende Aufgabe';

  @override
  String get deleteTaskTooltip => 'Aufgabe löschen';

  @override
  String get scheduleLabel => 'Zeitplan';

  @override
  String get startAndTimeLabel => 'Start & Uhrzeit';

  @override
  String get dateRequiredForTime => 'Datum nötig';

  @override
  String get clearDateTooltip => 'Datum entfernen';

  @override
  String get pickTimeFirstReminder =>
      'Wähle zuerst eine Uhrzeit für Erinnerungen.';

  @override
  String get notificationPermissionDenied =>
      'Benachrichtigungen sind deaktiviert. Aktiviere sie in den Geräteeinstellungen.';

  @override
  String get pickDateFirstRepeat =>
      'Wähle zuerst ein Datum für die Wiederholung.';

  @override
  String get subtasksLabel => 'Unteraufgaben';

  @override
  String subtasksWithCount(int count) {
    return 'Unteraufgaben ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Unteraufgabe entfernen';

  @override
  String get addSubtaskTooltip => 'Unteraufgabe hinzufügen';

  @override
  String get moveAllOverdueMoved =>
      'Alle überfälligen Aufgaben auf heute verschoben';

  @override
  String get moveAllShort => 'Alle verschieben';

  @override
  String get noOverdueTasksSubtitle =>
      'Alle Aufgaben früherer Tage sind erledigt.';

  @override
  String get repeatingDeletePrompt => 'Was möchtest du löschen?';

  @override
  String get repeatingEditPrompt => 'Was möchtest du ändern?';

  @override
  String get repeatingDeleteSingleSub => 'Nur diesen Termin löschen';

  @override
  String get repeatingEditSingleSub => 'Nur diesen Termin ändern';

  @override
  String get repeatingDeleteFollowingSub =>
      'Diesen und alle folgenden Termine löschen';

  @override
  String get repeatingEditFollowingSub =>
      'Auf diesen und alle folgenden Termine anwenden';

  @override
  String get deviceCalendarTitle => 'Gerätekalender';

  @override
  String get selectCalendarsLabel => 'Kalender auswählen';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total aktiv';
  }

  @override
  String get showCalendarEventsTitle => 'Kalendertermine anzeigen';

  @override
  String get showCalendarEventsSubtitle =>
      'Gerätetermine erscheinen chronologisch schreibgeschützt.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Kalenderberechtigung dauerhaft verweigert';

  @override
  String get calendarPermRequiredTitle =>
      'Kalender-Leseberechtigung erforderlich';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Aktiviere den Kalenderzugriff in den Geräteeinstellungen und tippe auf Erneut prüfen.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask benötigt nur Lesezugriff, um deine Termine in der Timeline anzuzeigen.';

  @override
  String get openSettingsButton => 'Einstellungen öffnen';

  @override
  String get checkAgainButton => 'Erneut prüfen';

  @override
  String get noCalendarsFound => 'Keine Kalender auf diesem Gerät gefunden.';

  @override
  String get eventDetailTitle => 'Termindetails';

  @override
  String get eventNotesLabel => 'Notizen';

  @override
  String get calendarEventReadOnlyBanner =>
      'Termin aus dem Gerätekalender (schreibgeschützt).';

  @override
  String get markUncompletedSemantics => 'Als offen markieren';

  @override
  String get markCompletedSemantics => 'Als erledigt markieren';

  @override
  String get deleteNoteTooltip => 'Notiz löschen';

  @override
  String repeatMonthlyDay(int day) {
    return 'Jeden Monat · Tag $day';
  }

  @override
  String get last30DaysSubtitle => 'Letzte 30 Tage';

  @override
  String get allTimeSubtitle => 'Gesamt';

  @override
  String get taskCancelled => 'Aufgabe als abgebrochen markiert';

  @override
  String get taskRestored => 'Aufgabe wieder aktiviert';

  @override
  String get cancelledStatusLabel => 'Abgebrochen';

  @override
  String get restoreTaskLabel => 'Aktivieren';

  @override
  String get markCancelledSemantics => 'Als abgebrochen markieren';

  @override
  String get calendarPermFallbackHint =>
      'Falls kein Dialog erscheint, öffne die App-Einstellungen, um den Kalenderzugriff manuell zu erlauben.';

  @override
  String get calendarBadgeLabel => 'Kalender';

  @override
  String get calendarSourceLabel => 'Kalender';

  @override
  String get calendarLocationLabel => 'Ort';

  @override
  String get calendarReadOnlyInfo =>
      'Aus dem Gerätekalender synchronisiert. Dieser Eintrag ist schreibgeschützt und kann in Zettask nicht bearbeitet werden.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Cloud-Sync, Gerätekalender, App-Sperre und OLED-Themes in einem Paket.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Aktiv — $plan';
  }

  @override
  String get proActiveBannerSubtitle =>
      'Danke für deine Unterstützung von Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'AMOLED-Theme, eigene Akzentfarben, Widget-Stile & mehr';

  @override
  String get proBenefitCloudSync => 'Cloud-Synchronisierung & mehrere Geräte';

  @override
  String get proBenefitCalendar => 'Kalenderintegration & Feiertage';

  @override
  String get proBenefitAppLock =>
      'Biometrische App-Sperre & Privatsphäre im App-Umschalter';

  @override
  String get proBenefitProjectsCsv => 'Unbegrenzte Projekte & CSV-Export';

  @override
  String get proBenefitCustomization =>
      'AMOLED Reinschwarz, eigene Akzente & Widget-Stile';

  @override
  String get proPlanMonthlyTitle => 'Monatlich';

  @override
  String get proPlanMonthlyPrice => '1,99 € / Monat';

  @override
  String get proPlanYearlyTitle => 'Jährlich';

  @override
  String get proPlanYearlyPrice => '12,99 € / Jahr';

  @override
  String get proPlanYearlyBadge => 'Bester Preis';

  @override
  String get proPlanYearlySavings => '~43 % sparen';

  @override
  String get proPlanLifetimeTitle => 'Lebenslang';

  @override
  String get proPlanLifetimePrice => '29,99 €';

  @override
  String get proPlanLifetimeBadge => 'Einmalig';

  @override
  String get proContinueButton => 'Weiter';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro aktiv';

  @override
  String get proRestorePurchasesButton => 'Käufe wiederherstellen';

  @override
  String get proLegalFootnote =>
      'Abos verlängern sich automatisch, sofern sie nicht gekündigt werden. Jederzeit über Google Play kündbar.';

  @override
  String get proStoreUnavailableMessage =>
      'Google Play Billing ist auf diesem Gerät noch nicht verfügbar. Bitte später erneut versuchen.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro ist jetzt aktiv.';

  @override
  String get proRestoreSuccessMessage =>
      'Dein Zettask Pro-Kauf wurde wiederhergestellt.';

  @override
  String get proRestoreEmptyMessage =>
      'Für dieses Konto wurde kein aktiver Zettask Pro-Kauf gefunden.';

  @override
  String get proPurchaseFailedMessage =>
      'Kauf konnte gerade nicht abgeschlossen werden. Bitte erneut versuchen.';

  @override
  String get debugProSimulationLabel => 'Entwicklermodus: Pro-Simulation';

  @override
  String get amoledPureBlackTitle => 'AMOLED Reinschwarz';

  @override
  String get amoledPureBlackSubtitle =>
      'Reiner #000000-Hintergrund für OLED-Displays';

  @override
  String get customAccentSection => 'Eigene Akzentfarbe';

  @override
  String get accentMonochrome => 'Monochrom';

  @override
  String get accentSage => 'Salbei';

  @override
  String get accentIndigo => 'Indigo';

  @override
  String get accentTerracotta => 'Terrakotta';

  @override
  String get accentAmber => 'Bernstein';

  @override
  String get widgetStyleSection => 'Startbildschirm-Widget-Stil';

  @override
  String get widgetStyleStandard => 'Standard';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Transparent';

  @override
  String get proContextUnlimitedProjects =>
      'Der kostenlose Tarif umfasst bis zu 3 Projekte. Mit Zettask Pro erstellst du unbegrenzt viele Projekte.';

  @override
  String get proContextCalendarSync =>
      'Gerätekalender-Sync und Feiertage sind in Zettask Pro enthalten.';

  @override
  String get proContextAppLock =>
      'Biometrische App-Sperre und Privatsphäre im App-Umschalter sind in Zettask Pro enthalten.';

  @override
  String get proContextCsvExport =>
      'Der CSV-Export von Aufgaben und Notizen ist in Zettask Pro enthalten.';

  @override
  String get proContextCloudSync =>
      'Cloud-Synchronisierung zwischen Geräten ist in Zettask Pro enthalten.';

  @override
  String get proContextCustomThemes =>
      'AMOLED Reinschwarz und eigene Akzentfarben sind in Zettask Pro enthalten.';

  @override
  String get proContextWidgetStyles =>
      'AMOLED- und transparente Widget-Stile sind in Zettask Pro enthalten.';

  @override
  String get cloudSyncPausedShort =>
      'Cloud-Sync pausiert · Lokale Daten sicher';

  @override
  String get cloudSyncPausedTitle => 'Cloud-Sync pausiert';

  @override
  String get cloudSyncPausedBody =>
      'Dein Zettask Pro-Abo ist inaktiv. Lokale Aufgaben und Notizen bleiben sicher auf diesem Gerät.';

  @override
  String get resumeSyncWithProButton => 'Sync mit Pro fortsetzen';

  @override
  String get onboardingSkip => 'Überspringen';

  @override
  String get onboardingNext => 'Weiter';

  @override
  String get onboardingGetStarted => 'Jetzt starten';

  @override
  String get onboardingSlide1Title => 'Aufgaben ohne Ablenkung';

  @override
  String get onboardingSlide1Body =>
      'Erfasse tägliche Aufgaben in Sekunden, teile sie in Checklisten auf und hake sie mit einem Tippen ab.';

  @override
  String get onboardingSlide2Title => 'Klare Timeline & Projekte';

  @override
  String get onboardingSlide2Body =>
      'Sieh deinen Tag chronologisch, ordne Aufgaben in Projekte und bleibe mit lokalen Erinnerungen pünktlich.';

  @override
  String get onboardingSlide3Title => 'Schnell, offline und privat';

  @override
  String get onboardingSlide3Body =>
      'Alle Daten bleiben zuerst lokal auf deinem Gerät. Kein Konto nötig und sofort ohne Internet bereit.';

  @override
  String get appGuideTitle => 'App-Einführung';

  @override
  String get appGuideSubtitle => 'Kurze Zettask-Einführung erneut ansehen';

  @override
  String get dynamicColorTitle => 'Material You (Hintergrundfarbe)';

  @override
  String get dynamicColorSubtitle =>
      'Akzentfarben an dein Geräte-Hintergrundbild anpassen (Android 12+)';
}

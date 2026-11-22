// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Timeline';

  @override
  String get navBoard => 'Bacheca';

  @override
  String get navUnplanned => 'Senza data';

  @override
  String get navMore => 'Altro';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get close => 'Chiudi';

  @override
  String get delete => 'Elimina';

  @override
  String get edit => 'Modifica';

  @override
  String get undo => 'Annulla';

  @override
  String get back => 'Indietro';

  @override
  String get retry => 'Riprova';

  @override
  String get clear => 'Cancella';

  @override
  String get all => 'Tutti';

  @override
  String get or => 'oppure';

  @override
  String get continueAction => 'Continua';

  @override
  String get understand => 'Ho capito';

  @override
  String get useAction => 'Usa';

  @override
  String get today => 'Oggi';

  @override
  String get tomorrow => 'Domani';

  @override
  String get yesterday => 'Ieri';

  @override
  String get toDo => 'Da fare';

  @override
  String get overdue => 'Scadute';

  @override
  String get unplanned => 'Senza data';

  @override
  String get allDay => 'Tutto il giorno';

  @override
  String get scheduled => 'Programmate';

  @override
  String get addTaskToday => 'Aggiungi attività per oggi';

  @override
  String get addTask => 'Aggiungi attività';

  @override
  String get noTasksForDate => 'Nessuna attività per questa data.';

  @override
  String get savedToUnplanned => 'Salvata in Senza data';

  @override
  String get savedToUnplannedNoDate => 'Salvata in Senza data (senza data)';

  @override
  String scheduledForDate(String date) {
    return 'Programmata per il $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Attività programmata per il $date';
  }

  @override
  String get taskDeleted => 'Attività eliminata';

  @override
  String get searchTasksTooltip => 'Cerca attività';

  @override
  String get timelineOptionsTooltip => 'Opzioni Timeline';

  @override
  String get addTaskTooltip => 'Aggiungi attività';

  @override
  String get completedLabel => 'Completata';

  @override
  String get uncompleteLabel => 'Segna attiva';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total sotto-attività';
  }

  @override
  String get repeatingTaskLabel => 'Attività ricorrente';

  @override
  String get quickAddHint => 'Aggiungi una nuova attività...';

  @override
  String get expandTooltip => 'Espandi';

  @override
  String get saveTaskTooltip => 'Salva attività';

  @override
  String get newTask => 'Nuova attività';

  @override
  String get editTask => 'Modifica attività';

  @override
  String get taskTitleLabel => 'Titolo attività';

  @override
  String get taskTitleHint => 'Es. Rivedere note dello sprint';

  @override
  String get taskTitleRequired => 'Il titolo è obbligatorio';

  @override
  String get descriptionLabel => 'Descrizione';

  @override
  String get descriptionHint => 'Aggiungi note o dettagli...';

  @override
  String get pickDate => 'Scegli data';

  @override
  String get pickOnCalendar => 'Scegli dal calendario...';

  @override
  String get noDateUnplanned => 'Senza data (Non pianificata)';

  @override
  String get noDate => 'Senza data';

  @override
  String get taskTime => 'Orario attività';

  @override
  String get changeTime => 'Cambia ora';

  @override
  String get clearTimeAllDay => 'Rimuovi ora (Tutto il giorno)';

  @override
  String get timeLabel => 'Ora';

  @override
  String get reminderLabel => 'Promemoria';

  @override
  String get noReminder => 'Nessun promemoria';

  @override
  String get atTime => 'All\'orario';

  @override
  String get minutesBefore10 => '10 min prima';

  @override
  String get minutesBefore30 => '30 min prima';

  @override
  String get hourBefore1 => '1 ora prima';

  @override
  String get reminderShort10m => '10 m';

  @override
  String get reminderShort30m => '30 m';

  @override
  String get reminderShort1h => '1 h';

  @override
  String get projectLabel => 'Progetto';

  @override
  String get noProject => 'Nessun progetto';

  @override
  String get tagLabel => 'Tag';

  @override
  String get noTag => 'Nessun tag';

  @override
  String get priorityLabel => 'Priorità';

  @override
  String get priorityLow => 'Bassa';

  @override
  String get priorityMedium => 'Media';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get saveTask => 'Salva attività';

  @override
  String get saveChanges => 'Salva modifiche';

  @override
  String get checklistLabel => 'Checklist';

  @override
  String get addChecklistHint => 'Aggiungi elemento...';

  @override
  String get repeatLabel => 'Ripetizione';

  @override
  String get noRepeat => 'Nessuna ripetizione';

  @override
  String get repeatDaily => 'Ogni giorno';

  @override
  String get repeatWeekly => 'Ogni settimana';

  @override
  String get repeatMonthly => 'Ogni mese';

  @override
  String get colorLabel => 'Colore';

  @override
  String get timelineOptionsTitle => 'Opzioni Timeline';

  @override
  String get viewModeLabel => 'Modalità vista';

  @override
  String get modeTimeline => 'Modalità Timeline';

  @override
  String get modeDaily => 'Modalità Giornaliera';

  @override
  String get firstDayOfWeek => 'Inizio settimana';

  @override
  String get monday => 'Lunedì';

  @override
  String get sunday => 'Domenica';

  @override
  String get firstDayMondayOrder => 'Lun · Mar · Mer · Gio · Ven · Sab · Dom';

  @override
  String get firstDaySundayOrder => 'Dom · Lun · Mar · Mer · Gio · Ven · Sab';

  @override
  String get showCompletedTasks => 'Mostra attività completate';

  @override
  String get showCompletedTasksSubtitle =>
      'Nascondi le attività spuntate per restare concentrato.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Mostra o nascondi le attività completate.';

  @override
  String get overdueTasksTitle => 'Attività scadute';

  @override
  String get noOverdueTasks => 'Nessuna attività scaduta';

  @override
  String get moveToToday => 'Sposta a Oggi';

  @override
  String get moveAllToToday => 'Sposta tutte a Oggi';

  @override
  String get searchTasksHint => 'Cerca attività...';

  @override
  String get searchTasksEmpty =>
      'Scrivi per cercare attività, descrizioni o checklist.';

  @override
  String searchNoResults(String query) {
    return 'Nessuna attività trovata per \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'Evento calendario · sola lettura';

  @override
  String get prevWeekTooltip => 'Settimana precedente';

  @override
  String get nextWeekTooltip => 'Settimana successiva';

  @override
  String get boardTitle => 'Bacheca';

  @override
  String get allProjects => 'Tutti i progetti';

  @override
  String get searchProjectHint => 'Cerca progetto...';

  @override
  String get searchProjectTooltip => 'Cerca progetti';

  @override
  String get closeSearchTooltip => 'Chiudi ricerca';

  @override
  String get createProject => 'Crea progetto';

  @override
  String get editProject => 'Modifica progetto';

  @override
  String get deleteProject => 'Elimina progetto';

  @override
  String get projectOptionsTooltip => 'Opzioni progetto';

  @override
  String projectDeleted(String name) {
    return 'Progetto \"$name\" eliminato';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total completate';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total attività completate';
  }

  @override
  String get projectNotFound => 'Progetto non trovato';

  @override
  String get noProjectsYet => 'Nessun progetto';

  @override
  String projectSearchEmpty(String query) {
    return 'Nessun progetto corrisponde a \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'Tocca la cartella in basso per creare il primo progetto.';

  @override
  String get newProject => 'Nuovo progetto';

  @override
  String get projectNameLabel => 'Nome progetto';

  @override
  String get projectNameHint => 'Es. Lancio Zettask';

  @override
  String get projectNameRequired => 'Il nome del progetto è obbligatorio';

  @override
  String get projectColorLabel => 'Colore progetto';

  @override
  String get unplannedTitle => 'Senza data';

  @override
  String activeCountLabel(int count) {
    return '$count attive';
  }

  @override
  String get noUnplannedTitle => 'Nessuna attività senza data';

  @override
  String get noUnplannedSubtitle =>
      'Tocca + per annotare un\'attività senza data.';

  @override
  String get addUnplannedTooltip => 'Aggiungi attività senza data';

  @override
  String get workspaceTitle => 'Spazio di lavoro';

  @override
  String get organizeSection => 'Organizza';

  @override
  String get automationSection => 'Automazione';

  @override
  String get insightsSection => 'Statistiche e tema';

  @override
  String get settingsInfoSection => 'Impostazioni e info';

  @override
  String get tagsTitle => 'Tag';

  @override
  String get tagsSubtitleEmpty => 'Etichette colorate per attività e note';

  @override
  String tagsCountSubtitle(int count) {
    return '$count tag salvati';
  }

  @override
  String get newTag => 'Nuovo tag';

  @override
  String get editTag => 'Modifica tag';

  @override
  String get tagNameLabel => 'Nome tag';

  @override
  String get tagNameRequired => 'Il nome del tag è obbligatorio';

  @override
  String get tagDeleted => 'Tag eliminato';

  @override
  String get noTagsYet => 'Nessun tag';

  @override
  String tagTasksCount(int count) {
    return '$count attività';
  }

  @override
  String get templatesTitle => 'Modelli';

  @override
  String get templatesSubtitleEmpty =>
      'Salva strutture riutilizzabili di attività';

  @override
  String templatesCountSubtitle(int count) {
    return '$count modelli pronti';
  }

  @override
  String get newTemplate => 'Nuovo modello';

  @override
  String get editTemplate => 'Modifica modello';

  @override
  String get templateNameLabel => 'Nome modello';

  @override
  String get templateNameRequired => 'Il nome del modello è obbligatorio';

  @override
  String get templateDeleted => 'Modello eliminato';

  @override
  String get noTemplatesYet => 'Nessun modello';

  @override
  String get taskFromTemplateSaved => 'Attività salvata dal modello';

  @override
  String get notesTitle => 'Note';

  @override
  String get notesSubtitleEmpty => 'Note rapide senza data';

  @override
  String notesCountSubtitle(int count) {
    return '$count note salvate';
  }

  @override
  String get newNote => 'Nuova nota';

  @override
  String get editNote => 'Modifica nota';

  @override
  String get noteTitleLabel => 'Titolo nota';

  @override
  String get noteTitleHint => 'Es. Riepilogo riunione';

  @override
  String get noteTitleRequired => 'Il titolo è obbligatorio';

  @override
  String get noteContentLabel => 'Contenuto';

  @override
  String get noteContentHint => 'Scrivi la nota qui...';

  @override
  String get noteDeleted => 'Nota eliminata';

  @override
  String get searchNotesHint => 'Cerca note...';

  @override
  String get noteNotFound => 'Nota non trovata';

  @override
  String get noNotesYet => 'Nessuna nota';

  @override
  String noteSearchEmpty(String query) {
    return 'Nessuna nota corrisponde a \"$query\".';
  }

  @override
  String get noNotesSubtitle => 'Tocca + per scrivere una nota rapida.';

  @override
  String get saveNote => 'Salva nota';

  @override
  String get repeatingTasksTitle => 'Attività ricorrenti';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Gestisci routine giornaliere, settimanali e mensili';

  @override
  String repeatingActiveCount(int count) {
    return '$count routine attive';
  }

  @override
  String get noRepeatingTasks => 'Nessuna attività ricorrente';

  @override
  String get repeatingActionTitle => 'Questa è un\'attività ricorrente';

  @override
  String get repeatingThisOnly => 'Solo questa attività';

  @override
  String get repeatingThisAndFollowing => 'Questa e tutte le successive';

  @override
  String get last7DaysUpper => 'ULTIMI 7 GIORNI';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks attività, più $checklists voci checklist';
  }

  @override
  String get statsTitle => 'Statistiche';

  @override
  String get range7Days => '7 giorni';

  @override
  String get range30Days => '30 giorni';

  @override
  String get completedToday => 'Fatte oggi';

  @override
  String get last7DaysLabel => 'Ultimi 7 giorni';

  @override
  String get last30DaysLabel => 'Ultimi 30 giorni';

  @override
  String get allTimeLabel => 'Sempre';

  @override
  String get completionRateLabel => 'Completamento';

  @override
  String get activity7Days => 'Attività ultimi 7 giorni';

  @override
  String get activity30Days => 'Attività ultimi 30 giorni';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks attività · $checklists checklist';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Totale $days giorni: $tasks attività e $checklists voci';
  }

  @override
  String get completedByPriority => 'Completate per priorità';

  @override
  String get progressByProject => 'Progresso per progetto';

  @override
  String get breakdownByTag => 'Dettaglio per tag';

  @override
  String get habits30Days => 'Abitudini · 30 giorni';

  @override
  String get noProjectsCreated => 'Nessun progetto creato.';

  @override
  String get noTagsCreated => 'Nessun tag creato.';

  @override
  String get noActiveHabits => 'Nessuna routine attiva.';

  @override
  String completedCountLabel(int count) {
    return '$count fatte';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total fatte';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled fatte';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed completate · $percent% tasso';
  }

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeAndColorsTitle => 'Tema e colori';

  @override
  String get livePreviewSection => 'Anteprima dal vivo';

  @override
  String get appearanceModeSection => 'Aspetto';

  @override
  String get colorPaletteSection => 'Tavolozza colori';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeSystemLight => 'Sistema (Chiaro)';

  @override
  String get themeSystemDark => 'Sistema (Scuro)';

  @override
  String get presetDefault => 'Predefinito';

  @override
  String get presetDefaultDesc => 'Indaco e ardesia';

  @override
  String get presetOcean => 'Oceano';

  @override
  String get presetOceanDesc => 'Blu calmo';

  @override
  String get presetForest => 'Foresta';

  @override
  String get presetForestDesc => 'Salvia e smeraldo';

  @override
  String get presetTerracotta => 'Terracotta';

  @override
  String get presetTerracottaDesc => 'Arancione caldo';

  @override
  String get presetPlum => 'Prugna';

  @override
  String get presetPlumDesc => 'Viola tenue';

  @override
  String get presetMonochrome => 'Monocromo';

  @override
  String get presetMonochromeDesc => 'Antracite e nero';

  @override
  String get previewActiveTask => 'Rivedere design interfaccia';

  @override
  String get previewCompletedTask => 'Sincronizzare agenda settimanale';

  @override
  String get languageTitle => 'Lingua';

  @override
  String get deviceLanguageOption => 'Lingua del dispositivo (se supportata)';

  @override
  String get appLockTitle => 'Blocco app';

  @override
  String get appLockSubtitle => 'Impronta, volto o PIN del dispositivo';

  @override
  String get appLockLockedTitle => 'Zettask bloccata';

  @override
  String get appLockLockedSubtitle =>
      'Usa impronta, volto o PIN del dispositivo per continuare.';

  @override
  String get unlockButton => 'Sblocca';

  @override
  String get verifyingButton => 'Verifica...';

  @override
  String get appLockUnsupportedError =>
      'Nessuna biometria o PIN attivo su questo dispositivo.';

  @override
  String get appLockCancelledError => 'Verifica annullata o non riuscita.';

  @override
  String get appLockUnlockFailedError =>
      'Autenticazione fallita. Tocca Sblocca per riprovare.';

  @override
  String get calendarSyncTitle => 'Sincronizzazione calendario';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Attiva · $count calendari';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'Spenta · mostra eventi in sola lettura';

  @override
  String get grantCalendarPermission => 'Consenti accesso al calendario';

  @override
  String get exportCsvTitle => 'Esporta CSV';

  @override
  String get exportCsvSubtitle => 'Condividi attività o note in CSV';

  @override
  String get exportDataCsvTitle => 'Esporta dati CSV';

  @override
  String get exportTasksTitle => 'Esporta attività';

  @override
  String get exportTasksSubtitle =>
      'Tutte le attività programmate, senza data e progetti';

  @override
  String get exportNotesTitle => 'Esporta note';

  @override
  String get exportNotesSubtitle => 'Tutte le note rapide';

  @override
  String get exportBothTitle => 'Esporta entrambi';

  @override
  String get exportBothSubtitle => 'File CSV di attività e note insieme';

  @override
  String get aboutPrivacyTitle => 'Info e Privacy';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Versione $version · Locale prima e cloud opzionale';
  }

  @override
  String get aboutTitle => 'Info su Zettask';

  @override
  String versionLabel(String version) {
    return 'Versione $version';
  }

  @override
  String get privacySyncTitle => 'Privacy e sincronizzazione';

  @override
  String get privacySyncDescription =>
      'Per impostazione predefinita i dati restano sul dispositivo. La sincronizzazione Firebase è opzionale dopo l\'accesso e puoi eliminare definitivamente account e dati cloud in qualsiasi momento.';

  @override
  String get privacyPolicyLabel => 'Informativa sulla privacy';

  @override
  String get privacyLinkCopied => 'Link copiato';

  @override
  String get accountAndSyncTitle => 'Account e sincronizzazione';

  @override
  String get signInToZettask => 'Accedi all\'account Zettask';

  @override
  String get accountBannerSubtitle =>
      'Opzionale · backup e sincronizzazione cloud';

  @override
  String get authWelcomeTitle => 'Salva i tuoi progressi e attività';

  @override
  String get authWelcomeSubtitle =>
      'Esegui il backup automatico di programmi, progetti e note sul cloud. Puoi usare Zettask localmente anche senza account.';

  @override
  String get createNewAccount => 'Crea nuovo account';

  @override
  String get signIn => 'Accedi';

  @override
  String get continueWithGoogle => 'Continua con Google';

  @override
  String get authTermsNotice =>
      'Continuando accetti i Termini e la Privacy di Zettask.';

  @override
  String get signInToAccountTitle => 'Accedi a Zettask';

  @override
  String get signInToAccountSubtitle =>
      'I dati locali verranno uniti al backup cloud.';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailHint => 'nome@email.com';

  @override
  String get emailRequired => 'L\'email è obbligatoria.';

  @override
  String get emailInvalid => 'Formato email non valido.';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordHint => 'Inserisci la password';

  @override
  String get passwordNewHint => 'Almeno 6 caratteri';

  @override
  String get passwordRequired => 'La password è obbligatoria.';

  @override
  String get passwordTooShort =>
      'La password deve contenere almeno 6 caratteri.';

  @override
  String get forgotPassword => 'Dimenticata?';

  @override
  String get enterValidEmailFirst => 'Inserisci prima un\'email valida.';

  @override
  String passwordResetSent(String email) {
    return 'Link di ripristino inviato a $email.';
  }

  @override
  String get showPasswordTooltip => 'Mostra password';

  @override
  String get hidePasswordTooltip => 'Nascondi password';

  @override
  String get noAccountPrompt => 'Non hai un account?';

  @override
  String get createAccountLink => 'Crea account';

  @override
  String get createAccountTitle => 'Crea account';

  @override
  String get createAccountSubtitle =>
      'Salva tutte le attività, routine e note sul cloud.';

  @override
  String get haveAccountPrompt => 'Hai già un account?';

  @override
  String signedInVia(String provider) {
    return 'Accesso con $provider';
  }

  @override
  String get syncNowButton => 'Sincronizza ora';

  @override
  String get syncingLabel => 'Sincronizzazione...';

  @override
  String get syncDoneMessage => 'Sincronizzazione completata.';

  @override
  String get syncFailedMessage =>
      'Sincronizzazione fallita. Controlla la connessione.';

  @override
  String get syncStatusIdle => 'Non ancora sincronizzato';

  @override
  String get syncStatusSyncing => 'Sincronizzazione...';

  @override
  String get syncStatusSynced => 'Sincronizzato';

  @override
  String get syncStatusError => 'Errore di sincronizzazione';

  @override
  String lastSyncedPrefix(String time) {
    return 'Ultima: $time';
  }

  @override
  String get neverSynced => 'Mai sincronizzato';

  @override
  String get signOutButton => 'Esci';

  @override
  String get signedOutMessage =>
      'Disconnesso. I dati locali restano sul dispositivo.';

  @override
  String get deleteAccountButton => 'Elimina account';

  @override
  String get deleteAccountStep1Title => 'Eliminare l\'account?';

  @override
  String get deleteAccountStep1Body =>
      'Tutti i backup cloud e l\'account verranno eliminati definitivamente. I dati locali restano sul dispositivo.';

  @override
  String get deleteAccountStep2Title => 'Conferma eliminazione permanente';

  @override
  String get deleteAccountStep2Body =>
      'Questa azione è irreversibile. Eliminare definitivamente account e dati cloud ora?';

  @override
  String get deleteAccountConfirmButton => 'Sì, elimina definitivamente';

  @override
  String get accountDeletedMessage =>
      'Account e dati cloud eliminati definitivamente.';

  @override
  String get reloginRequiredTitle => 'Nuovo accesso richiesto';

  @override
  String get authErrUserNotFound => 'Nessun account trovato per questa email.';

  @override
  String get authErrWrongPassword => 'Password errata.';

  @override
  String get authErrInvalidCredential => 'Email o password non validi.';

  @override
  String get authErrInvalidEmail => 'Formato email non valido.';

  @override
  String get authErrEmailInUse => 'Questa email è già registrata.';

  @override
  String get authErrWeakPassword =>
      'Password troppo debole. Usa almeno 6 caratteri.';

  @override
  String get authErrNetwork => 'Errore di rete. Controlla la connessione.';

  @override
  String get authErrRequiresRecentLogin =>
      'Per sicurezza, esci e accedi di nuovo prima di eliminare l\'account.';

  @override
  String get authErrTooManyRequests => 'Troppi tentativi. Riprova tra poco.';

  @override
  String get authErrUserDisabled => 'Questo account è stato disabilitato.';

  @override
  String get authErrAccountExistsDifferent =>
      'Questa email è collegata a un altro metodo di accesso.';

  @override
  String get authErrOperationNotAllowed =>
      'Questo metodo di accesso non è abilitato.';

  @override
  String get authErrFirebaseUnavailable => 'Servizio account non disponibile.';

  @override
  String get authErrUnknown => 'Errore di autenticazione. Riprova.';

  @override
  String get widgetTitle => 'Zettask · Oggi';

  @override
  String get widgetEmptyText => 'Tutte le attività di oggi sono completate.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Attività ricorrente e successive eliminate';

  @override
  String get noProjectTasksTitle => 'Nessuna attività in questo progetto';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Tocca + per aggiungere un\'attività a $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'Aggiungi attività al progetto';

  @override
  String get noTagsSubtitle =>
      'Tocca + per creare tag colorati per attività e note.';

  @override
  String get tagOptionsTooltip => 'Opzioni tag';

  @override
  String get deleteTag => 'Elimina tag';

  @override
  String get addTagTooltip => 'Aggiungi tag';

  @override
  String get noTasksWithTag => 'Nessuna attività con questo tag.';

  @override
  String get addTaskWithTagTooltip => 'Aggiungi attività con tag';

  @override
  String get tagNameHint => 'es. Lavoro, Personale, Urgente';

  @override
  String get tagColorLabel => 'Colore tag';

  @override
  String get createTag => 'Crea tag';

  @override
  String tagDeletedNamed(String name) {
    return 'Tag \"$name\" eliminato';
  }

  @override
  String get noTemplatesSubtitle =>
      'Salva strutture di attività frequenti per ricrearle più velocemente.';

  @override
  String get templateOptionsTooltip => 'Opzioni modello';

  @override
  String get deleteTemplate => 'Elimina modello';

  @override
  String get createTemplateTooltip => 'Crea modello';

  @override
  String templateDeletedNamed(String name) {
    return 'Modello \"$name\" eliminato';
  }

  @override
  String get templateNameHint => 'es. Rilascio settimanale';

  @override
  String get defaultTaskTitleLabel => 'Titolo attività predefinito';

  @override
  String get defaultTaskTitleHint => 'es. Preparare rilascio';

  @override
  String get timeOptionalLabel => 'Ora (opzionale)';

  @override
  String get clearTimeTooltip => 'Rimuovi ora';

  @override
  String get projectOptionalLabel => 'Progetto (opzionale)';

  @override
  String get tagOptionalLabel => 'Tag (opzionale)';

  @override
  String get defaultSubtasksLabel => 'Sotto-attività predefinite';

  @override
  String get addTemplateSubtaskHint => 'Aggiungi sotto-attività...';

  @override
  String get saveTemplate => 'Salva modello';

  @override
  String subtasksTotalCount(int count) {
    return '$count sotto-attività';
  }

  @override
  String get useTemplateButton => 'Usa modello';

  @override
  String get pickTemplateTitle => 'Scegli modello';

  @override
  String get repeatingTaskDeleted => 'Attività ricorrente eliminata';

  @override
  String get noRepeatingTasksSubtitle =>
      'Tocca + per creare routine giornaliere, settimanali o mensili.';

  @override
  String get addRepeatingTaskTooltip => 'Aggiungi attività ricorrente';

  @override
  String get editRepeatingTask => 'Modifica attività ricorrente';

  @override
  String get newRepeatingTask => 'Nuova attività ricorrente';

  @override
  String get deleteTaskTooltip => 'Elimina attività';

  @override
  String get scheduleLabel => 'Pianificazione';

  @override
  String get startAndTimeLabel => 'Inizio e ora';

  @override
  String get dateRequiredForTime => 'Serve data';

  @override
  String get clearDateTooltip => 'Rimuovi data';

  @override
  String get pickTimeFirstReminder =>
      'Scegli prima un orario per attivare i promemoria.';

  @override
  String get notificationPermissionDenied =>
      'Notifiche disattivate. Attivale nelle impostazioni del dispositivo.';

  @override
  String get pickDateFirstRepeat =>
      'Scegli prima una data per impostare la ripetizione.';

  @override
  String get subtasksLabel => 'Sotto-attività';

  @override
  String subtasksWithCount(int count) {
    return 'Sotto-attività ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Rimuovi sotto-attività';

  @override
  String get addSubtaskTooltip => 'Aggiungi sotto-attività';

  @override
  String get moveAllOverdueMoved => 'Tutte le attività scadute spostate a oggi';

  @override
  String get moveAllShort => 'Sposta tutte';

  @override
  String get noOverdueTasksSubtitle =>
      'Tutte le attività dei giorni precedenti sono completate.';

  @override
  String get repeatingDeletePrompt => 'Cosa vuoi eliminare?';

  @override
  String get repeatingEditPrompt => 'Cosa vuoi modificare?';

  @override
  String get repeatingDeleteSingleSub => 'Elimina solo questa occorrenza';

  @override
  String get repeatingEditSingleSub => 'Modifica solo questa occorrenza';

  @override
  String get repeatingDeleteFollowingSub =>
      'Elimina questa e tutte le successive';

  @override
  String get repeatingEditFollowingSub =>
      'Applica a questa e tutte le successive';

  @override
  String get deviceCalendarTitle => 'Calendario dispositivo';

  @override
  String get selectCalendarsLabel => 'Seleziona calendari';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total attivi';
  }

  @override
  String get showCalendarEventsTitle => 'Mostra eventi calendario';

  @override
  String get showCalendarEventsSubtitle =>
      'Gli eventi appaiono cronologicamente in sola lettura.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Permesso calendario negato permanentemente';

  @override
  String get calendarPermRequiredTitle =>
      'Permesso lettura calendario necessario';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Attiva il permesso calendario nelle Impostazioni e tocca Controlla di nuovo.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask richiede solo l\'accesso in lettura per mostrare gli eventi nella timeline.';

  @override
  String get openSettingsButton => 'Apri impostazioni';

  @override
  String get checkAgainButton => 'Controlla di nuovo';

  @override
  String get noCalendarsFound =>
      'Nessun calendario trovato su questo dispositivo.';

  @override
  String get eventDetailTitle => 'Dettagli evento';

  @override
  String get eventNotesLabel => 'Note';

  @override
  String get calendarEventReadOnlyBanner =>
      'Evento dal calendario del dispositivo (sola lettura).';

  @override
  String get markUncompletedSemantics => 'Segna da fare';

  @override
  String get markCompletedSemantics => 'Segna completata';

  @override
  String get deleteNoteTooltip => 'Elimina nota';

  @override
  String repeatMonthlyDay(int day) {
    return 'Ogni mese · giorno $day';
  }

  @override
  String get last30DaysSubtitle => 'Ultimi 30 giorni';

  @override
  String get allTimeSubtitle => 'Sempre';

  @override
  String get taskCancelled => 'Attività segnata come annullata';

  @override
  String get taskRestored => 'Attività riattivata';

  @override
  String get cancelledStatusLabel => 'Annullata';

  @override
  String get restoreTaskLabel => 'Riattiva';

  @override
  String get markCancelledSemantics => 'Segna annullata';

  @override
  String get calendarPermFallbackHint =>
      'Se la richiesta non appare, apri le Impostazioni app per abilitare manualmente l’accesso al Calendario.';

  @override
  String get calendarBadgeLabel => 'Calendario';

  @override
  String get calendarSourceLabel => 'Calendario';

  @override
  String get calendarLocationLabel => 'Posizione';

  @override
  String get calendarReadOnlyInfo =>
      'Sincronizzato dal calendario del dispositivo. Questo elemento è di sola lettura e non può essere modificato in Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Sincronizzazione cloud, calendari, blocco app e temi OLED in un unico piano.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Attivo — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Grazie per il tuo supporto a Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'Tema AMOLED, accenti personalizzati, stili widget e altro';

  @override
  String get proBenefitCloudSync =>
      'Sincronizzazione cloud e multi-dispositivo';

  @override
  String get proBenefitCalendar => 'Integrazione calendario e festività';

  @override
  String get proBenefitAppLock => 'Blocco biometrico e privacy app recenti';

  @override
  String get proBenefitProjectsCsv => 'Progetti illimitati ed esportazione CSV';

  @override
  String get proBenefitCustomization =>
      'AMOLED nero puro, accenti personalizzati e stili widget';

  @override
  String get proPlanMonthlyTitle => 'Mensile';

  @override
  String get proPlanMonthlyPrice => '1,99 € / mese';

  @override
  String get proPlanYearlyTitle => 'Annuale';

  @override
  String get proPlanYearlyPrice => '12,99 € / anno';

  @override
  String get proPlanYearlyBadge => 'Più conveniente';

  @override
  String get proPlanYearlySavings => 'Risparmia ~43%';

  @override
  String get proPlanLifetimeTitle => 'A vita';

  @override
  String get proPlanLifetimePrice => '29,99 €';

  @override
  String get proPlanLifetimeBadge => 'Una tantum';

  @override
  String get proContinueButton => 'Continua';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro attivo';

  @override
  String get proRestorePurchasesButton => 'Ripristina acquisti';

  @override
  String get proLegalFootnote =>
      'Gli abbonamenti si rinnovano automaticamente salvo disdetta. Annulla in qualsiasi momento su Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'La fatturazione Google Play non è ancora disponibile su questo dispositivo. Riprova più tardi.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro è ora attivo.';

  @override
  String get proRestoreSuccessMessage =>
      'Il tuo acquisto Zettask Pro è stato ripristinato.';

  @override
  String get proRestoreEmptyMessage =>
      'Nessun acquisto Zettask Pro attivo trovato su questo account.';

  @override
  String get proPurchaseFailedMessage =>
      'Impossibile completare l\'acquisto ora. Riprova.';

  @override
  String get debugProSimulationLabel =>
      'Modalità sviluppatore: Simulazione Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED Nero Puro';

  @override
  String get amoledPureBlackSubtitle =>
      'Sfondo nero puro #000000 per schermi OLED';

  @override
  String get customAccentSection => 'Colore accento personalizzato';

  @override
  String get accentMonochrome => 'Monocromatico';

  @override
  String get accentSage => 'Salvia';

  @override
  String get accentIndigo => 'Indaco';

  @override
  String get accentTerracotta => 'Terracotta';

  @override
  String get accentAmber => 'Ambra';

  @override
  String get widgetStyleSection => 'Stile widget schermata Home';

  @override
  String get widgetStyleStandard => 'Standard';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Traslucido';

  @override
  String get proContextUnlimitedProjects =>
      'Il piano gratuito include fino a 3 progetti. Passa a Zettask Pro per progetti illimitati.';

  @override
  String get proContextCalendarSync =>
      'Sincronizzazione calendario e festività sono incluse in Zettask Pro.';

  @override
  String get proContextAppLock =>
      'Blocco biometrico e privacy app recenti sono inclusi in Zettask Pro.';

  @override
  String get proContextCsvExport =>
      'L\'esportazione CSV di attività e note è inclusa in Zettask Pro.';

  @override
  String get proContextCloudSync =>
      'La sincronizzazione cloud tra dispositivi è inclusa in Zettask Pro.';

  @override
  String get proContextCustomThemes =>
      'AMOLED nero puro e colori accento personalizzati sono inclusi in Zettask Pro.';

  @override
  String get proContextWidgetStyles =>
      'Gli stili widget AMOLED e traslucido sono inclusi in Zettask Pro.';

  @override
  String get cloudSyncPausedShort =>
      'Sync cloud in pausa · Dati locali al sicuro';

  @override
  String get cloudSyncPausedTitle => 'Sincronizzazione cloud in pausa';

  @override
  String get cloudSyncPausedBody =>
      'Il tuo piano Zettask Pro non è attivo. Attività e note locali restano al sicuro su questo dispositivo.';

  @override
  String get resumeSyncWithProButton => 'Riprendi sync con Pro';

  @override
  String get onboardingSkip => 'Salta';

  @override
  String get onboardingNext => 'Avanti';

  @override
  String get onboardingGetStarted => 'Inizia ora';

  @override
  String get onboardingSlide1Title => 'Annota attività senza distrazioni';

  @override
  String get onboardingSlide1Body =>
      'Aggiungi attività in pochi secondi, dividile in checklist e completale con un tocco.';

  @override
  String get onboardingSlide2Title => 'Timeline e progetti in ordine';

  @override
  String get onboardingSlide2Body =>
      'Guarda la giornata in ordine cronologico, organizza i progetti e rispetta gli orari con i promemoria locali.';

  @override
  String get onboardingSlide3Title => 'Veloce, offline e privato';

  @override
  String get onboardingSlide3Body =>
      'Tutti i dati restano prima sul tuo dispositivo. Nessun account richiesto e pronto anche senza internet.';

  @override
  String get appGuideTitle => 'Guida all\'app';

  @override
  String get appGuideSubtitle => 'Rivedi la breve guida di Zettask';

  @override
  String get dynamicColorTitle => 'Material You (Colore sfondo)';

  @override
  String get dynamicColorSubtitle =>
      'Adatta i colori di accento allo sfondo del dispositivo (Android 12+)';
}

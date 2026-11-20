// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Zettask';

  @override
  String get navTimeline => 'Chronologie';

  @override
  String get navBoard => 'Tableau';

  @override
  String get navUnplanned => 'Non planifié';

  @override
  String get navMore => 'Plus';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get close => 'Fermer';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get undo => 'Annuler';

  @override
  String get back => 'Retour';

  @override
  String get retry => 'Réessayer';

  @override
  String get clear => 'Effacer';

  @override
  String get all => 'Tout';

  @override
  String get or => 'ou';

  @override
  String get continueAction => 'Continuer';

  @override
  String get understand => 'Compris';

  @override
  String get useAction => 'Utiliser';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get tomorrow => 'Demain';

  @override
  String get yesterday => 'Hier';

  @override
  String get toDo => 'À faire';

  @override
  String get overdue => 'En retard';

  @override
  String get unplanned => 'Non planifié';

  @override
  String get allDay => 'Toute la journée';

  @override
  String get scheduled => 'Planifié';

  @override
  String get addTaskToday => 'Ajouter une tâche pour aujourd\'hui';

  @override
  String get addTask => 'Ajouter une tâche';

  @override
  String get noTasksForDate => 'Aucune tâche pour cette date.';

  @override
  String get savedToUnplanned => 'Enregistré dans Non planifié';

  @override
  String get savedToUnplannedNoDate =>
      'Enregistré dans Non planifié (sans date)';

  @override
  String scheduledForDate(String date) {
    return 'Planifiée pour le $date';
  }

  @override
  String taskScheduledForDate(String date) {
    return 'Tâche planifiée pour le $date';
  }

  @override
  String get taskDeleted => 'Tâche supprimée';

  @override
  String get searchTasksTooltip => 'Rechercher des tâches';

  @override
  String get timelineOptionsTooltip => 'Options de chronologie';

  @override
  String get addTaskTooltip => 'Ajouter une tâche';

  @override
  String get completedLabel => 'Terminée';

  @override
  String get uncompleteLabel => 'Marquer active';

  @override
  String subtasksCount(int done, int total) {
    return '$done/$total sous-tâches';
  }

  @override
  String get repeatingTaskLabel => 'Tâche récurrente';

  @override
  String get quickAddHint => 'Ajouter une nouvelle tâche...';

  @override
  String get expandTooltip => 'Agrandir';

  @override
  String get saveTaskTooltip => 'Enregistrer la tâche';

  @override
  String get newTask => 'Nouvelle tâche';

  @override
  String get editTask => 'Modifier la tâche';

  @override
  String get taskTitleLabel => 'Titre de la tâche';

  @override
  String get taskTitleHint => 'Ex. : Relire les notes du sprint';

  @override
  String get taskTitleRequired => 'Le titre est obligatoire';

  @override
  String get descriptionLabel => 'Description';

  @override
  String get descriptionHint => 'Ajouter des notes ou du contexte...';

  @override
  String get pickDate => 'Choisir une date';

  @override
  String get pickOnCalendar => 'Choisir sur le calendrier...';

  @override
  String get noDateUnplanned => 'Sans date (Non planifié)';

  @override
  String get noDate => 'Sans date';

  @override
  String get taskTime => 'Heure de la tâche';

  @override
  String get changeTime => 'Changer l\'heure';

  @override
  String get clearTimeAllDay => 'Effacer l\'heure (Toute la journée)';

  @override
  String get timeLabel => 'Heure';

  @override
  String get reminderLabel => 'Rappel';

  @override
  String get noReminder => 'Aucun rappel';

  @override
  String get atTime => 'À l\'heure';

  @override
  String get minutesBefore10 => '10 min avant';

  @override
  String get minutesBefore30 => '30 min avant';

  @override
  String get hourBefore1 => '1 heure avant';

  @override
  String get reminderShort10m => '10 min';

  @override
  String get reminderShort30m => '30 min';

  @override
  String get reminderShort1h => '1 h';

  @override
  String get projectLabel => 'Projet';

  @override
  String get noProject => 'Aucun projet';

  @override
  String get tagLabel => 'Étiquette';

  @override
  String get noTag => 'Aucune étiquette';

  @override
  String get priorityLabel => 'Priorité';

  @override
  String get priorityLow => 'Basse';

  @override
  String get priorityMedium => 'Moyenne';

  @override
  String get priorityHigh => 'Haute';

  @override
  String get saveTask => 'Enregistrer la tâche';

  @override
  String get saveChanges => 'Enregistrer les modifications';

  @override
  String get checklistLabel => 'Liste de contrôle';

  @override
  String get addChecklistHint => 'Ajouter un élément...';

  @override
  String get repeatLabel => 'Répétition';

  @override
  String get noRepeat => 'Ne se répète pas';

  @override
  String get repeatDaily => 'Tous les jours';

  @override
  String get repeatWeekly => 'Toutes les semaines';

  @override
  String get repeatMonthly => 'Tous les mois';

  @override
  String get colorLabel => 'Couleur';

  @override
  String get timelineOptionsTitle => 'Options de chronologie';

  @override
  String get viewModeLabel => 'Mode d\'affichage';

  @override
  String get modeTimeline => 'Mode Chronologie';

  @override
  String get modeDaily => 'Mode Quotidien';

  @override
  String get firstDayOfWeek => 'Début de semaine';

  @override
  String get monday => 'Lundi';

  @override
  String get sunday => 'Dimanche';

  @override
  String get firstDayMondayOrder => 'Lun · Mar · Mer · Jeu · Ven · Sam · Dim';

  @override
  String get firstDaySundayOrder => 'Dim · Lun · Mar · Mer · Jeu · Ven · Sam';

  @override
  String get showCompletedTasks => 'Afficher les tâches terminées';

  @override
  String get showCompletedTasksSubtitle =>
      'Masquez les tâches cochées pour rester concentré.';

  @override
  String get showCompletedWorkspaceSubtitle =>
      'Afficher ou masquer les tâches terminées.';

  @override
  String get overdueTasksTitle => 'Tâches en retard';

  @override
  String get noOverdueTasks => 'Aucune tâche en retard';

  @override
  String get moveToToday => 'Déplacer à Aujourd\'hui';

  @override
  String get moveAllToToday => 'Tout déplacer à Aujourd\'hui';

  @override
  String get searchTasksHint => 'Rechercher des tâches...';

  @override
  String get searchTasksEmpty =>
      'Tapez pour rechercher des tâches, descriptions ou listes.';

  @override
  String searchNoResults(String query) {
    return 'Aucune tâche ne correspond à \"$query\".';
  }

  @override
  String get calendarEventReadOnly => 'Événement calendrier · lecture seule';

  @override
  String get prevWeekTooltip => 'Semaine précédente';

  @override
  String get nextWeekTooltip => 'Semaine suivante';

  @override
  String get boardTitle => 'Tableau';

  @override
  String get allProjects => 'Tous les projets';

  @override
  String get searchProjectHint => 'Rechercher un projet...';

  @override
  String get searchProjectTooltip => 'Rechercher des projets';

  @override
  String get closeSearchTooltip => 'Fermer la recherche';

  @override
  String get createProject => 'Créer un projet';

  @override
  String get editProject => 'Modifier le projet';

  @override
  String get deleteProject => 'Supprimer le projet';

  @override
  String get projectOptionsTooltip => 'Options du projet';

  @override
  String projectDeleted(String name) {
    return 'Projet \"$name\" supprimé';
  }

  @override
  String projectsCompletedRatio(int done, int total) {
    return '$done/$total terminées';
  }

  @override
  String projectTasksCompletedRatio(int done, int total) {
    return '$done/$total tâches terminées';
  }

  @override
  String get projectNotFound => 'Projet introuvable';

  @override
  String get noProjectsYet => 'Aucun projet';

  @override
  String projectSearchEmpty(String query) {
    return 'Aucun projet ne correspond à \"$query\".';
  }

  @override
  String get noProjectsSubtitle =>
      'Touchez le dossier en bas pour créer votre premier projet.';

  @override
  String get newProject => 'Nouveau projet';

  @override
  String get projectNameLabel => 'Nom du projet';

  @override
  String get projectNameHint => 'Ex. : Lancement Zettask';

  @override
  String get projectNameRequired => 'Le nom du projet est requis';

  @override
  String get projectColorLabel => 'Couleur du projet';

  @override
  String get unplannedTitle => 'Non planifié';

  @override
  String activeCountLabel(int count) {
    return '$count actives';
  }

  @override
  String get noUnplannedTitle => 'Aucune tâche non planifiée';

  @override
  String get noUnplannedSubtitle => 'Touchez + pour noter une tâche sans date.';

  @override
  String get addUnplannedTooltip => 'Ajouter une tâche non planifiée';

  @override
  String get workspaceTitle => 'Espace de travail';

  @override
  String get organizeSection => 'Organiser';

  @override
  String get automationSection => 'Automatisation';

  @override
  String get insightsSection => 'Statistiques et thème';

  @override
  String get settingsInfoSection => 'Paramètres et infos';

  @override
  String get tagsTitle => 'Étiquettes';

  @override
  String get tagsSubtitleEmpty => 'Étiquettes couleur pour tâches et notes';

  @override
  String tagsCountSubtitle(int count) {
    return '$count étiquettes enregistrées';
  }

  @override
  String get newTag => 'Nouvelle étiquette';

  @override
  String get editTag => 'Modifier l\'étiquette';

  @override
  String get tagNameLabel => 'Nom de l\'étiquette';

  @override
  String get tagNameRequired => 'Le nom de l\'étiquette est requis';

  @override
  String get tagDeleted => 'Étiquette supprimée';

  @override
  String get noTagsYet => 'Aucune étiquette';

  @override
  String tagTasksCount(int count) {
    return '$count tâches';
  }

  @override
  String get templatesTitle => 'Modèles';

  @override
  String get templatesSubtitleEmpty =>
      'Enregistrez des structures de tâches réutilisables';

  @override
  String templatesCountSubtitle(int count) {
    return '$count modèles prêts';
  }

  @override
  String get newTemplate => 'Nouveau modèle';

  @override
  String get editTemplate => 'Modifier le modèle';

  @override
  String get templateNameLabel => 'Nom du modèle';

  @override
  String get templateNameRequired => 'Le nom du modèle est requis';

  @override
  String get templateDeleted => 'Modèle supprimé';

  @override
  String get noTemplatesYet => 'Aucun modèle';

  @override
  String get taskFromTemplateSaved => 'Tâche créée depuis le modèle';

  @override
  String get notesTitle => 'Notes';

  @override
  String get notesSubtitleEmpty => 'Notes rapides sans date';

  @override
  String notesCountSubtitle(int count) {
    return '$count notes enregistrées';
  }

  @override
  String get newNote => 'Nouvelle note';

  @override
  String get editNote => 'Modifier la note';

  @override
  String get noteTitleLabel => 'Titre de la note';

  @override
  String get noteTitleHint => 'Ex. : Compte rendu de réunion';

  @override
  String get noteTitleRequired => 'Le titre est requis';

  @override
  String get noteContentLabel => 'Contenu';

  @override
  String get noteContentHint => 'Écrivez votre note ici...';

  @override
  String get noteDeleted => 'Note supprimée';

  @override
  String get searchNotesHint => 'Rechercher des notes...';

  @override
  String get noteNotFound => 'Note introuvable';

  @override
  String get noNotesYet => 'Aucune note';

  @override
  String noteSearchEmpty(String query) {
    return 'Aucune note ne correspond à \"$query\".';
  }

  @override
  String get noNotesSubtitle => 'Touchez + pour rédiger une note rapide.';

  @override
  String get saveNote => 'Enregistrer la note';

  @override
  String get repeatingTasksTitle => 'Tâches récurrentes';

  @override
  String get repeatingTasksSubtitleEmpty =>
      'Gérez vos routines quotidiennes, hebdomadaires et mensuelles';

  @override
  String repeatingActiveCount(int count) {
    return '$count routines actives';
  }

  @override
  String get noRepeatingTasks => 'Aucune tâche récurrente';

  @override
  String get repeatingActionTitle => 'Ceci est une tâche récurrente';

  @override
  String get repeatingThisOnly => 'Uniquement cette tâche';

  @override
  String get repeatingThisAndFollowing => 'Cette tâche et toutes les suivantes';

  @override
  String get last7DaysUpper => '7 DERNIERS JOURS';

  @override
  String weeklySummary(int tasks, int checklists) {
    return '$tasks tâches, plus $checklists éléments de liste';
  }

  @override
  String get statsTitle => 'Statistiques';

  @override
  String get range7Days => '7 jours';

  @override
  String get range30Days => '30 jours';

  @override
  String get completedToday => 'Fait aujourd\'hui';

  @override
  String get last7DaysLabel => '7 derniers jours';

  @override
  String get last30DaysLabel => '30 derniers jours';

  @override
  String get allTimeLabel => 'Depuis le début';

  @override
  String get completionRateLabel => 'Taux d\'achèvement';

  @override
  String get activity7Days => 'Activité des 7 derniers jours';

  @override
  String get activity30Days => 'Activité des 30 derniers jours';

  @override
  String dayDetailSummary(int tasks, int checklists) {
    return '$tasks tâches · $checklists éléments';
  }

  @override
  String totalRangeSummary(int days, int tasks, int checklists) {
    return 'Total $days jours : $tasks tâches, plus $checklists éléments';
  }

  @override
  String get completedByPriority => 'Terminées par priorité';

  @override
  String get progressByProject => 'Progression par projet';

  @override
  String get breakdownByTag => 'Répartition par étiquette';

  @override
  String get habits30Days => 'Habitudes · 30 jours';

  @override
  String get noProjectsCreated => 'Aucun projet créé.';

  @override
  String get noTagsCreated => 'Aucune étiquette créée.';

  @override
  String get noActiveHabits => 'Aucune routine active.';

  @override
  String completedCountLabel(int count) {
    return '$count terminées';
  }

  @override
  String tagBreakdownTrailing(int done, int total) {
    return '$done/$total terminées';
  }

  @override
  String habitCompletedRatio(String summary, int done, int scheduled) {
    return '$summary · $done/$scheduled terminées';
  }

  @override
  String statsSubtitle(int completed, int percent) {
    return '$completed terminées · $percent% taux';
  }

  @override
  String get themeTitle => 'Thème';

  @override
  String get themeAndColorsTitle => 'Thème et couleurs';

  @override
  String get livePreviewSection => 'Aperçu en direct';

  @override
  String get appearanceModeSection => 'Apparence';

  @override
  String get colorPaletteSection => 'Palette de couleurs';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeSystemLight => 'Système (Clair)';

  @override
  String get themeSystemDark => 'Système (Sombre)';

  @override
  String get presetDefault => 'Par défaut';

  @override
  String get presetDefaultDesc => 'Indigo et ardoise';

  @override
  String get presetOcean => 'Océan';

  @override
  String get presetOceanDesc => 'Bleu apaisant';

  @override
  String get presetForest => 'Forêt';

  @override
  String get presetForestDesc => 'Sauge et émeraude';

  @override
  String get presetTerracotta => 'Terre cuite';

  @override
  String get presetTerracottaDesc => 'Orange chaleureux';

  @override
  String get presetPlum => 'Prune';

  @override
  String get presetPlumDesc => 'Violet doux';

  @override
  String get presetMonochrome => 'Monochrome';

  @override
  String get presetMonochromeDesc => 'Charbon et noir';

  @override
  String get previewActiveTask => 'Revoir le design d\'interface';

  @override
  String get previewCompletedTask => 'Synchroniser l\'agenda hebdomadaire';

  @override
  String get languageTitle => 'Langue';

  @override
  String get deviceLanguageOption =>
      'Langue de l\'appareil (si prise en charge)';

  @override
  String get appLockTitle => 'Verrouillage de l\'app';

  @override
  String get appLockSubtitle => 'Empreinte, visage ou code PIN';

  @override
  String get appLockLockedTitle => 'Zettask verrouillée';

  @override
  String get appLockLockedSubtitle =>
      'Utilisez votre empreinte, visage ou code PIN pour accéder à vos tâches.';

  @override
  String get unlockButton => 'Déverrouiller';

  @override
  String get verifyingButton => 'Vérification...';

  @override
  String get appLockUnsupportedError =>
      'Aucune biométrie ni code PIN actif sur cet appareil.';

  @override
  String get appLockCancelledError => 'Vérification annulée ou échouée.';

  @override
  String get appLockUnlockFailedError =>
      'Authentification échouée. Touchez Déverrouiller.';

  @override
  String get calendarSyncTitle => 'Synchronisation calendrier';

  @override
  String calendarSyncActiveSubtitle(int count) {
    return 'Active · $count calendriers';
  }

  @override
  String get calendarSyncInactiveSubtitle =>
      'Désactivée · événements en lecture seule';

  @override
  String get grantCalendarPermission => 'Autoriser l\'accès au calendrier';

  @override
  String get exportCsvTitle => 'Exporter en CSV';

  @override
  String get exportCsvSubtitle => 'Partager vos tâches ou notes en CSV';

  @override
  String get exportDataCsvTitle => 'Exporter les données CSV';

  @override
  String get exportTasksTitle => 'Exporter les tâches';

  @override
  String get exportTasksSubtitle =>
      'Toutes les tâches planifiées, non planifiées et projets';

  @override
  String get exportNotesTitle => 'Exporter les notes';

  @override
  String get exportNotesSubtitle => 'Toutes les notes rapides';

  @override
  String get exportBothTitle => 'Exporter les deux';

  @override
  String get exportBothSubtitle => 'Fichiers CSV tâches et notes ensemble';

  @override
  String get aboutPrivacyTitle => 'À propos et confidentialité';

  @override
  String aboutPrivacySubtitle(String version) {
    return 'Version $version · Hors-ligne d\'abord et cloud optionnel';
  }

  @override
  String get aboutTitle => 'À propos de Zettask';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get privacySyncTitle => 'Confidentialité et synchronisation';

  @override
  String get privacySyncDescription =>
      'Par défaut vos données restent sur l\'appareil. La synchronisation cloud Firebase est facultative et vous pouvez supprimer définitivement votre compte et vos données cloud à tout moment.';

  @override
  String get privacyPolicyLabel => 'Politique de confidentialité';

  @override
  String get privacyLinkCopied => 'Lien copié';

  @override
  String get accountAndSyncTitle => 'Compte et synchronisation';

  @override
  String get signInToZettask => 'Se connecter à Zettask';

  @override
  String get accountBannerSubtitle => 'Optionnel · sauvegarder et synchroniser';

  @override
  String get authWelcomeTitle => 'Sauvegardez vos progrès et tâches';

  @override
  String get authWelcomeSubtitle =>
      'Sauvegardez agendas, projets et notes automatiquement dans le cloud. Vous pouvez toujours utiliser Zettask localement sans compte.';

  @override
  String get createNewAccount => 'Créer un compte';

  @override
  String get signIn => 'Se connecter';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get authTermsNotice =>
      'En continuant, vous acceptez les Conditions et la Politique de confidentialité de Zettask.';

  @override
  String get signInToAccountTitle => 'Connexion à Zettask';

  @override
  String get signInToAccountSubtitle =>
      'Les données locales seront fusionnées avec votre sauvegarde cloud.';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailHint => 'nom@email.com';

  @override
  String get emailRequired => 'L\'e-mail est requis.';

  @override
  String get emailInvalid => 'Format d\'e-mail invalide.';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordHint => 'Saisissez votre mot de passe';

  @override
  String get passwordNewHint => '6 caractères minimum';

  @override
  String get passwordRequired => 'Le mot de passe est requis.';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères.';

  @override
  String get forgotPassword => 'Oublié ?';

  @override
  String get enterValidEmailFirst => 'Saisissez d\'abord un e-mail valide.';

  @override
  String passwordResetSent(String email) {
    return 'Lien de réinitialisation envoyé à $email.';
  }

  @override
  String get showPasswordTooltip => 'Afficher le mot de passe';

  @override
  String get hidePasswordTooltip => 'Masquer le mot de passe';

  @override
  String get noAccountPrompt => 'Pas encore de compte ?';

  @override
  String get createAccountLink => 'Créer un compte';

  @override
  String get createAccountTitle => 'Créer un compte';

  @override
  String get createAccountSubtitle =>
      'Sauvegardez toutes vos tâches, routines et notes dans le cloud.';

  @override
  String get haveAccountPrompt => 'Déjà un compte ?';

  @override
  String signedInVia(String provider) {
    return 'Connecté via $provider';
  }

  @override
  String get syncNowButton => 'Synchroniser maintenant';

  @override
  String get syncingLabel => 'Synchronisation...';

  @override
  String get syncDoneMessage => 'Synchronisation terminée.';

  @override
  String get syncFailedMessage =>
      'Échec de la synchronisation. Vérifiez votre connexion.';

  @override
  String get syncStatusIdle => 'Pas encore synchronisé';

  @override
  String get syncStatusSyncing => 'Synchronisation...';

  @override
  String get syncStatusSynced => 'Synchronisé';

  @override
  String get syncStatusError => 'Échec de synchronisation';

  @override
  String lastSyncedPrefix(String time) {
    return 'Dernière : $time';
  }

  @override
  String get neverSynced => 'Jamais synchronisé';

  @override
  String get signOutButton => 'Se déconnecter';

  @override
  String get signedOutMessage =>
      'Déconnecté. Vos données locales restent sur l\'appareil.';

  @override
  String get deleteAccountButton => 'Supprimer le compte';

  @override
  String get deleteAccountStep1Title => 'Supprimer le compte ?';

  @override
  String get deleteAccountStep1Body =>
      'Toutes vos sauvegardes cloud et votre compte seront supprimés définitivement. Les données locales restent intactes.';

  @override
  String get deleteAccountStep2Title => 'Confirmer la suppression définitive';

  @override
  String get deleteAccountStep2Body =>
      'Cette action est irréversible. Supprimer définitivement votre compte et toutes vos données cloud ?';

  @override
  String get deleteAccountConfirmButton => 'Oui, supprimer définitivement';

  @override
  String get accountDeletedMessage =>
      'Compte et données cloud supprimés définitivement.';

  @override
  String get reloginRequiredTitle => 'Reconnexion requise';

  @override
  String get authErrUserNotFound => 'Aucun compte associé à cet e-mail.';

  @override
  String get authErrWrongPassword => 'Mot de passe incorrect.';

  @override
  String get authErrInvalidCredential => 'E-mail ou mot de passe invalide.';

  @override
  String get authErrInvalidEmail => 'Format d\'e-mail invalide.';

  @override
  String get authErrEmailInUse => 'Cet e-mail est déjà utilisé.';

  @override
  String get authErrWeakPassword =>
      'Mot de passe trop faible. 6 caractères minimum.';

  @override
  String get authErrNetwork => 'Problème réseau. Vérifiez votre connexion.';

  @override
  String get authErrRequiresRecentLogin =>
      'Par sécurité, déconnectez-vous puis reconnectez-vous avant de supprimer le compte.';

  @override
  String get authErrTooManyRequests =>
      'Trop de tentatives. Réessayez plus tard.';

  @override
  String get authErrUserDisabled => 'Ce compte a été désactivé.';

  @override
  String get authErrAccountExistsDifferent =>
      'Cet e-mail est lié à une autre méthode de connexion.';

  @override
  String get authErrOperationNotAllowed =>
      'Cette méthode de connexion n\'est pas activée.';

  @override
  String get authErrFirebaseUnavailable => 'Service de compte indisponible.';

  @override
  String get authErrUnknown =>
      'Erreur d\'authentification. Veuillez réessayer.';

  @override
  String get widgetTitle => 'Zettask · Aujourd\'hui';

  @override
  String get widgetEmptyText => 'Toutes les tâches du jour sont terminées.';

  @override
  String get repeatingTasksAndFollowingDeleted =>
      'Tâche récurrente et occurrences suivantes supprimées';

  @override
  String get noProjectTasksTitle => 'Aucune tâche dans ce projet';

  @override
  String noProjectTasksSubtitle(String project) {
    return 'Appuyez sur + pour ajouter une tâche à $project.';
  }

  @override
  String get addTaskToProjectTooltip => 'Ajouter une tâche au projet';

  @override
  String get noTagsSubtitle =>
      'Appuyez sur + pour créer des tags colorés pour vos tâches et notes.';

  @override
  String get tagOptionsTooltip => 'Options du tag';

  @override
  String get deleteTag => 'Supprimer le tag';

  @override
  String get addTagTooltip => 'Ajouter un tag';

  @override
  String get noTasksWithTag => 'Aucune tâche avec ce tag.';

  @override
  String get addTaskWithTagTooltip => 'Ajouter une tâche avec tag';

  @override
  String get tagNameHint => 'ex. Travail, Perso, Urgent';

  @override
  String get tagColorLabel => 'Couleur du tag';

  @override
  String get createTag => 'Créer le tag';

  @override
  String tagDeletedNamed(String name) {
    return 'Tag « $name » supprimé';
  }

  @override
  String get noTemplatesSubtitle =>
      'Enregistrez des structures de tâches fréquentes pour les recréer plus vite.';

  @override
  String get templateOptionsTooltip => 'Options du modèle';

  @override
  String get deleteTemplate => 'Supprimer le modèle';

  @override
  String get createTemplateTooltip => 'Créer un modèle';

  @override
  String templateDeletedNamed(String name) {
    return 'Modèle « $name » supprimé';
  }

  @override
  String get templateNameHint => 'ex. Sortie hebdomadaire';

  @override
  String get defaultTaskTitleLabel => 'Titre de tâche par défaut';

  @override
  String get defaultTaskTitleHint => 'ex. Préparer la mise en production';

  @override
  String get timeOptionalLabel => 'Heure (optionnel)';

  @override
  String get clearTimeTooltip => 'Effacer l\'heure';

  @override
  String get projectOptionalLabel => 'Projet (optionnel)';

  @override
  String get tagOptionalLabel => 'Tag (optionnel)';

  @override
  String get defaultSubtasksLabel => 'Sous-tâches par défaut';

  @override
  String get addTemplateSubtaskHint => 'Ajouter une sous-tâche...';

  @override
  String get saveTemplate => 'Enregistrer le modèle';

  @override
  String subtasksTotalCount(int count) {
    return '$count sous-tâches';
  }

  @override
  String get useTemplateButton => 'Utiliser un modèle';

  @override
  String get pickTemplateTitle => 'Choisir un modèle';

  @override
  String get repeatingTaskDeleted => 'Tâche récurrente supprimée';

  @override
  String get noRepeatingTasksSubtitle =>
      'Appuyez sur + pour créer des routines quotidiennes, hebdomadaires ou mensuelles.';

  @override
  String get addRepeatingTaskTooltip => 'Ajouter une tâche récurrente';

  @override
  String get editRepeatingTask => 'Modifier la tâche récurrente';

  @override
  String get newRepeatingTask => 'Nouvelle tâche récurrente';

  @override
  String get deleteTaskTooltip => 'Supprimer la tâche';

  @override
  String get scheduleLabel => 'Planification';

  @override
  String get startAndTimeLabel => 'Début et heure';

  @override
  String get dateRequiredForTime => 'Date requise';

  @override
  String get clearDateTooltip => 'Effacer la date';

  @override
  String get pickTimeFirstReminder =>
      'Choisissez d\'abord une heure pour activer les rappels.';

  @override
  String get notificationPermissionDenied =>
      'Les notifications sont désactivées. Activez-les dans les paramètres de l\'appareil.';

  @override
  String get pickDateFirstRepeat =>
      'Choisissez d\'abord une date pour configurer la répétition.';

  @override
  String get subtasksLabel => 'Sous-tâches';

  @override
  String subtasksWithCount(int count) {
    return 'Sous-tâches ($count)';
  }

  @override
  String get removeSubtaskTooltip => 'Supprimer la sous-tâche';

  @override
  String get addSubtaskTooltip => 'Ajouter une sous-tâche';

  @override
  String get moveAllOverdueMoved =>
      'Toutes les tâches en retard déplacées à aujourd\'hui';

  @override
  String get moveAllShort => 'Tout déplacer';

  @override
  String get noOverdueTasksSubtitle =>
      'Toutes les tâches des jours précédents sont terminées.';

  @override
  String get repeatingDeletePrompt => 'Que souhaitez-vous supprimer ?';

  @override
  String get repeatingEditPrompt => 'Que souhaitez-vous modifier ?';

  @override
  String get repeatingDeleteSingleSub =>
      'Supprimer uniquement cette occurrence';

  @override
  String get repeatingEditSingleSub => 'Modifier uniquement cette occurrence';

  @override
  String get repeatingDeleteFollowingSub =>
      'Supprimer celle-ci et toutes les suivantes';

  @override
  String get repeatingEditFollowingSub =>
      'Appliquer à celle-ci et toutes les suivantes';

  @override
  String get deviceCalendarTitle => 'Calendrier de l\'appareil';

  @override
  String get selectCalendarsLabel => 'Sélectionner les calendriers';

  @override
  String calendarsActiveCount(int selected, int total) {
    return '$selected/$total actifs';
  }

  @override
  String get showCalendarEventsTitle => 'Afficher les événements';

  @override
  String get showCalendarEventsSubtitle =>
      'Les événements s\'affichent chronologiquement en lecture seule.';

  @override
  String get calendarPermDeniedPermanentTitle =>
      'Accès au calendrier refusé définitivement';

  @override
  String get calendarPermRequiredTitle =>
      'Accès en lecture au calendrier requis';

  @override
  String get calendarPermDeniedPermanentDesc =>
      'Activez l\'accès au calendrier dans les Paramètres, puis appuyez sur Vérifier.';

  @override
  String get calendarPermRequiredDesc =>
      'Zettask demande uniquement l\'accès en lecture pour afficher vos événements.';

  @override
  String get openSettingsButton => 'Ouvrir les paramètres';

  @override
  String get checkAgainButton => 'Vérifier';

  @override
  String get noCalendarsFound => 'Aucun calendrier trouvé sur cet appareil.';

  @override
  String get eventDetailTitle => 'Détails de l\'événement';

  @override
  String get eventNotesLabel => 'Notes';

  @override
  String get calendarEventReadOnlyBanner =>
      'Événement du calendrier de l\'appareil (lecture seule).';

  @override
  String get markUncompletedSemantics => 'Marquer non terminée';

  @override
  String get markCompletedSemantics => 'Marquer terminée';

  @override
  String get deleteNoteTooltip => 'Supprimer la note';

  @override
  String repeatMonthlyDay(int day) {
    return 'Chaque mois · jour $day';
  }

  @override
  String get last30DaysSubtitle => '30 derniers jours';

  @override
  String get allTimeSubtitle => 'Depuis le début';

  @override
  String get taskCancelled => 'Tâche marquée comme annulée';

  @override
  String get taskRestored => 'Tâche réactivée';

  @override
  String get cancelledStatusLabel => 'Annulée';

  @override
  String get restoreTaskLabel => 'Réactiver';

  @override
  String get markCancelledSemantics => 'Marquer annulée';

  @override
  String get calendarPermFallbackHint =>
      'Si la demande n’apparaît pas, ouvrez les Paramètres de l’application pour autoriser le Calendrier manuellement.';

  @override
  String get calendarBadgeLabel => 'Calendrier';

  @override
  String get calendarSourceLabel => 'Calendrier';

  @override
  String get calendarLocationLabel => 'Lieu';

  @override
  String get calendarReadOnlyInfo =>
      'Synchronisé depuis le calendrier de l’appareil. Cet élément est en lecture seule et ne peut pas être modifié dans Zettask.';

  @override
  String get proBrandTitle => 'Zettask Pro';

  @override
  String get proBadge => 'PRO';

  @override
  String get proPaywallSubtitle =>
      'Synchronisation cloud, calendriers, verrouillage biométrique et thèmes OLED.';

  @override
  String proActiveBannerTitle(String plan) {
    return 'Actif — $plan';
  }

  @override
  String get proActiveBannerSubtitle => 'Merci de soutenir Zettask.';

  @override
  String get proUpgradeBannerSubtitle =>
      'Thème AMOLED, accents personnalisés, styles de widget et plus';

  @override
  String get proBenefitCloudSync => 'Synchronisation cloud et multi-appareils';

  @override
  String get proBenefitCalendar => 'Intégration calendrier et jours fériés';

  @override
  String get proBenefitAppLock =>
      'Verrouillage biométrique et confidentialité récents';

  @override
  String get proBenefitProjectsCsv => 'Projets illimités et export CSV';

  @override
  String get proBenefitCustomization =>
      'AMOLED noir pur, couleurs d\'accent et styles de widget';

  @override
  String get proPlanMonthlyTitle => 'Mensuel';

  @override
  String get proPlanMonthlyPrice => '1,99 € / mois';

  @override
  String get proPlanYearlyTitle => 'Annuel';

  @override
  String get proPlanYearlyPrice => '12,99 € / an';

  @override
  String get proPlanYearlyBadge => 'Meilleure offre';

  @override
  String get proPlanYearlySavings => 'Économisez ~43 %';

  @override
  String get proPlanLifetimeTitle => 'À vie';

  @override
  String get proPlanLifetimePrice => '29,99 €';

  @override
  String get proPlanLifetimeBadge => 'Paiement unique';

  @override
  String get proContinueButton => 'Continuer';

  @override
  String get proAlreadyActiveButton => 'Zettask Pro actif';

  @override
  String get proRestorePurchasesButton => 'Restaurer les achats';

  @override
  String get proLegalFootnote =>
      'Les abonnements se renouvellent automatiquement sauf résiliation. Annulez à tout moment via Google Play.';

  @override
  String get proStoreUnavailableMessage =>
      'La facturation Google Play n\'est pas encore disponible sur cet appareil. Réessayez plus tard.';

  @override
  String get proPurchaseSuccessMessage => 'Zettask Pro est maintenant actif.';

  @override
  String get proRestoreSuccessMessage =>
      'Votre achat Zettask Pro a été restauré.';

  @override
  String get proRestoreEmptyMessage =>
      'Aucun achat Zettask Pro actif trouvé sur ce compte.';

  @override
  String get proPurchaseFailedMessage =>
      'Impossible de finaliser l\'achat pour le moment. Veuillez réessayer.';

  @override
  String get debugProSimulationLabel => 'Mode développeur : Simulation Pro';

  @override
  String get amoledPureBlackTitle => 'AMOLED Noir Pur';

  @override
  String get amoledPureBlackSubtitle =>
      'Fond noir pur #000000 pour écrans OLED';

  @override
  String get customAccentSection => 'Couleur d\'accent personnalisée';

  @override
  String get accentMonochrome => 'Monochrome';

  @override
  String get accentSage => 'Sauge';

  @override
  String get accentIndigo => 'Indigo';

  @override
  String get accentTerracotta => 'Terre cuite';

  @override
  String get accentAmber => 'Ambre';

  @override
  String get widgetStyleSection => 'Style du widget d\'accueil';

  @override
  String get widgetStyleStandard => 'Standard';

  @override
  String get widgetStyleAmoled => 'AMOLED';

  @override
  String get widgetStyleTranslucent => 'Translucide';
}
